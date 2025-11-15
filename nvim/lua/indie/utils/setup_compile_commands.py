import os, shlex
import json
from concurrent.futures import ThreadPoolExecutor, as_completed

def find_compile_commands(start_dir):
    compile_commands = []

    # Function to scan a directory and return paths of compile_commands.json
    def scan_directory(directory):
        found = []
        with os.scandir(directory) as it:
            for entry in it:
                if entry.is_dir(follow_symlinks=False):
                    # Store the subdirectory for parallel scanning
                    found.append(entry.path)
                elif entry.is_file() and entry.name == "compile_commands.json":
                    compile_commands.append(entry.path)
        return found

    # Use ThreadPoolExecutor for parallel processing
    with ThreadPoolExecutor() as executor:
        futures = {executor.submit(scan_directory, start_dir): start_dir}

        while futures:
            for future in as_completed(futures):
                subdirectories = future.result()
                # Submit scanning of subdirectories
                for subdirectory in subdirectories:
                    futures[executor.submit(scan_directory, subdirectory)] = subdirectory

                # Remove the completed future from the dictionary
                del futures[future]

    return compile_commands

def clean_command(entry):
    cwd = entry["directory"]
    tokens = shlex.split(entry["command"])

    new_tokens = []
    skip_next = False
    seen_includes = set()

    for i, tok in enumerate(tokens):
        # Normalize -I and -isystem
        if tok.startswith("-I"):
            path = tok[2:]
            if not os.path.isabs(path):
                path = os.path.normpath(os.path.join(cwd, path))
            if path not in seen_includes:
                new_tokens.append("-I" + path)
                seen_includes.add(path)
            continue

        if tok == "-isystem" and i + 1 < len(tokens):
            path = tokens[i + 1]
            if not os.path.isabs(path):
                path = os.path.normpath(os.path.join(cwd, path))
            if path not in seen_includes:
                new_tokens.extend(["-isystem", path])
                seen_includes.add(path)
            skip_next = True
            continue

        if skip_next:
            skip_next = False
            continue

        # Drop unnecessary flags for clangd
        if tok.startswith("--xtensa-core") or tok.startswith("--xtensa-system"):
            continue

        if tok.startswith("-o"):  # drop output file
            skip_next = True
            continue

        new_tokens.append(tok)

    entry["command"] = " ".join(new_tokens)
    return entry

   
def merge_json_files(file_list, output_file):
    merged_json = []
    
    for file in file_list:
        with open(file, 'r') as f:
            try:
                data = json.load(f)
                if isinstance(data, list):  # Assuming each file contains a JSON array
                    merged_json.extend(data)
                else:
                    print(f"Invalid JSON format in file: {file}")
            except json.JSONDecodeError as e:
                print(f"Error parsing JSON in file {file}: {e}")

    files_found  = set()

    duplicates_found : int = 0
    for i, entry in enumerate(merged_json):
        if entry["file"] in files_found:
            duplicates_found += 1
            del merged_json[i]
        else:
            merged_json[i] = clean_command(entry)

        files_found.add(entry["file"])
    

    with open(output_file, 'w') as outfile:
        json.dump(merged_json, outfile, indent=2)
    print(f"Found {len(file_list)} many compile_commands")
    print(f"Merged Compile Commands JSON written to {output_file}")

if __name__ == "__main__":
    output_filename = os.path.join(os.getcwd(), "compile_commands.json")
    if os.path.exists(output_filename):
        print("Old compile_commands.json found. Removing")
        os.remove(output_filename)

    start_directory = os.getcwd() # Start from the current directory

    compile_commands_files = find_compile_commands(start_directory)
    if len(compile_commands_files) > 0:
        merge_json_files(compile_commands_files, output_filename)
    else:
        print("No compile_commands.json files found.")

