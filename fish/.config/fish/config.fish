zoxide init fish | source

if set -q SSH_CLIENT; or set -q SSH_TTY
    source /usr/share/fish/tools/web_config/sample_prompts/classic_status.fish
else
    source /usr/share/fish/tools/web_config/sample_prompts/informative_vcs.fish
end

function bsixdec
    echo "$argv[1]" | base64 -d
end

function z
    if count $argv > /dev/null
        __zoxide_z $argv; and ls
    else
        __zoxide_z; and ls
    end
end

function cd
    if count $argv > /dev/null
        builtin cd "$argv"; and ls
    else
        builtin cd ~; and ls
    end
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

function tpb
    torrench -t "$argv"
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
alias helixconfig "cd ~/.config/helix; helix config.toml"
alias i3config "nvim ~/.config/i3/config"
alias ls "ls --color=auto -N"
alias mkdir "mkdir -p"
alias mpf "mpv --fs"
alias mpl "mpv --video-aspect-override=16:9"
alias mv "mv -i"
alias objdump "objdump -M intel-syntax"
alias nvimconfig "cd ~/.config/nvim; nvim init.vim"
alias perf-annotate "perf annotate -M intel"
alias rm "rm -i"
alias stow "stow --no-folding"
alias swayconfig "nvim ~/.config/sway/config"
alias titaniumconfig "cd ~/.config/titanium; nvim config keys"
alias urlsnews "nvim ~/.config/newsboat/urls"
alias you "youtube-dl --no-playlist"
alias mp3you "youtube-dl --ignore-errors --extract-audio --audio-format mp3 -o '%(title)s.%(ext)s'"

function __fish_command_not_found_handler --on-event fish_command_not_found
    echo "fish: Unknown command '$argv'"
end

# Exports.
set -x BROWSER titanium
set -x EDITOR nvim
set -x TITANIUM_EXTENSION_INSTALL_PATH /usr/local/lib/titanium/web-extensions
