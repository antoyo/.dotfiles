set disassembly-flavor intel
set disassemble-next-line on
set debuginfod enabled off
set history save on
define all_bt
    thread apply all bt
end
add-auto-load-safe-path /home/bouanto/Ordinateur/Programmation/Projets/linux-cg-gcc
set substitute-path /usr/src/debug/gcc /home/bouanto/Ordinateur/Programmation/Projets/gcc-repo/gcc
define no_signal_break
    handle all nostop pass
end
