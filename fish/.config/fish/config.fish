#zoxide init fish | source
pazi init fish | source

#if set -q SSH_CLIENT; or set -q SSH_TTY
    #source /usr/share/fish/tools/web_config/sample_prompts/default.fish
#else
    #source /usr/share/fish/tools/web_config/sample_prompts/informative_vcs.fish
#end

function bsixdec
    echo "$argv[1]" | base64 -d
end

function fish_remove_path
    # Move to the first position.
    fish_add_path -m "$argv[1]"
    # Remove the first element.
    set -e fish_user_paths[1]
end

#function z
    #if count $argv > /dev/null
        ##__zoxide_z $argv; and ls
        #pazi_cd $argv; and ls
    #else
        ##__zoxide_z; and ls
        #pazi_cd; and ls
    #end
#end

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

function urldecode
    echo -n "$argv[1]" | python3 -c "import sys; from urllib.parse import unquote; print(unquote(sys.stdin.read()));"
end

# Abbreviations.
abbr ca "cargo add --upgrade=minor"
abbr cb "cargo build"
abbr cbr "cargo build --release"
abbr cnl "cargo new --lib"
abbr cn "cargo new"
abbr cr "cargo run"
abbr cre "cargo run --example"
abbr crl "cargo release --no-dev-version"
abbr cs "cargo search"
abbr ct "cargo test"
abbr cu "cargo update"
abbr rustperf "perf record -F99 --call-graph dwarf"

# Aliases.
alias astow "sudo stow --no-folding --target=/"
alias cmake_uninstall "sudo xargs rm < install_manifest.txt"
alias cp "cp -i"
alias dcmake "cmake -DCMAKE_BUILD_TYPE=Debug .."
alias df "df -h"
alias fishconfig "nvim ~/.config/fish/config.fish"
alias flame "titanium file://(perf script | inferno-collapse-perf | inferno-flamegraph|psub)"
alias helixconfig "hx ~/.config/helix/config.toml"
alias i3config "nvim ~/.config/i3/config"
alias kepubify "kepubify -i"
alias ls "ls --color=auto -N"
alias mkdir "mkdir -p"
alias mpf "mpv --fs"
alias mpl "mpv --video-aspect-override=16:9"
alias mv "mv -i"
alias objdump "objdump -M intel-syntax"
alias nvimconfig "cd ~/.config/nvim; nvim init.vim"
alias perf-annotate "perf annotate -M intel"
alias playwright-trace "uv run -- playwright show-trace test-results/*/trace.zip"
alias rm "rm -i"
alias stow "stow --no-folding"
alias titaniumconfig "cd ~/.config/titanium; nvim config keys"
alias you "yt-dlp --restrict-filenames"
alias mp3you "you --ignore-errors --extract-audio --audio-format mp3 -o '%(title)s.%(ext)s'"
alias you720 "you -f 'bestvideo[height<=720]+bestaudio/best[height<=720]'"
alias zf 'z --pipe="fzf"'

function __fish_command_not_found_handler --on-event fish_command_not_found
    echo "fish: Unknown command '$argv'"
end

# Exports.
set -x EDITOR nvim
# Set man to use bat as its pager.
set -x MANPAGER "sh -c 'sed -u -e \"s/\\x1B\[[0-9;]*m//g; s/.\\x08//g\" | bat -p -lman'"
set -g fish_greeting

# Key bindings.
bind ctrl-backspace backward-kill-bigword

# Tide configuration.
set --global tide_left_prompt_items $tide_left_prompt_items private_mode
# TODO: use ✖ for conflicted icon.
set --global tide_git_color_conflicted CCB700
set --global tide_git_color_dirty FFFF00
set --global tide_git_color_operation 0000FF
set --global tide_git_color_staged 007700
set --global tide_git_color_stash 004700
set --global tide_git_color_untracked CC0000
set --global tide_git_color_upstream 004700
set --global tide_git_truncation_length 32
set --global tide_context_color_root FF0000
