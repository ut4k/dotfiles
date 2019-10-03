"environment variables{{{
let $DESKTOP   = "C:/Users/kimura.AZET/Desktop"
let $WORKSPACE = "/d/workspace"
let $SURALA    = "/d/workspace/surala"
"}}}

let g:winwd =   substitute(getcwd(), "^/mnt", "", "g")

"エントリー側にいるか？
let g:on_ent_dir = 0

if winwd == $SURALA.'/ent'
  let g:on_ent_dir = 1
endif

"エントリー用設定
if g:on_ent_dir == 1
  let g:ctrlp_custom_ignore = '\v[\/]\.(git|svn|ico|swp|jpg|jpeg|png|gif|www|_www|opt)$'
  "コア用設定
else
  let g:ctrlp_custom_ignore = '\v[\/]\.(git|svn|ico|swp|jpg|jpeg|png|gif|swf|uranai_lib/templates_c|opt)$'
endif

let g:worker = "kimura"
let g:studentid = "10193393"
let g:teacherid = "5000000072"

let g:current_project = ""
"let g:current_project = "生徒画面TOP改修_ログ出力"
"let g:current_project = "google連携"
"let g:current_project = "すらら学習時間・クリアユニット数不正対策"
"let g:current_project = "生徒画面TOP改修FB修正"
"let g:current_project = "漢字学習コンテンツFB対応"
let g:current_project = "Entry_理社対応開発"

"-- mapping
" nnoremap <leader>gct :!/usr/local/bin/ctags -R --exclude=.svn --exclude=node_modules --exclude=_test --exclude=smarty --exclude="*.min.*" --exclude=.git --langmap=php:.php.inc --PHP-kinds=+cf-v --exclude=material<CR>
nnoremap <leader>gct :!/usr/local/bin/ctags -R<CR>
nnoremap <leader>gpt :!php ~/phpctags/phpctags.phar -R --kinds=dficpmnt<CR>
nnoremap <leader>mf :e ~/notes/mod_report.txt<CR>
nnoremap <leader>fn :let @"=expand("%")<CR>

"コミットポップアップ
noremap cm :call SvnCommitSrl()<CR>
"ライブラリを開く openlib
nnoremap <leader>ol :call OpenLibSrl()<CR>
"入り口プログラムを開く openentry
nnoremap <leader>oe :call OpenEntrySrl()<CR>
"TODOをgrep
nnoremap <leader>gtd :GrepperRg "(debug\|TODO).*kimura"
"find debug comments
nnoremap <leader>fd /debug\\|TODO\s*\(start\\|end\)*\s*kimura<CR>
"find my comments
nnoremap <leader>fm /\(add\\|update\\|del\\|debug\\|TODO\)\s*\(start\\|end\)*\s*kimura<CR>
"et edited today 今日の編集コメントを検索
nnoremap <leader>et :let @t = strftime("%Y\\/%m\\/%d")<CR>/<C-R>t<CR>
"et edited yesterday 昨日の編集コメントを検索
nnoremap <leader>ey :let @t = strftime("%Y\\/%m\\/%d", localtime() - (60*60*24))<CR>/<C-R>t<CR>

function! SvnCommitSrl()
  let user_option = &guioptions
  set guioptions-=v
  let choice = confirm("コミットしますか？", "Yes\nNo")
  if choice == 0
    echo "コミットをキャンセルしました。"
  elseif choice == "1"
    " exec '! ~/scripts/svnlogging.sh'
    exec '! ~/scripts/svnlogging.sh'
  elseif choice == 2
    echo "コミットをキャンセルしました。"
  else
    echo "エラー: "
  endif
  let &guioptions = user_option
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
