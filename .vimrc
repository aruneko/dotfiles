" プラグインが実際にインストールされるディレクトリ
let s:dein_dir = expand('~/.cache/dein')
" dein.vim 本体
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

" dein.vim がなければ github から落としてくる
if &runtimepath !~# '/dein.vim'
  if !isdirectory(s:dein_repo_dir)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
  endif
  execute 'set runtimepath^=' . fnamemodify(s:dein_repo_dir, ':p')
endif

" 設定開始
if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)

  " プラグインリストを収めた TOML ファイル
  if has('nvim')
    let g:rc_dir = '~/.config/nvim/rc'
  else
    let g:rc_dir = '~/.vim/rc'
  endif
  let s:toml      = g:rc_dir . '/dein.toml'
  let s:lazy_toml = g:rc_dir . '/dein_lazy.toml'

  " TOML を読み込み、キャッシュしておく
  call dein#load_toml(s:toml,      {'lazy': 0})
  call dein#load_toml(s:lazy_toml, {'lazy': 1})

  " 設定終了
  call dein#end()
  call dein#save_state()
endif

" もし、未インストールものものがあったらインストール
if dein#check_install()
  call dein#install()
endif

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
" 選択部分をクリップボードにコピー
vnoremap <c-c> "*y
" 選択部分をクリップボードに切り取り
vnoremap <c-x> "*d<Esc>
" ビジュアルモード中にbacspace,deleteで範囲削除
vnoremap <bs> d
vnoremap <delete> d
