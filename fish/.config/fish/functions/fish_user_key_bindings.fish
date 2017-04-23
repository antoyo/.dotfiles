function append_to_command
    commandline -a $argv[1]
    commandline -C 999999999
end

function cd_left
    set directory (pwd)
    cd ..
    if test (pwd) != "$directory"
        set -g directory_history $directory $directory_history
    end
    commandline -f repaint
end

function cd_right
    if test -n "$directory_history"
        set directory $directory_history[1]
        if test (count $directory_history) -eq 1
            set -e directory_history
        else
            set -g directory_history $directory_history[2..-1]
        end
        cd $directory
        commandline -f repaint
    end
end

function prepend_to_command
    set position (commandline -C)
    commandline -C 0
    commandline -i $argv[1]
    set new_position (expr length + $argv[1] + $position)
    commandline -C $new_position
end

function fish_user_key_bindings
    bind \ea cd_left
    bind \ee cd_right
    bind \el 'append_to_command " | less"'
    bind \es 'prepend_to_command "sudo "'
end
