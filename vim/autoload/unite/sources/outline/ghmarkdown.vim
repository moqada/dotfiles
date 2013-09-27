" vim-flavored-markdown で filetype が ghmarkdown になるのでその対応
function! unite#sources#outline#ghmarkdown#outline_info()
  return unite#sources#outline#defaults#markdown#outline_info()
endfunction
