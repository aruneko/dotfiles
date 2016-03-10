" dein.vimのディレクトリ
let s:dein_dir = expand('~/.config/nvim/dein')
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

" なければgit clone
if !isdirectory(s:dein_repo_dir)
  execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
  endif
  execute 'set runtimepath^=' . s:dein_repo_dir

call dein#begin(s:dein_dir)

" 管理するプラグインを記述したファイル
let s:toml = '~/.config/nvim/dein/dein.toml'
let s:lazy_toml = '~/.config/nvim/dein/dein_lazy.toml'

" 読み込み、キャッシュは :call dein#clear_cache() で消せます
if dein#load_cache([expand('<sfile>', s:toml, s:lazy_toml)])
  call dein#load_toml(s:toml, {'lazy': 0})
  call dein#load_toml(s:lazy_toml, {'lazy': 1})
  call dein#save_cache()
endif

call dein#end()

" もし、未インストールものものがあったらインストール
if dein#check_install()
  call dein#install()
endif

"個人設定
set title
syntax on
set tabstop=2
set shiftwidth=2
set smartindent
set autoindent
set smarttab
set expandtab
set showmatch
set pastetoggle=<C-E>
set whichwrap=b,s,h,l,<,>,[,]

