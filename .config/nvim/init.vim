if &compatible
  set nocompatible
endif

" reset augroup
augroup MyAutoCmd
  autocmd!
augroup END

" dein settings {{{
" dein自体の自動インストール
let s:cache_home = empty($XDG_CACHE_HOME) ? expand('~/.cache') : $XDG_CACHE_HOME
let s:dein_dir = s:cache_home . '/dein'
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'
if !isdirectory(s:dein_repo_dir)
  call system('git clone https://github.com/Shougo/dein.vim ' . shellescape(s:dein_repo_dir))
endif
let &runtimepath = s:dein_repo_dir .",". &runtimepath
" プラグイン読み込み＆キャッシュ作成
let s:toml_file = fnamemodify(expand('<sfile>'), ':h').'/dein.toml'
if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)
  call dein#load_toml(s:toml_file)
  call dein#end()
  call dein#save_state()
endif
" 不足プラグインの自動インストール
if has('vim_starting') && dein#check_install()
  call dein#install()
endif
" }}}


" タイトル表示
set title
" シンタックスハイライトの有効化
syntax on
" タブ幅の設定
set tabstop=2
" \tの幅
set shiftwidth=2
" 自動インデント
set autoindent
set smarttab
" タブをスペースに変える
set expandtab
" 対応するカッコのハイライト
set showmatch
" 貼り付けモードとの切り替え
set pastetoggle=<C-E>
" カーソルが端まで来たら次の行に飛ばす
set whichwrap=b,s,h,l,<,>,[,]
" コロンとセミコロンの入れ替え
nnoremap ; :
nnoremap : ;
" backspaceの有効化
set backspace=indent,eol,start
" マウスの無効化
set mouse=
" ステータスライン
set statusline=%F%=[%l/%L]
