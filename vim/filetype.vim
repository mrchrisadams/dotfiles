augroup mkd
" markdown filetype file - if the file type has already been loaded, dropout
" to avoid setting markdownb filetype twice

if exists("did_load_filetypes")

  finish

endif

augroup markdown

  au! BufRead,BufNewFile *.mkd,*.markdown setfiletype mkd

augroup END
