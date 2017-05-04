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

function docx2txt
    docx2txt.pl $argv[1] /dev/stdout
end

function traden
    trans -brief :en "$argv"
end

function tradfr
    trans -brief :fr "$argv"
end

# Aliases.
alias astow "sudo stow --target=/"
alias ca "cargo add --upgrade=minor"
alias cb "cargo build"
alias cbr "cb --release"
alias cmake_uninstall "sudo xargs rm < install_manifest.txt"
alias cn "cargo new"
alias cnb "cargo new --bin"
alias cp "cp -i"
alias cr "cargo run"
alias cre "cargo run --example"
alias crl "cargo release --no-dev-version"
alias ct "cargo test"
alias cu "cargo update"
alias dcmake "cmake -DCMAKE_BUILD_TYPE=Debug .."
alias df "df -h"
alias fishconfig "nvim ~/.config/fish/config.fish"
alias flame "titanium file://(perf script | stackcollapse-perf | flamegraph|psub)"
alias i3config "nvim ~/.config/i3/config"
alias ls "ls --color=auto -N"
alias mkdir "mkdir -p"
alias mount "udisksctl mount -b"
alias mount_cd "udisksctl mount -b /dev/sr0"
alias mv "mv -i"
alias nvimconfig "cd ~/.config/nvim; nvim init.vim"
alias pcf "pacaur -Si"
alias pci "pacaur -S"
alias pcr "pacaur -Rsn"
alias pcs "pacaur -Ss"
alias pcu "pacaur -Syu"
alias perf-annotate "perf annotate -M intel"
alias reminders "nvim ~/.config/remind/reminders.rem"
alias rm "rm -i"
alias titaniumconfig "cd ~/.config/titanium; nvim config keys"
alias trc "transmission-remote-cli"
alias unmount "udisksctl unmount -b"
alias unmount_cd "udisksctl unmount -b /dev/sr0"
alias urlsnews "nvim ~/.config/newsbeuter/urls"
alias you "youtube-dl --no-playlist"

function __fish_command_not_found_handler --on-event fish_command_not_found
    echo "fish: Unknown command '$argv'"
end
