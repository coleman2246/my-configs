use std/util "path add"

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


