function rustc-josh-sync --wraps rustc-josh-sync
    GIT_CONFIG_GLOBAL=$HOME/.config/git/josh.gitconfig RUSTC_GIT=$HOME/Ordinateur/Programmation/Rust/Projets/rust command rustc-josh-sync $argv
end
