$env.config = {
    edit_mode : "vi",
    show_banner : false,
    buffer_editor : 'nvim'
}

$env.config.history = {
  file_format: sqlite
  max_size: 1_000_000
  sync_on_enter: true
  isolation: true
}

$env.config = {
    show_banner : false 
    edit_mode : vi
}


$env.config.history = {
    file_format: sqlite
    max_size: 1_000_000
    sync_on_enter: true
    isolation: true
}

source ./nu_scripts/themes/nu-themes/classic-dark.nu
source $"($nu.home-path)/.cargo/env.nu"

#~/.config/nushell/config.nu
source ~/.cache/carapace/init.nu


