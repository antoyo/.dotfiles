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
    autocmd VimEnter /tmp/mutt* :call IsReply()
    autocmd VimEnter /tmp/mutt* :execute 'startinsert'
augroup END

setlocal spell
setlocal tw=72
setlocal fo=aw
