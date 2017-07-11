"------------------------------------------------------------+
" vim8配置文件  gvim
" @author raydraw@163.com
"------------------------------------------------------------+
set nocompatible "关闭vi兼容"
" filetype off

" 判断操作系统类型
if has("win32")
    let os = "win"
elseif has("win64")
    let os = "win"
elseif has("win32unix")
    let os = "cygwin"
elseif has ("win64unix")
    let os = "cygwin"
elseif has("unix")
    let s:uname = system("uname -s")
    if s:uname == "Darwin\n"
        let os = "mac"
    else
        let os = "unix"
    endif
endif

if os == 'win'
    "模仿windows快捷键 Ctrl+A全选、Ctrl+C复制、Ctrl+V粘贴
    source $VIMRUNTIME/vimrc_example.vim
	source $VIMRUNTIME/mswin.vim
	behave mswin

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
 	 if $VIMRUNTIME =~ ' '
 	   if &sh =~ '\<cmd'
 	     if empty(&shellxquote)
 	       let l:shxq_sav = ''
 	       set shellxquote&
 	     endif
 	     let cmd = '"' . $VIMRUNTIME . '\diff"'
 	   else
 	     let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
 	   endif
	  else
	    let cmd = $VIMRUNTIME . '\diff'
	  endif
	  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3
	  if exists('l:shxq_sav')
    	let &shellxquote=l:shxq_sav
	  endif
	endfunction
endif


"--- vundle配置 ----------------------------------------
"set rtp+=$VIM/vimfiles/bundle/Vundle.vim "加入新插件目录"
if os == 'win'
    let path=''$VIM/vimfiles/bundle/'
else
    if has("nvim")
        let path='~/.config/nvim/plugged'
    else
        let path='~/.vim/bundle'
    endif
endif
call plug#begin(path)

"Plug 'scrooloose/nerdtree'
"Plug 'L9'
"Plug 'FuzzyFinder'
"Plug 'molokai'
"Plug 'vividchalk.vim'
"Plug 'Solarized'

Plug 'rking/ag.vim' " 高速文件内容搜索，需要先安装'ag(the_silver_searcher)'命令
Plug 'scrooloose/syntastic' " 牛B的语法检查插件
Plug 'kien/ctrlp.vim' " 文件查找利器
Plug 'JazzCore/ctrlp-cmatcher', {'do': './install.sh'} " ctrlp的匹配插件，由cpp实现，速度比较快
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' } " 树形文件查看工具
Plug 'bling/vim-airline' " 状态栏增强
Plug 'vim-airline/vim-airline-themes'
"Plug 'powerline/fonts'  "字体
Plug 'jiangmiao/auto-pairs'  "括号自动补全"
Plug 'mhinz/vim-startify' "初始化界面
Plug 'universal-ctags/ctags' "ctags插件"

Plug 'Valloric/YouCompleteMe' " 强大的匹配插件

call plug#end()
"--------------------------------
" 基础配置
"--------------------------------
"配色方案设置"
"colo solarized 
color desert
"colo  molokai

mapclear " 重置所有按键映射
syntax on " 语法自动识别
filetype on " 文件类型自动识别
filetype plugin on
filetype indent on

"可用鼠标操作
set mouse=a

" 关闭自动备份
set nobackup
set nowritebackup
set noswapfile

" 设置语言
set encoding=utf-8
set fileformats=unix,dos,mac " 文件格式选择顺序
set fileencodings=ucs-bom,utf-8,chinese
set termencoding=utf-8
set langmenu=en_US
set helplang=cn
language message zh_CN.UTF-8 " 解决提示信息乱码

" 缩进相关配置
set lazyredraw
set confirm " 确认保存
" set clipboard+=unnamed " 共享剪切板
set autoindent " 启动自动缩进
set smartindent " 启用智能缩进
set expandtab " 将TAB转为空格
set tabstop=4
set softtabstop=4
set shiftwidth=4
set smarttab

" 设置需忽略的文件
set wildignore+=*/tmp/*,*/Library/*,*/Temp/*
set wildignore+=*.so,*.swp,*.zip,*.beam,*.meta,*.dll,*.dll.mdb,*.exe,*.pyc
set wildignore+=*.png,*.bmp,*.jpg,*.jpeg,*.FBX,*.tga
set wildignore+=*.unity3d,*.prefab,*.unity,*.asset,*.mat,*.meta

set history=999 " 历史命令记录最大条数
set backspace=indent,eol,start " 退格键设置
set wrap " 折行显示超出屏幕的单行文本
set shellslash " 使用'/'作目录分隔符
set hidden " 不开启的话，在切换buffer后会丢失history
set magic " 文档建议始终将 'magic' 选项保持在缺省值
set ignorecase  " 搜索时不区分大小写
set incsearch " 实时匹配
set hlsearch " 高亮搜索关键字
set number " 显示行号
set scrolloff=3 " 滚屏触发边界
set grepprg=grep\ -nri\ --include=*.{erl,php,js,c,cpp,as,cs,html,py,pyw}
set nopaste " 禁用粘贴模式
set pastetoggle=<f12> " 粘贴模式切换
" set showtabline=2 " 一直显示tab bar
set formatoptions= " 关闭自动注释
set updatetime=500 "5秒后刷新"

set wildmode=list,full " 命令行补全相关设置

let $LANG='en_US'
" 设置语言后需重载菜单
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim

" gui模式下的窗口配置
if has("gui_running")
    " 不显示工具条和菜单
    set guioptions=

    " 字体下载地址:https://github.com/Lokaltog/powerline-fonts
    if os == "mac"
        set guifont=Sauce\ Code\ Powerline\ Light:h14
    elseif os == "win"
        set guifont=Source_Code_Pro_Light:h11
    else
        set guifont=Source\ Code\ Pro\ for\ Powerline\ Light\ 14
    endif

    " 设置窗口大小
    if os == "win"
        set columns=168
        set lines=54
    else
        set columns=999
        set lines=999
    endif

    " 光标辅助线配色
    hi Search guibg=#ff6600 guifg=#ffffff
    hi IncSearch guibg=#ff6600 guifg=#ffffff
    hi cursorline guibg=#222222
    hi cursorcolumn guibg=#222222

    " 调整窗口位置快捷键
" "   map <c-a-left> :call s:ChangeWindowsPosition("left")<cr>
" "   map <c-a-right> :call s:ChangeWindowsPosition("right")<cr>
" "   map <c-a-up> :call s:ChangeWindowsPosition("up")<cr>
" "   map <c-a-down> :call s:ChangeWindowsPosition("down")<cr>
" "   function! s:ChangeWindowsPosition(dir)
" "       if "left" == a:dir
" "           exec ':winpos '.(getwinposx() - 44).' '.(getwinposy())
" "       endif
" "       if "right" == a:dir
" "           exec ':winpos '.(getwinposx() + 44).' '.(getwinposy())
" "       endif
" "       if "up" == a:dir
" "           exec ':winpos '.(getwinposx()).' '.(getwinposy() - 44)
" "       endif
" "       if "down" == a:dir
" "           exec ':winpos '.(getwinposx()).' '.(getwinposy() + 44)
" "       endif
" "   endfunction
endif



"--------------------------------
" 自动命令
"--------------------------------
autocmd BufNewFile,BufRead *.gradle set filetype=groovy
autocmd BufNewFile,BufRead *.app set filetype=erlang
autocmd BufNewFile,BufRead *.as set filetype=actionscript
autocmd BufNewFile,BufRead *.mxml set filetype=xml
autocmd BufNewFile,BufRead *.mm set filetype=objc
autocmd BufNewFile,BufRead *.ino set filetype=cpp
autocmd BufNewFile,BufRead *.frag,*.vert,*.glsl set filetype=glsl
autocmd BufRead *.txt call TextCodeSnip()
autocmd FileType javascript setlocal softtabstop=2 shiftwidth=2 " 使用standard风格, javascript的缩进为2个空格

if os == "win"
    " 自动回到关闭文件时光标所在的位置
    autocmd BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif
else
    " 自动保存vim的窗口和光标等设置
    au BufWinLeave *.* silent mkview
    au BufWinEnter *.* silent loadview
endif

" 编辑vimrc文件后自动加载
autocmd! BufWritePost .nvimrc,.vimrc,_vimrc so $MYVIMRC

"--------------------------------
" 自定义热键
"--------------------------------
" 各种map命令对应的模式
" Command   Normal  Visual  OperatorPending     InsertOnly  CommandLine
" :map      y       y       y
" :nmap     y
" :vmap             y
" :omap                     y
" :map!                                         y           y
" :imap                                         y
" :cmap                                                     y


" 设置leader键
let mapleader = ","
let g:mapleader = ","


" 编辑vimrc快捷键  刷新vimrc
map <leader>v :e $MYVIMRC<cr>

" 调用外部应用程序
map <leader>aba :silent !start "D:/Program Files/AbaReplace/AbaReplace.exe"<cr>

"设置pwd为当前文件所在的目录
"map <leader>cd :cd %:p:h<cr>:pwd<cr>

" 搜索当前目录下所有文件内容中的关键字
map <leader>s :SearchKeyword

" 梆定shift-insert为粘贴
map <s-insert> <MiddleMouse>
map! <s-insert> <MiddleMouse>
map <d-v> <MiddleMouse>


" 保存
map <s-w> :w<cr> 


map <f3> :NERDTreeToggle<cr>
imap <F3> <ESC> :NERDTreeToggle<CR>


" 开/关代码错误显示窗口 vfgm 
map <leader>e :call ErrorsWindowsToggle()<cr>
map! <leader>e <c-o>:call ErrorsWindowsToggle()<cr>

"nmap    <c-l>  :resize +3<CR>
nmap    <c-l>  :vertical resize +3<CR>
nmap    <c-h>  :vertical resize -3<CR>

nmap    <c-s>  :w<CR>
nmap <c-n> :bn<CR>
nmap <c-p> :bp<CR>

set ff=unix

" 设置ag作为grep程序
if executable('ag')
  set grepprg=ag\ --nogroup\ --nocolor
endif

" 使用grep搜索当前目录下所有文件中的关键词
map K :SearchKeyword<cr>
" 显示光标下关键词的帮助信息
map H :SearchHelp<cr>

"--------------------------------
" 插件变量和自定义变量
"--------------------------------
let g:plug_threads=1 " Plug的并发线程，不要太高，不然会被github阻止
let g:plug_timeout=180 " Plug访问超时时间
let Tlist_Use_Right_Window=1 " taglist插件的相关设置

"--- NERDTree相关插件设置 ----------------------------
let NERDTreeWinPos='left'           " 窗口位置（'left' or 'right'）
let NERDTreeWinSize=36              " 窗口宽度
let NERDTreeShowBookmarks=1         " 当打开窗口时，自动显示Bookmarks  
let g:NERDTreeDirArrowExpandable = '▶'
let g:NERDTreeDirArrowCollapsible = '▼'


"--- Syntastic插件配置 --------------------------------------------
" 在状态栏中显示一些错误摘要
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_error_symbol = ">>"
let g:syntastic_warning_symbol = ">"
let g:syntastic_check_on_open=1

let g:syntastic_check_on_wq = 1 " 1:保存文件时立即检查一次，如果机器慢可以关掉
let g:syntastic_check_on_open = 0 " 1:打开文件时立即检查一次，如果机器慢可以关掉
"let g:syntastic_always_populate_loc_list = 1 " 是否总是将任何检测到的错误显示到location-list中


"--- YouCompleteMe插件配置 ----------------------------------------
" 指定全局的ycm_extra_conf文件，在项目目录中没有配置ycm_extra_conf文件时会使用此文件
"if os == "win"
"    let g:ycm_global_ycm_extra_conf = '$VIM/ycm_extra_conf.py'
"else
"    let g:ycm_global_ycm_extra_conf = '~/.ycm_extra_conf.py'
"endif
let g:ycm_confirm_extra_conf = 1 " 自动加载ycm_extra_conf.py文件时是否提示
let g:ycm_show_diagnostics_ui = 1 " 0:只在打开和保存文件时检查语法


"==================================================================

"--- airline插件配置 ----------------------------------------------
let g:airline_theme="luna"
" let g:airline_theme="badwolf"
let g:airline_powerline_fonts = 1
"let g:airline_section_b = '%{strftime("%c")}'
"let g:airline_section_y = 'BN: %{bufnr("%")}'
let g:airline#extensions#tabline#enabled = 1  
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
let g:airline_left_sep = ' '
let g:airline_left_alt_sep = ' '
let g:airline_right_sep = ' '
let g:airline_right_alt_sep = ' '


"let g:airline#extensions#tabline#enabled=1 
let g:airline_powerline_fonts=1 " 需安装powerline-fonts
"==================================================================


"--- CtrlP插件配置 ------------------------------------------------
let g:ctrlp_map = '<leader>p'               " 快捷键
map <leader>p :CtrlP<cr>
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode=''        " 关闭自动根目录判定，改为手动':cd /这里/是/根目录'
"let g:ctrlp_open_new_file='r'           " 打开新建文件的方式
"let g:ctrlp_open_multiple_files='0vjr'  " 打开多个文件的方式
let g:ctrlp_follow_symlinks=1           " 搜索时跟随链接
"let g:ctrlp_match_window = 'bottom,order:btt,min:26,max:26,results:26' " 窗口设置
"if os != "win"
""    let g:ctrlp_match_func = {'match' : 'matcher#cmatch' }
"endif

set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.beam     " MacOSX/Linux
set wildignore+=*\\tmp\\*,*.swp,*.zip,*.exe,*.beam  " Windows

let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn)$',
  \ 'file': '\v\.(exe|so|dll)$',
  \ 'link': 'some_bad_symbolic_links',
  \ }


let g:ctrlp_user_command = 'find %s -type f'        " MacOSX/Linux
"let g:ctrlp_user_command = 'dir %s /-n /b /s /a-d'  " Windows

"==================================================================


"--------------------------------
" 自定义函数
"--------------------------------

" 开/关代码错误提示窗口函数,需要Syntastic插件支持
function! ErrorsWindowsToggle()
    let s:old_last_winnr = winnr('$')
    lclose
    if s:old_last_winnr == winnr('$')
        Errors
    endif
endfunction

"""""""""""""""""""""""""""""""""
" 缩写
"""""""""""""""""""""""""""""""""
"Html代码缩写
iab <xhtml>  <esc>:set filetype=xhtml<cr>:set fileencoding=utf-8<cr>i<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"><cr><html xmlns="http://www.w3.org/1999/xhtml"><cr><head><cr><meta http-equiv="Content-Type" content="text/html; charset=utf-8" /><cr><meta name="keywords" content="" /><cr><title></title><cr></head><cr><body><cr></body><cr></html><esc>4k
iab <refresh> <meta http-equiv="refresh" content="0;url="><esc>hh
iab <css> <style type="text/css"><cr></style><esc>O
iab <cssm> <style type="text/css"><cr>*{margin:0; padding:0;}<cr>ul{list-style:none;}<cr></style><esc>k
iab <ci> <link rel="stylesheet" type="text/css" href="" /><esc>2b1l
iab <js> <script type="text/javascript"><cr></script><esc>O
iab <ji> <script type="text/javascript" src=""></script><esc>2b1l
iab <swf> <object type="application/x-shockwave-flash" data="0000" width="0000" height="0000"><param name="movie" value="0000" /></object><esc>/0000<cr>h
iab <form> <form method="post"><cr></form><esc>1k1h
iab <input> <input type="text" name="0000" value="0000" /><esc>/0000<cr>h
iab <radio> <input type="radio" name="0000" value="0000" />0000<esc>/0000<cr>h
iab <select> <select name="0000"><cr><option value="0000">0000</option><cr><option value="0000">0000</option><cr></select><esc>/0000<cr>h
iab <cb> <input type="checkbox" name="0000" value="0000" />0000<esc>/0000<cr>h
iab <submit> <input type="submit" name="submit" value="submit" /><esc>h
iab <btn> <input type="button" name="0000" value="0000" /><esc>/0000<cr>h
iab <img> <img src="0000" alt="0000" /><esc>/0000<cr>h
iab <u> <ul><cr><li>0000</li><cr><li>0000</li><cr></ul><esc>/0000<cr>h
iab <a> <a href="0000">0000</a><esc>/0000<cr>h
iab id> id=""<esc>hh
iab <tb> <table><cr><tr><td>0000</td></tr><cr></table><esc>/0000<cr>h
iab <tr> <tr><td>0000</td></tr><esc>/0000<cr>h
iab <td> <td>0000</td><esc>/0000<cr>h
iab f> function (){<cr>}<esc>1k$3h

"erlang代码缩写
iab <hrl> <esc>:set paste<cr>:set filetype=hrl<cr>:set fileencoding=utf-8<cr>i%%----------------------------------------------------<cr>%% <cr>%% @author hebishi2017@shiyuegmail.com<cr>%%----------------------------------------------------<esc>4kl<cr>set nopaste<cr>
iab <erl> <esc>:set paste<cr>:set filetype=erlang<cr>:set fileencoding=utf-8<cr>i%%----------------------------------------------------<cr>%% <cr>%% @author hebishi@shiyuegmail.com<cr>%%----------------------------------------------------<cr>-module().<cr>-export([]).<esc>4kl<cr>:set nopaste<cr>2ggA
iab <rpc> <esc>:set paste<cr>:set filetype=erlang<cr>:set fileencoding=utf-8<cr>i%%----------------------------------------------------<cr>%% <cr>%% @author hebishi2017@shiyuegmail.com<cr>%%----------------------------------------------------<cr>-module(_rpc).<cr>-export([handle/3]).<cr><cr>-include("common.hrl").<cr>-include("role.hrl").<cr><cr>%% 容错匹配<cr>handle(_Cmd, _Data, _Role) -><cr>?DEBUG("模块[~w]收到无效的RPC调用[~w]: ~w", [?MODULE, _Cmd, _Data]),<cr>{error, unknow_command}.<esc>4kl<cr>:set nopaste<cr>2ggA
iab <gs> <esc>:set paste<cr>:set filetype=erlang<cr>:set fileencoding=utf-8<cr>i%%----------------------------------------------------<cr>%% <cr>%% @author hebishi@shiyuegmail.com<cr>%%----------------------------------------------------<cr>-module().<cr>-behaviour(gen_server).<cr>-export([info/1, cast/1, call/1, start_link/0]).<cr>-export([init/1, handle_call/3, handle_cast/2, handle_info/2, terminate/2, code_change/3]).<cr>-record(state, {}).<cr>-include("common.hrl").<cr><cr>%% @doc IFNO信息请求<cr>info(Info) -> ?MODULE ! Info.<cr><cr>%% @doc CAST信息请求<cr>cast(Info) -> gen_server:cast(?MODULE, Info).<cr><cr>%% @doc CALL同步调用<cr>call(Info) -><cr>?CALL(?MODULE, Info).<cr><cr>start_link() -><cr>gen_server:start_link({local, ?MODULE}, ?MODULE, [], []).<cr><cr>init([]) -><cr>?INFO("[~w] 正在启动...", [?MODULE]),<cr>process_flag(trap_exit, true),<cr>State = #state{},<cr>?INFO("[~w] 启动完成", [?MODULE]),<cr>{ok, State}.<cr><cr>handle_call(_Request, _From, State) -><cr>{noreply, State}.<cr><cr>handle_cast(_Msg, State) -><cr>{noreply, State}.<cr><cr>handle_info(_Info, State) -><cr>{noreply, State}.<cr><cr>terminate(_Reason, _State) -><cr>ok.<cr><cr>code_change(_OldVsn, State, _Extra) -><cr>{ok, State}.<esc>:set nopaste<cr>2ggA
iab <gf> <esc>:set paste<cr>:set filetype=erlang<cr>:set fileencoding=utf-8<cr>i%%----------------------------------------------------<cr>%%<cr>%%<cr>%% @author hebishi2017@shiyuegmail.com<cr>%%----------------------------------------------------<cr>-module().<cr>-behaviour(gen_fsm).<cr>-export(<cr>[<cr>m/0<cr>,info/1<cr>,cast/1<cr>,call/1<cr>,start_link/0<cr>]<cr>).<cr>-export([init/1, handle_event/3, handle_sync_event/4, handle_info/3, terminate/3, code_change/4]).<cr>-export([idel/2]).<cr>-record(state, {<cr>ts = 0<cr>,timeout = 0<cr>,switch = open<cr>}).<cr>-include("common.hrl").<cr>-include("role.hrl").<cr><cr>%% @doc GM指令<cr>-spec m() -> ok.<cr>m() -><cr>?INFO("有人输入了下阶段"),<cr>gen_fsm:send_event(?MODULE, timeout).<cr><cr>%% @doc INFO信息请求<cr>info(Info) -><cr>?MODULE ! Info.<cr><cr>%% @doc cast异步请求<cr>cast(Event) -><cr>gen_fsm:send_all_state_event(?MODULE, Event).<cr><cr>%% @doc call同步请求<cr>call(Event) -><cr>?GFCALL(?MODULE, Event).<cr><cr>start_link()-><cr>gen_fsm:start_link({local, ?MODULE}, ?MODULE, [], []).<cr><cr>init([])-><cr>?INFO("开始启动"),<cr>process_flag(trap_exit, true),<cr>IdelTimeout = 86400000,<cr>State = #state{ts = erlang:now(), timeout = IdelTimeout},<cr>?INFO("启动完成"),<cr>{ok, idel, State, IdelTimeout}.<cr><cr>handle_event(_Event, StateName, State) -><cr>continue(StateName, State).<cr><cr>handle_sync_event(_Event, _From, StateName, State) -><cr>Reply = ok,<cr>continue(StateName, Reply, State).<cr><cr>%% 开始控制<cr>handle_info({switch, S}, StateName, State) when S =:= open orelse S =:= close -><cr>continue(StateName, State#state{switch = S});<cr><cr>handle_info(_Info, StateName, State) -><cr>continue(StateName, State).<cr><cr>terminate(_Reason, _StateName, _State) -><cr>?INFO("开始关闭"),<cr>?INFO("关闭完成"),<cr>ok.<cr><cr>code_change(_OldVsn, StateName, State, _Extra) -><cr>{ok, StateName, State}.<cr>%%--------------------------------------------<cr>%% 状态变化<cr>%%--------------------------------------------<cr><cr>%% 继续下一个状态<cr>continue(StateName, State = #state{ts = Ts, timeout = Timeout}) -><cr>{next_state, StateName, State, util:time_left(Timeout, Ts)}.<cr><cr>continue(StateName, Reply, State = #state{ts = Ts, timeout = Timeout}) -><cr>{reply, Reply, StateName, State, util:time_left(Timeout, Ts)}.<cr><cr>%% 空闲<cr>idel(timeout, State) -><cr>continue(idel, State#state{ts = erlang:now()});<cr>idel(_Any, State) -><cr>continue(idel, State).<cr><cr><esc>:set nopaste<cr>2ggA

"bash
iab <sh> <esc>:set filetype=sh<cr>:set fileencoding=utf-8<cr>i#/bin/bash<cr>#----------------------------------------------------<cr># <cr># @author hebishi2017@shiyuegmail.com<cr>#----------------------------------------------------<esc>4kl
"LUA代码缩写
iab <lua> <esc>:set filetype=lua<cr>:set fileencoding=utf-8<cr>i-- --------------------------------------------------+<cr><cr>@author hebishi2017@shiyuegmail.com<cr>--------------------------------------------------*/<esc>2kl
"PHP代码缩写
iab <php> <esc>:set filetype=php<cr>:set fileencoding=utf-8<cr>i<?php<cr>/**----------------------------------------------------+<cr> * <cr>* @author hebishi2017@shiyuegmail.com<cr>+-----------------------------------------------------*/<esc>2kl
"CPP代码缩写
iab <cpp> <esc>:set filetype=cpp<cr>:set fileencoding=utf-8<cr>i/**----------------------------------------------------+<cr> * <cr>* @author hebishi2017@shiyuegmail.com<cr>+-----------------------------------------------------*/<esc>2kl
"CPP代码缩写
iab <h> <esc>:set filetype=h<cr>:set fileencoding=utf-8<cr>i/**----------------------------------------------------+<cr> * <cr>* @author hebishi2017@shiyuegmail.com<cr>+-----------------------------------------------------*/<esc>2kl



