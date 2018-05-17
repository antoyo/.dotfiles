function fish_prompt
    set last_status $status
    set_color $fish_color_cwd
    printf '%s ' (prompt_pwd)
    set_color normal
end

function add_event
    ics2rem $argv[1] >> ~/.config/remind/reminders.rem
end

function mkc
    mkdir $argv[1]; cd $argv[1]
end

function docx
    docx2txt $argv[1] -
end

function traden
    trans -brief :en "$argv"
end

function tradfr
    trans -brief :fr "$argv"
end

# Abbreviations.
abbr cb "cargo build"
abbr cbr "cargo build --release"
abbr cnl "cargo new --lib"
abbr cn "cargo new"
abbr cr "cargo run"
abbr cre "cargo run --example"
abbr ct "cargo test"

# Aliases.
alias astow "sudo stow --target=/"
alias ca "cargo add --upgrade=minor"
alias cmake_uninstall "sudo xargs rm < install_manifest.txt"
alias cp "cp -i"
alias crl "cargo release --no-dev-version"
alias cs "cargo search"
alias cu "cargo update"
alias dcmake "cmake -DCMAKE_BUILD_TYPE=Debug .."
alias df "df -h"
alias fishconfig "nvim ~/.config/fish/config.fish"
alias flame "titanium file://(perf script | stackcollapse-perf | flamegraph|psub)"
alias i3config "nvim ~/.config/i3/config"
alias ls "ls --color=auto -N"
alias ls-read "getfattr -n user.read *.pdf ^ /dev/null | rg '# file:' | cut -c 9-"
alias ls-unread "getfattr -n user.read *.pdf ^&1 | rg Attribut | cut -d: -f1"
alias mkdir "mkdir -p"
alias mount "udisksctl mount -b"
alias mount_cd "udisksctl mount -b /dev/sr0"
alias mpl "mpv --video-aspect=16:9"
alias mv "mv -i"
alias nvimconfig "cd ~/.config/nvim; nvim init.vim"
alias pcf "pikaur -Si"
alias pci "pikaur -S"
alias pcr "pikaur -Rsn"
alias pcs "pikaur -Ss"
alias pcu "pikaur -Syu"
alias perf-annotate "perf annotate -M intel"
alias reminders "nvim ~/.config/remind/reminders.rem"
alias rm "rm -i"
alias set-read "setfattr -n user.read -v true"
alias titaniumconfig "cd ~/.config/titanium; nvim config keys"
alias trc "transmission-remote-cli"
alias unmount "udisksctl unmount -b"
alias unmount_cd "udisksctl unmount -b /dev/sr0"
alias urlsnews "nvim ~/.config/newsboat/urls"
alias you "youtube-dl --no-playlist"

function __fish_command_not_found_handler --on-event fish_command_not_found
    echo "fish: Unknown command '$argv'"
end
