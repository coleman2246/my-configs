use std/util "path add"
use std

alias xc = xclip -selection clipboard
alias fd = fdfind

let data = (ssh-agent | lines | split row "=" | split column ";" | get column1)

$env.SSH_AUTH_SOCK = ($data | get 1)
$env.SSH_AGENT_PID = ($data | get 3)
ssh-add .ssh/id_rsa out+err> /dev/null


$env.CARAPACE_BRIDGES = 'zsh,fish,bash,inshellisense' # optional
mkdir ~/.cache/carapace
carapace _carapace nushell | save --force ~/.cache/carapace/init.nu

$env.EDITOR = "nvim"

