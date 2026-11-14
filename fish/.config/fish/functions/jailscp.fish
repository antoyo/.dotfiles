function jailscp
    set --local base_directory '~/firejail/firejail-fish-home'

    if test (count $argv) -eq 0
        echo 'usage: jailscp FILE... [:SUBPATH]' >&2
        return 1
    end

    set --local destination $base_directory
    if string match --quiet -- ':*' $argv[-1]
        set destination $base_directory/(string sub --start 2 -- $argv[-1] | string trim --left --chars /)
        set --erase argv[-1]
    end

    if test (count $argv) -eq 0
        echo 'jailscp: no files to copy' >&2
        return 1
    end

    scp -r -- $argv arch-carbon:$destination/
end
