" 型チェック
let g:flow#enable = 0

" quickfixで開く
let g:flow#autoclose = 1

" 補完
let g:flow#omnifunc = 1

if !exists("g:flow#flowpath")
  " Search for a local version of flow
  let s:npm_local_flowpath = finddir("node_modules", ".;") . "/.bin/flow"
  if filereadable(s:npm_local_flowpath)
    let g:flow#flowpath = s:npm_local_flowpath
  else
    let g:flow#flowpath = "flow"
  endif
endif
