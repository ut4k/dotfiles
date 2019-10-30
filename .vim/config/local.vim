let $DESKTOP   = "/c/Users/kimura.AZET/Desktop"
let $WORKSPACE = "/d/workspace"
let $SURALA    = "/d/workspace/surala"

let g:winwd =   substitute(getcwd(), "^/mnt", "", "g")

"エントリー側にいるか？
let g:on_ent_dir = 0
if winwd == $SURALA.'/ent' | let g:on_ent_dir = 1 | endif

"コミットポップアップ
noremap cm :call SvnCommitSrl()<CR>
"ライブラリを開く openlib
nnoremap <leader>ol :call OpenLibSrl()<CR>
"入り口プログラムを開く openentry
nnoremap <leader>oe :call OpenEntrySrl()<CR>
"TODOをgrep
nnoremap <leader>gtd :GrepperRg "(debug\|TODO).*kimura"<CR>
"find debug comments
nnoremap <leader>fd /debug\\|TODO\s*\(start\\|end\)*\s*kimura<CR>
"find my comments
nnoremap <leader>fm /\(add\\|update\\|del\\|debug\\|TODO\)\s*\(start\\|end\)*\s*kimura<CR>
"et edited today 今日の編集コメントを検索
nnoremap <leader>et :let @t = strftime("%Y\\/%m\\/%d")<CR>/<C-R>t<CR>
"et edited yesterday 昨日の編集コメントを検索
nnoremap <leader>ey :let @t = strftime("%Y\\/%m\\/%d", localtime() - (60*60*24))<CR>/<C-R>t<CR>

function! SvnCommitSrl()
  let l:repopath =   substitute(getcwd(), "^/mnt", "", "g")
  let l:repopath =   substitute(l:repopath, "/d/", "D:/", "g")
  call system("TortoiseProc.exe /command:commit /logmsg:'".g:worker."' /path:'".l:repopath."' /closeonend:3")
endfunction

"ライブラリ側を開く
function! OpenLibSrl()
  let l:f = expand('%')
  let l:plist = split(l:f, "/")
  let l:path1 = l:plist[0]
  if l:path1 == "_www"
    echo "すでにライブラリファイルを開いています!!"
    return
  endif
  let l:path2 = l:plist[1]
  let l:path1 = substitute(l:path1, "www", "_www", "")
  let l:path2 = l:path2 . "_lib"
  let l:libpath = l:path1 . "/" . l:path2 . "/" . l:plist[2]
  execute 'edit' l:libpath
endfunction

"入り口プログラムを開く
function! OpenEntrySrl()
  let l:f = expand('%')
  let l:plist = split(l:f, "/")
  let l:path1 = l:plist[0]
  if l:path1 == "www"
    echo "すでに入り口ファイルを開いています!!"
    return
  endif
  let l:path2 = l:plist[1]
  let l:path1 = substitute(l:path1, "_www", "www", "")
  let l:path2 = substitute(l:path2, "_lib", "", "")
  let l:entrypath = l:path1 . "/" . l:path2 . "/" . l:plist[2]
  execute 'edit' l:entrypath
endfunction

"tplでもjs構文でハイライトする
augroup hiAsJs
  autocmd!
  autocmd BufRead *_js.tpl set ft=javascript 
augroup END
