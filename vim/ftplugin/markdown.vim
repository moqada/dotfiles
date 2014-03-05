" @see http://qiita.com/naoty_k/items/56eddc9b76fe630f9be7
" vimでtodoリストを書くためのtips

" todoリストを簡単に入力する
abbreviate tl - [ ]

" 入れ子のリストを折り畳む
setlocal foldmethod=indent

" todo リストのon/offを切り替える
nnoremap <buffer> <Leader><Leader> :call ToggleCheckbox()<CR>
vnoremap <buffer> <Leader><Leader> :call ToggleCheckbox()<CR>

" 選択行のチェッボックスを切り替える
function! ToggleCheckbox()
    let l:line = getline('.')
    if l:line =~ '\-\s\[\s\]'
        let l:result = substitute(l:line, '-\s\[\s\]', '- [x]', '')
        call setline('.', l:result)
    elseif l:line =~ '\-\s\[x\]'
        let l:result = substitute(l:line, '-\s\[x\]', '- [ ]', '')
        call setline('.', l:result)
    end
endfunction

setlocal shiftwidth=2
setlocal softtabstop=2
