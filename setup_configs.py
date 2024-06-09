import os
import shutil
import sys
import subprocess


home = os.path.expanduser("~")

config_dir=os.path.join(home, ".dotfiles")

repo_link = "https://github.com/coleman2246/my-configs.git"


targets = {
        os.path.join(home, ".config/nvim") : "vim",
        os.path.join(home, ".config/sway/config") : "i3/config",
        os.path.join(home, ".ssh/config") : "ssh/config"
}

if len(sys.argv) == 2 and sys.argv[1] == "clean":
    print("Cleaning configs")

    if os.path.isdir(config_dir):
        shutil.rmtree(config_dir)
        print("Remove Dot Files")

    for target_path, config_path in targets.items():
        print(f"Removing Target : {target_path}")
        if os.path.islink(target_path):
            os.unlink(target_path)
        elif os.path.isfile(target_path):
            os.remove(target_path)
        elif os.path.isdir(target_path):
            shutil.rmtree(target_path)
        else:
            print(f"Failed Removing Target : {target_path}")

    print("Done Cleaning")
    exit(0)

if not os.path.isdir(config_dir):
    cmd = ["git","clone",repo_link, config_dir]
    result = subprocess.run(cmd)
    code = result.returncode
    if code != 0 :
        raise ValueError(f"Non Zero exit code on git clone : {code}")

for target_path, config_path in targets.items():
    config_path_abs = os.path.join(config_dir, config_path)

    if os.path.isfile(config_path_abs) or os.path.isdir(config_path_abs):
        dir_name = os.path.dirname(target_path)
        if not os.path.exists(dir_name):
            os.makedirs(dir_name)
            print(f"Making Parent dir: {dir_name}")


    if not os.path.exists(target_path):
        print(f"Creating Link : {config_path_abs} -> {target_path}")
        os.symlink(config_path_abs, target_path)
    else:
        print(f"Link Already Exists : {config_path_abs} -> {target_path}")



