" readme {{{
" put plug.vim in autoload dir
" https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
" key bind
" leader 2 nerdtree, leader 3 tagbar
" cpp: leader 5 make, leader 6 run demo
" python: F5 use python in environment, F6 use user defined python path
" use config file in another machine need to do some modification
" use eslint
" JS optional dependency
" js-beautify eslint_d jsctags
" linux {{{
" font: DejaVu\ Sans\ Mono\
" DejaVuSansMono
" use fcitx.vim instead of vimim
" install ctags
" set syntastic
" syntastic_python_python_exec="xxx", pyflakes
" set python path which installed by pyenv
" set youcompleteme
" remove python for ycm's blacklist
" let g:ycm_python_binary_path = 'python'  // have jedi
" .tern-config  // not support multiple tern servers
" .ycm_extra_conf.py for cpp
" add a plugin to support django, but have the influence on speed
" }}}
" window {{{
" font: yahei_mono and DejaVu
" need config eslint_d path, vimwiki path
" check executable('cl') use ycm or not
" }}}

"}}}
set nocompatible              " be iMproved, required
" auto install plug-vim {{{
if has("win32")
    if empty(glob('~/vimfiles/autoload/plug.vim')) &&  executable('curl')
        cd $HOME
        silent !curl -fLo vimfiles/autoload/plug.vim --create-dirs
                    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
        autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
    endif
    call plug#begin('~/vimfiles/bundle')
else
    if empty(glob('~/.vim/autoload/plug.vim')) &&  executable('curl')
        silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
                    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
        autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
    endif
    call plug#begin('~/.vim/bundle')
endif
" }}}
" packages {{{
Plug 'kien/ctrlp.vim'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'Lokaltog/vim-easymotion'
Plug 'vim-scripts/matchit.zip'
Plug 'mattn/emmet-vim'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'vimwiki/vimwiki'
Plug 'mattn/calendar-vim', {'for': 'vimwiki'}
Plug 'jiangmiao/auto-pairs'
Plug 'godlygeek/tabular'
Plug 'bling/vim-airline'
Plug 'tpope/vim-fugitive'
Plug 'majutsushi/tagbar'
Plug 'Valloric/ListToggle'
Plug 'vim-scripts/Modeliner'
"Plug 'w0rp/ale'
Plug 'vim-syntastic/syntastic'
Plug 'Shougo/unite.vim'
Plug 'roxma/vim-paste-easy'
"Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
"Plug 'Shougo/denite.nvim'
" Colorscheme
"Plug 'altercation/vim-colors-solarized'
"Plug 'ericbn/vim-solarized'
Plug 'lifepillar/vim-solarized8'

" lazy load {{{
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
" }}}

if has("win32")
    if executable('cl')
        Plug 'Valloric/YouCompleteMe', { 'on': [] }
    else
        Plug 'Shougo/neocomplete.vim'
        Plug 'davidhalter/jedi-vim'
        Plug 'ternjs/tern_for_vim'
    endif
elseif has("unix")
    Plug 'Valloric/YouCompleteMe', { 'on': [] }
    "Plug 'godlygeek/csapprox'
    Plug 'lilydjwg/fcitx.vim'
    "Plug 'tweekmonster/django-plus.vim'
    "Plug 'eagletmt/ghcmod-vim'
    "Plug 'eagletmt/neco-ghc'
endif
" web development
Plug 'sheerun/vim-polyglot'
Plug 'hail2u/vim-css3-syntax'
"Plug 'maksimr/vim-jsbeautify'
Plug 'Chiel92/vim-autoformat', {'on': 'Autoformat'}
"Plug 'pangloss/vim-javascript'
"Plug 'cakebaker/scss-syntax.vim'
"Plug 'leafgarland/typescript-vim'
"Plug 'mxw/vim-jsx'
"Plug 'posva/vim-vue'
"Plug 'neovimhaskell/haskell-vim'
" typescript
Plug 'Shougo/vimproc.vim', {'do': 'make'}
Plug 'Quramy/tsuquyomi'
" need UltiSnips
"Plug 'justinj/vim-react-snippets'
"}}}
call plug#end()


let mapleader="\<Space>"
"let g:mapleader=";"
set bs=2 "set backspace=indent,eol,start
"set mouse=a
filetype plugin on
"setting for linux {{{
if has("unix")
    set guifont=DejaVu\ Sans\ Mono\ 13
    "set guifont=Yahei\ Mono\ 13
    "set guifont=Source\ Code\ Pro\ 13
    let g:vimwiki_use_mouse = 1
    "    let g:vimwiki_list = [{'path': '~/vimwiki/',
    "    \ 'path_html': '~/vimwiki/html/',
    "    \ 'html_header': '~/vimwiki/template/header.tpl',}]
    let wiki_1 = {}
    let wiki_1.path = '~/vimwiki/'
    let wiki_1.html_template = "~/vimwiki/template/header.tpl"
    let wiki_1.nested_syntaxes = {'python': 'python', 'c++': 'cpp'}
    let wiki_1.path_html = '~/vimwiki/html/'

    let wiki_2 = {}
    let wiki_2.path = '~/my_notes/'
    let wiki_2.index = 'my_markdown_notes'
    let wiki_2.syntax = 'markdown'
    let wiki_2.ext = '.md'

    let g:vimwiki_list = [wiki_2, wiki_1]
    map <silent> <Leader>ee :e $HOME/.vim/vimrc<cr>
    " has gui  gvim
    "key binding for compile or run {{{
    au BufRead,BufNewFile *.c nmap <Leader>5 :w<CR>:!gcc -Wall % -g -o %<<CR>
    au FileType cpp nmap <Leader>5 :update<CR>:!g++ -Wall % -g -o %<<CR>
    "au FileType cpp nmap <F9> :update<CR>:!g++ -Wall % -g -o demo<CR>
    au FileType c,cpp nmap <Leader>6 :!./%<<CR>
    au FileType c,cpp nmap <F5> :update<CR>:make<CR>
    au FileType c,cpp nmap <F6> :!./demo<CR>
    au FileType sh nmap <Leader>5 :update<CR>:!bash %<CR>
    autocmd BufRead,BufNewFile *.py nmap <Leader>5 :update<CR>:!python %<CR>
    autocmd BufRead,BufNewFile *.py nmap <Leader>6 :update<CR>:!$HOME/.pyenv/versions/env3/bin/python %<CR>
    autocmd BufRead,BufNewFile *.hs nmap <F5> :update<CR>:!runghc %<CR>
    autocmd BufRead,BufNewFile *.hs nmap <F6> :update<CR>:!ghci %<CR>
    au BufNewFile,BufRead *.coffee nmap <F5> :update<CR>:!coffee -c %<CR>:!node %<.js <CR>
    "au BufRead,BufNewFile *.scm nmap <F5> :w<CR>:!mit-scheme --load %<CR>
    autocmd BufRead,BufNewFile *.rkt,*scm nmap <F5> :update<CR>:!racket %<CR>
    autocmd BufRead,BufNewFile *.js nmap <Leader>5 :update<CR>:!node %<CR>
    "}}}
    "autocmd FileType javascript set dictionary=~/.vim/dict/javascript.dict
    "autocmd FileType html set dictionary=~/.vim/dict/bootstrap.dict
    "au FileType c set dictionary=~/.vim/dict/c.dict
    " test pluins' setting for linux
    augroup load_us_ycm
        autocmd!
        autocmd InsertEnter * call plug#load('YouCompleteMe')
                    \| autocmd! load_us_ycm
    augroup END
endif
"'python' : 1
"end of setting for linux}}}
if has("gui_running")
    " 只显示菜单
    set guioptions=
    set background=dark "dark light
    colorscheme solarized8_dark "desertEx solarized molokai desert hybrid
    set lines=44
    set columns=90
    " 高亮光标所在的行
    "set cursorline
    "setting for windows {{{
    if has("win32")
        " Windows 兼容配置
        set guifont=DejaVu_Sans_Mono:h13:cANSI
        set guifontwide=Yahei_Mono:b:h13:cGB2312
        "autocmd GUIEnter * simalt ~x "最大化gvim
        "source $VIMRUNTIME/mswin.vim
        source $VIMRUNTIME/menu.vim
        source $ViMRUnTIME/delmenu.vim
        "source $VIMRUNTIME/vimrc_example.vim
        "set fileformats=dos
        "解决consle输出乱码
        language messages zh_CN.utf-8
        au BufRead,BufNewFile *.txt setlocal ft=txt "syntax highlight for txt.vim
        " compile and run {{{
        func! Interpreter()
            if &filetype=='scheme'
                exec "w"
                exec "!\"D:\\MIT-GNU Scheme\\bin\\mit-scheme.exe\" --library \"d:\\MIT-GNU Scheme\\lib\" --load ".expand("%:p")
            endif
        endfunc
        map <silent> <Leader>ee :e ~/vimfiles/vimrc<cr>
        au BufRead,BufNewFile *.py nmap <Leader>5 :update<CR>:!python %<CR>
        au BufRead,BufNewFile *.py nmap <Leader>6 :w<CR>:!"c:\Python27\python.exe" %<CR>
        autocmd BufRead,BufNewFile *.scm map <F5> :w<CR>:call Interpreter()<CR>
        autocmd BufRead,BufNewFile *.rkt,*scm nmap <F6> :w<CR>:!racket %<CR>
        "autocmd BufRead *.py nmap <C-F5> :w<CR>:!idle.py -r %<CR>
        autocmd BufRead *.py nmap <C-F5> :w<CR>:!ipython -i %<CR>
        "autocmd BufRead *.py nmap <S-F5> :w<CR>:!idle.py -e %<CR>
        au BufRead,BufNewFile *.c nmap <F9> :w<CR>:!gcc -Wall % -g -o %<.exe<CR>
        au FileType cpp nmap <F9> :w<CR>:!gcc++ -Wall % -g -o %<.exe<CR>
        au FileType c,cpp nmap <C-F9> :!./%<.exe<CR>
        autocmd BufRead,BufNewFile *.js nmap <Leader>5 :update<CR>:!node %<CR>
        " }}}
        "vimwiki
        let g:vimwiki_use_mouse = 1
        "    let g:vimwiki_list = [{'path': '~/vimwiki/',
        "    \ 'path_html': '~/vimwiki/html/',
        "    \ 'html_header': '~/vimwiki/template/header.tpl',}]
        let wiki_1 = {}
        let wiki_1.path = 'F:/vimwiki/'
        let wiki_1.html_template = "F:/vimwiki/template/header.tpl"
        let wiki_1.nested_syntaxes = {'python': 'python', 'c++': 'cpp'}
        let wiki_1.path_html = 'F:/vimwiki/html/'

        let wiki_2 = {}
        let wiki_2.path = 'F:/my_notes/'
        let wiki_2.index = 'my_markdown_notes'
        let wiki_2.syntax = 'markdown'
        let wiki_2.ext = '.md'

        let g:vimwiki_list = [wiki_2, wiki_1]

        if executable('cl')
            augroup load_us_ycm
                autocmd!
                autocmd InsertEnter * call plug#load('YouCompleteMe')
                            \| autocmd! load_us_ycm
            augroup END
        endif
        if !empty(glob("~/vimfiles/bundle/neocomplete.vim/autoload/neocomplete.vim"))
            " echo "File exists."
            "neocomplete setting {{{
            " Disable AutoComplPop.
            let g:acp_enableAtStartup = 0
            " Use neocomplete.
            let g:neocomplete#enable_at_startup = 1
            " Use smartcase.
            let g:neocomplete#enable_smart_case = 1
            " Set minimum syntax keyword length.
            let g:neocomplete#sources#syntax#min_keyword_length = 3
            let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

            " Define dictionary.
            let g:neocomplete#sources#dictionary#dictionaries = {
                        \ 'default' : '',
                        \ 'javascript' : '~/vimfiles/dict/javascript.dict',
                        \ 'html' : '~/vimfiles/dict/javascript.dict',
                        \ 'c' : '~/vimfiles/dict/c.dict'
                        \ }

            " Define keyword.
            if !exists('g:neocomplete#keyword_patterns')
                let g:neocomplete#keyword_patterns = {}
            endif
            let g:neocomplete#keyword_patterns['default'] = '\h\w*'

            " Plugin key-mappings.
            inoremap <expr><C-g>     neocomplete#undo_completion()
            inoremap <expr><C-l>     neocomplete#complete_common_string()

            " Recommended key-mappings.
            " <CR>: close popup and save indent.
            inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
            function! s:my_cr_function()
                return neocomplete#close_popup() . "\<CR>"
                " For no inserting <CR> key.
                "return pumvisible() ? neocomplete#close_popup() : "\<CR>"
            endfunction
            " <TAB>: completion.
            inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
            " <C-h>, <BS>: close popup and delete backword char.
            inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
            inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
            inoremap <expr><C-y>  neocomplete#close_popup()
            inoremap <expr><C-e>  neocomplete#cancel_popup()
            " Close popup by <Space>.
            "inoremap <expr><Space> pumvisible() ? neocomplete#close_popup() : "\<Space>"

            " For cursor moving in insert mode(Not recommended)
            "inoremap <expr><Left>  neocomplete#close_popup() . "\<Left>"
            "inoremap <expr><Right> neocomplete#close_popup() . "\<Right>"
            "inoremap <expr><Up>    neocomplete#close_popup() . "\<Up>"
            "inoremap <expr><Down>  neocomplete#close_popup() . "\<Down>"
            " Or set this.
            "let g:neocomplete#enable_cursor_hold_i = 1
            " Or set this.
            "let g:neocomplete#enable_insert_char_pre = 1

            " AutoComplPop like behavior.
            "let g:neocomplete#enable_auto_select = 1

            " Shell like behavior(not recommended).
            "set completeopt+=longest
            "let g:neocomplete#enable_auto_select = 1
            "let g:neocomplete#disable_auto_complete = 1
            "inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"

            " Enable omni completion.
            autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
            autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
            autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
            autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
            autocmd FileType python setlocal omnifunc=python3complete#Complete
            "autocmd FileType javascript setlocal omnifunc=tern#Complete

            " Enable heavy omni completion.
            if !exists('g:neocomplete#sources#omni#input_patterns')
                let g:neocomplete#sources#omni#input_patterns = {}
            endif
            "let g:neocomplete#force_omni_input_patterns.javascript = '[^. \t]\.\w*'
            "let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
            "let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
            "let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'
            " support python3
            autocmd FileType python setlocal omnifunc=jedi#completions
            "let g:neocomplete#enable_auto_select = 0
            "let g:jedi#popup_select_first=0
            "let g:jedi#popup_on_dot = 0
            let g:jedi#completions_enabled = 0
            let g:jedi#auto_vim_configuration = 0
            if !exists('g:neocomplete#force_omni_input_patterns')
                let g:neocomplete#force_omni_input_patterns = {}
            endif
            let g:neocomplete#force_omni_input_patterns.python = '\%([^. \t]\.\|^\s*@\|^\s*from\s.\+import \|^\s*from \|^\s*import \)\w*'

            "if has('python3')
            "let g:jedi#force_py_version = 3
            "endif
            "let g:jedi#force_py_version = 3

            "end of neocomplete setting }}}
            "jedi 设置
            let g:jedi#auto_initialization = 0
            let g:jedi#goto_assignments_command = "<Leader>g"
            let g:jedi#goto_definitions_command = "<Leader>d"
            let g:jedi#documentation_command = "K"
            let g:jedi#usages_command = "<Leader>n"
            let g:jedi#completions_command = "<A-1>"
            let g:jedi#rename_command = "<Leader>r"
            let g:jedi#show_call_signatures = "1"
        endif

    endif
    " end of setting for windows }}}
else
    set termguicolors
    "let g:solarized_termtrans = 1
    set background=dark
    "let g:solarized_termcolors=256

    "let terminal support 256 color
    "set t_Co=256
    colorscheme solarized8_dark "solarized8_dark desert evening solarized molokai
    "for sakura terminal
    "if $COLORTERM == "truecolor"
    "set t_ut=
    "endif
endif

" default setting for me {{{
"解决中文乱码 ,gb2312,big5,gb18030,cp936
set enc=utf-8
"set fileencoding=utf-8 "保存文件时编码
set fileencodings=utf-8,cs-bom,gbk,cp936
set number
"set cc=80
syntax on "打开高亮
set autoread
set wildmenu
"set cul "高亮光标所在行
"set cuc
set showcmd
"set autochdir
set fdm=marker "marker indent
set completeopt=longest,menu
set nobackup "覆盖文件不备份
set noswapfile "编辑时不产生交换文件
set showmatch
set vb t_vb= "关闭响铃和闪屏
set ruler
"set nohls "不高亮显示结果
set hls
set incsearch "在输入要搜索的文字时，vim会实时匹配
set fileformats=unix,dos

"缩进设置
filetype indent on
set tabstop=4 "让一个tab等于4个空格
set shiftwidth=4 "sw=4
set expandtab "插入tab时以空格替换et
"set softtabstop=4 "sts
set smarttab "开启新行的sta
set autoindent "自动缩进
set smartindent "智能自动缩进

autocmd FileType python setlocal ts=4 sw=4 et sta
autocmd FileType make setlocal ts=8 sw=8 noexpandtab
" indent for wed
autocmd FileType javascript,html,css,scss,less setlocal ts=2 sw=2  et
au BufRead *.vue setlocal ts=2 sw=2 et
"}}}

"map setting{{{
" F2:NERDTreeToggle  F3:tagbar F4 F6 F7 F8 F9:c F10:c run
" 普通模式下 Ctrl+c 复制文件路径
"nnoremap <c-c> :let @* = expand('%:p')<cr>
"inoremap jk <Esc>
"au BufRead *.wiki map <S-F4> :VimwikiAll2HTML<cr>
"au BufRead *.wiki map <F4> :Vimwiki2HTML<cr>
" calendar
au BufRead *.wiki map <F8> :Calendar<cr>
"nnoremap <F6> :GundoToggle<CR>
" 自动运用设置
autocmd BufWritePost .vimrc,.gvimrc,_vimrc silent source %
" Buffers/Tab操作快捷方式!
"nnoremap <s-h> :bprevious<cr>
"nnoremap <s-l> :bnext<cr>
"nnoremap F :tabe %
"vmap <C-C> "+y
" ctrl+s, need set alias vim="stty stop '' -ixoff ; vim"
map <C-S> :update<CR>
vmap <C-S> <C-C>:update<CR>
imap <C-S> <C-O>:update<CR>
" Insert mode use Emacs key bind
inoremap <C-a> <C-o>^
inoremap <C-e> <End>
inoremap <C-f> <Right>
inoremap <C-b> <Left>
"set modeline

""""""""""""""""""""
"  Leader key map  "
""""""""""""""""""""
vmap <Leader>y "+y
nmap <Leader>p "+p
nmap <Leader>P "+P
vmap <Leader>p "+p
vmap <Leader>P "+P

"nnoremap <Leader>te :tabe<space>
nnoremap <Leader>d :YcmCompleter GoToDefinition <CR>
" grep word under cursor
nnoremap <Leader>fg :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>
nnoremap <Leader>fd :YcmCompleter GoToDefinitionElseDeclaration<CR>
nnoremap K :YcmCompleter GetDoc<CR>
nnoremap <Leader>ft :YcmCompleter GetType <CR>
au FileType javascript,python,typescript nnoremap <Leader>fr :YcmCompleter GoToReferences<CR>
"autocmd BufRead,BufNewFile *.cpp,*.c,*.cc nnoremap <F5> :YcmForceCompileAndDiagnostics<CR>

au FileType javascript nnoremap <Leader>es mF:%!~/.nvm/versions/node/v6.11.0/bin/eslint_d -c ~/.eslintrc-fix.json --stdin --fix-to-stdout<CR>`F
au FileType javascript vnoremap <Leader>es :!~/.nvm/versions/node/v6.11.0/bin/eslint_d -c ~/.eslintrc-fix.json --stdin --fix-to-stdout<CR>gv
" format
noremap <Leader>ef :Autoformat<CR>

vmap <silent> <Leader>c<Space> <Plug>NERDCommenterToggle
nmap <silent> <Leader>c<Space> <Plug>NERDCommenterToggle
nnoremap <Leader>b :Unite buffer<CR>

"}}}

" python setting{{{

let tlist_txt_settings = 'txt;c:content;f:figures;t:tables' "language definition for plain text
autocmd FileType python setlocal foldmethod=indent foldlevel=99

" }}}
" Haskell setting{{{
" Disable haskell-vim omnifunc
let g:haskellmode_completion_ghc = 0
autocmd FileType haskell setlocal omnifunc=necoghc#omnifunc
            \ ts=8 et sw=4 softtabstop=4 shiftround
let g:haskell_indent_disable=1
let g:ycm_semantic_triggers = {'haskell' : ['.']}
au FileType haskell map <silent> tw :update<CR>:GhcModTypeInsert<CR>
au FileType haskell map <silent> ts :update<CR>:GhcModSplitFunCase<CR>
au FileType haskell map <silent> tq :update<CR>:GhcModType<CR>
au FileType haskell map <silent> te :update<CR>:GhcModTypeClear<CR>
"au BufRead *.py map <buffer> <F5> :w<CR>:!/usr/bin/env python % <CR>
" }}}


"plugin setting{{{
" YouCompleteMe {{{
"nnoremap <Leader>f :YcmCompleter FixIt <CR>
if has("unix")
    "let g:ycm_path_to_python_interpreter = '$HOME/.pyenv/versions/env3/bin/python3'
    let g:ycm_python_binary_path = '/home/alan/.pyenv/versions/env3/bin/python3'
    let g:ycm_global_ycm_extra_conf = '~/.vim/.ycm_extra_conf.py'
endif
"Do not ask when starting vim
let g:ycm_confirm_extra_conf = 0
let g:ycm_filetype_blacklist = {
            \ 'tagbar' : 1,
            \ 'qf' : 1,
            \ 'notes' : 1,
            \ 'markdown' : 1,
            \ 'unite' : 1,
            \ 'text' : 1,
            \ 'vimwiki' : 1,
            \ 'pandoc' : 1,
            \ 'infolog' : 1,
            \ 'mail' : 1,
            \}
let g:ycm_use_ultisnips_completer = 1 " Default 1, just ensure
"let g:ycm_seed_identifiers_with_syntax = 1 " Completion for programming language's keyword
let g:ycm_complete_in_comments = 1 " Completion in comments
let g:ycm_complete_in_strings = 1 " Completion in string
"}}}
"" ale
"let g:ale_javascript_eslint_executable = 'eslint_d'
"let g:ale_javascript_eslint_options = '--fix'
"let g:ale_lint_on_text_changed = 'never'
"let g:ale_lint_on_enter = 0
"" syntastic
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_javascript_eslint_exec = 'eslint_d'
" add an autocmd after vim started to execute checktime for *.js files on write
"au VimEnter *.js au BufWritePost *.js checktime
"let g:EasyMotion_leader_key = '<space>'
"map <Leader> <Plug>(easymotion-prefix)
"UltiSnips
let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-b>"
let g:snips_email="zhifengle@gmail.com"
let g:snips_author="22earth"
let g:snips_github="22earth"
"emmet
"let g:user_emmet_leader_key='<C-Z>'
"let g:user_emmet_expandabbr_key = '<Tab>'
let g:user_emmet_install_global = 0
autocmd fileType html,css,wiki,markdown,htmldjango,javascript,vue EmmetInstall
" indent_guides随 vim 自启动
let g:indent_guides_enable_on_vim_startup=0
" 从第二层开始可视化显示缩进
let g:indent_guides_start_level=2
" 色块宽度
let g:indent_guides_guide_size=1
" 快捷键 i 开/关缩进可视化
":nmap <silent> <Leader>i <Plug>IndentGuidesToggle

"html.vim
:let g:html_indent_inctags = "html,body,head,tbody"
let g:html_indent_script1 = "inc"
let g:html_indent_style1 = "inc"
"NERDTree,提供查看文件折叠/展开列表功能
nmap <Leader>2 :NERDTreeToggle<CR>
"imap <F2> <ESC> :NERDTreeToggle<CR>

nmap <Leader>3 :TagbarToggle<CR>
let tagbar_left=1
let g:tagbar_autofocus=1
let g:ctrlp_custom_ignore = {
            \ 'dir':  '\v[\/](\.(git|hg|svn))|(node_modules|dist)$',
            \ 'file': '\v\.(exe|so|dll)$',
            \ 'link': 'SOME_BAD_SYMBOLIC_LINKS',
            \ }
"au BufRead,BufNewFile *.scm,*rkt let g:AutoPairsLoaded = 0
let g:AutoPairsFlyMode = 1
if executable('ag')
    " Use ag over grep
    set grepprg=ag\ --nogroup\ --nocolor

    " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
    "let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

    " ag is fast enough that CtrlP doesn't need to cache
    "let g:ctrlp_use_caching = 0
    let g:unite_source_grep_command = 'ag'
    let g:unite_source_grep_default_opts =
                \ '-i --vimgrep --hidden --ignore ' .
              \ '''.hg'' --ignore ''.svn'' --ignore ''.git'' --ignore ''.bzr'''
    let g:unite_source_grep_recursive_opt = ''
elseif executable('ack-grep')
    let g:unite_source_grep_command = 'ack-grep'
    let g:unite_source_grep_default_opts = '-i --no-heading --no-color -H'
    let g:unite_source_grep_recursive_opt = ''
elseif executable('ack')
    let g:unite_source_grep_command = 'ack'
    let g:unite_source_grep_default_opts = '-i --no-heading --no-color -H'
    let g:unite_source_grep_recursive_opt = ''
endif
" plugin setting end}}}

" 插入文件头{{{
"新建.c,.h,.sh,.java文件，自动插入文件头
autocmd BufNewFile *.cpp,*.[ch],*.sh,*.java exec ":call SetTitle()"
""定义函数SetTitle，自动插入文件头
func SetTitle()
    "如果文件类型为.sh文件
    if &filetype == 'sh'
        call setline(1,"\#!/bin/bash")
        call append(line("."), "")
    elseif &filetype == 'python'
        call setline(1,"#!/usr/bin/env python")
        call append(line("."),"# coding=utf-8")
        call append(line(".")+1, "")
    elseif &filetype == 'mkd'
        call setline(1,"<head><meta charset=\"UTF-8\"></head>")
    else
        call setline(1, "/*************************************************************************")
        call append(line("."),   "  > File Name:     ".expand("%"))
        call append(line(".")+1, "  > Author:        22earth")
        call append(line(".")+2, "  > Mail:          zhifengle@gmail.com ")
        call append(line(".")+3, "  > Created Time:  ".strftime("%c"))
        call append(line(".")+4, " ************************************************************************/")
        call append(line(".")+5, "")
    endif
    if &filetype == 'cpp'
        call append(line(".")+6, "#include<iostream>")
        call append(line(".")+7, "using namespace std;")
        call append(line(".")+8, "")
    endif
    if &filetype == 'c'
        call append(line(".")+6, "#include<stdio.h>")
        call append(line(".")+7, "")
    endif
    "新建文件后，自动定位到文件末尾
endfunc
autocmd BufNewFile * normal G
" }}}
"setting for Windows {{{
set diffexpr=MyDiff()
function MyDiff()
    let opt = '-a --binary '
    if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
    if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
    let arg1 = v:fname_in
    if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
    let arg2 = v:fname_new
    if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
    let arg3 = v:fname_out
    if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
    let eq = ''
    if $VIMRUNTIME =~ ' '
        if &sh =~ '\<cmd'
            let cmd = '""' . $VIMRUNTIME . '\diff"'
            let eq = '"'
        else
            let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
        endif
    else
        let cmd = $VIMRUNTIME . '\diff'
    endif
    silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
endfunction
"}}}
"""""""""""""""""
"  try to use   "
"""""""""""""""""
"some settings for trying{{{
"let g:AutoPairsShortcutBackInsert = '<M-b>'
"set complete+=k
autocmd BufRead,BufNewFile *.md nmap <F5> :w<CR>:set syntax=markdown<CR>
let g:vimwiki_valid_html_tags='b,i,s,u,sub,sup,kbd,br,hr,div,del,code'
let g:Modeliner_format = 'sts= sw= ts= et'
"let g:polyglot_disabled = ['css']
" test setting for web development {{{
"let g:syntastic_javascript_eslint_exe = '$(npm bin)/eslint'
func ToggleJsFiletype()
    if &filetype == 'javascript'
        setlocal ft=javascript.jsx
    elseif &filetype == 'javascript.jsx'
        setlocal ft=javascript
    endif
endfunc
let g:jsx_ext_required = 0
autocmd BufRead,BufNewFile *.js nmap <F6> :%s/class=/className=/g<CR>
"autocmd BufRead,BufNewFile *.js nmap <F7> :call ToggleJsFiletype()<CR>
if !exists("g:ycm_semantic_triggers")
    let g:ycm_semantic_triggers = {}
endif
let g:ycm_semantic_triggers['typescript'] = ['.']
au BufRead,BufNewFile *.scss set filetype=scss.css
"autocmd BufRead,BufNewFile *.vue setlocal filetype=vue.html.javascript.css
" }}}
" vim: set et fenc=utf-8 ff=unix sts=4 sw=4 ts=4 :
"}}}
