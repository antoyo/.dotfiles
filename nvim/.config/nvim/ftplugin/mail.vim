function IsReply()
    if line('$') > 1
        :%!par w72q
        :%s/^.\+\ze\n\(>*$\)\@!/\0 /e
        :%s/^>*\zs\s\+$//e
        :1
        :put! =\"\n\n\"
        :1
    endif
endfunction

augroup mail_filetype
    autocmd!
    autocmd VimEnter /tmp/neomutt* :call IsReply()
    autocmd VimEnter /tmp/neomutt* :execute 'startinsert | redraw'
augroup END

setlocal spell
setlocal tw=72
setlocal fo=aw
