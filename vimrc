" 安装说明
" 1:在vimrc或_vimrc或.vimrc文件中添加全局变量vim插件基路径g:custom_plug_base_path
" 例: let g:custom_plug_base_path = 'E:/code/github/vimplug/'
" 2:添加 execute 'source ' . g:custom_plug_base_path . '.vimrc'
" 3:把文件复制到vim的colors路径(这个功能需要完善，像插件一样放在vimplug中才好)
"Demo {{{
"source $VIMRUNTIME/vimrc_example.vim
"source $VIMRUNTIME/mswin.vim
"behave mswin
"
"set diffexpr=MyDiff()
"function MyDiff()
"  let opt = '-a --binary '
"  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
"  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
"  let arg1 = v:fname_in
"  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
"  let arg2 = v:fname_new
"  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
"  let arg3 = v:fname_out
"  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
"  if $VIMRUNTIME =~ ' '
"    if &sh =~ '\<cmd'
"      if empty(&shellxquote)
"        let l:shxq_sav = ''
"        set shellxquote&
"      endif
"      let cmd = '"' . $VIMRUNTIME . '\diff"'
"    else
"      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
"    endif
"  else
"    let cmd = $VIMRUNTIME . '\diff'
"  endif
"  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3
"  if exists('l:shxq_sav')
"    let &shellxquote=l:shxq_sav
"  endif
"endfunction
" }}}

"自定义全局变量{{{
"vim 安装目录
let g:vim_install_path = 'D:/Program Files (x86)/Vim/'	

"}}}

" 基本设置 {{{

set shortmess=atI      "去掉启动的援助提示
set belloff=all        "取消vim的滴滴声

set nu                 "设置显示行号
syntax on              "语法高亮 
set nocompatible       "不要使用vi的键盘模式，而是vim自己的 
set history=100        "history文件中需要记录的行数 
set clipboard+=unnamed "与windows共享剪贴板
set iskeyword+=_,$,@,%,#,-  "带有如下符号的单词不要被换行分割 

set ignorecase         "搜索时忽略大小写
set incsearch          "搜索时，输入的词句逐字符高亮
set showmatch          "高亮显示匹配的括号
set matchtime=5        "匹配括号高亮的时间 十分之一秒
set hlsearch           "高亮显示搜索结果
set nohlsearch				 "不要高亮被搜索的句子（phrases）
set cursorline         "高亮显示当前行
set laststatus=2			 "总是显示状态行
set ruler              "右下角显示光标位置的状态行
set rulerformat=%20(%2*%<%f%=\ %m%r\ %3l\ %c\ %p%%%) "在状态行上显示光标所在位置的行号和列号
set statusline=%F%m%r%h%w\[POS=%l,%v][%p%%]\%{strftime(\"%d/%m/%y\ -\ %H:%M\")}  " 我的状态行显示的内容（包括文件类型和解码）

set tabstop=4          "制表符为4
set shiftwidth=4       "统一缩进为4
set noexpandtab        "不要用空格代替制表符

filetype on						 "侦测文件类型
filetype plugin on     "载入文件类型插件 
filetype indent on     "为特定文件类型载入相关缩进文件 
set confirm            "处理未保存或者只读文件时，给出提示
set autoread           " 文件被改动时自动载入
set fileencoding=utf-8 "文件保存编码
language messages zh_CN.utf-8 "vim提示信息乱码的解决
set termencoding=utf-8 "终端显示编码为utf-8
set fileencodings=utf-8,gb2312,gbk,gb18030,cp936  "文件载入时检测的编码

set guioptions-=T      "注意 = 前面 有 - 号 ,隐藏不常用到的工具条
set autoindent         "继承前一行的缩进方式
set smartindent        "开启新行是使用智能自动缩进
set cindent            "使用c样式的缩进
set cmdheight=3        "命令行（在状态行下）的高度，默认为1，这里是2
set backspace=indent,eol,start "可以使用退格键
set wildmenu					 "增强模式中的命令行自动完成操作
set foldlevel=99	   "默认不折叠文件
set showmode           "显示文本处理模式 ??
set viminfo+=!         "保存全局变量 
set linespace=0				 "字符间插入的像素行数目
set mouse=a						 "可以在buffer的任何地方使用鼠标（类似office中在工作区双击鼠标定位）
set selection=exclusive 
set selectmode=mouse,key
"基本设置}}}


"快捷键设置{{{
nmap w :w<CR>
"快捷键设置}}}


"插件设置{{{

"添加插件路径函数
function! AddCustomPulgPath(path)
  let s:path = g:custom_plug_base_path . a:path
  execute 'set runtimepath^=' . s:path
endfunction
"解析自定制插件函数
function! g:SourceCustomPulgin(pluginDir,pluginName)
  let s:pulginPath = g:custom_plug_base_path . a:pluginDir . '/plugin/' . a:pluginName . '.vim' 
  "echo 'source ' . s:pulginPath
  execute 'source ' . s:pulginPath
endfunction
"获取自己安装的插件路径
function! GetCustomPulgPath(plugName)
	return g:custom_plug_base_path . a:plugName
endfunction
"安装指定插件目录下面的帮助文档
function! AddCustomPulgDoc(plugName)
	let s:docPath = g:custom_plug_base_path . a:plugName . '/doc'
	echo '安装' . a:plugName . '帮助文件 路径[ ' . s:docPath ' ]'
	execute 'helptags ' . s:docPath
endfunction

"安装模板
"plug:        插件名字    插件描述"
"url:		  
"install:     安装描述(设置插件路径或安装所需组件等配置说明)
call AddCustomPulgPath('')
"uninstall:   卸载方法，步骤说明(例注释掉)
"configure:   插件相关配置

"plug:        common    自己编写的通用函数 其它模块会调用，所以需要先进行加载"
"install:
call AddCustomPulgPath('asa.common.vim')     
" 调用解析路径
call SourceCustomPulgin('asa.common.vim','common')
"uninstall:   注释掉
"configure:   插件相关配置 配置到全局变量中

"plug:        ctrlp       文件查找"
"url:		  http://ctrlpvim.github.io/ctrlp.vim/#installation
"install:
call AddCustomPulgPath('ctrlp.vim')
"call AddCustomPulgPath('ctrlp.vim')     
"uninstall:   注释掉
"configure:
"something:		:help ctrlp

"plug:        wmtoggle    打开多窗口"
"install:
"call AddCustomPulgPath('winmanager')     
"uninstall:   注释掉
"configure:   插件相关配置

"plug:        nerdtree    文件浏览器"
"install:
call AddCustomPulgPath('nerdtree')     
"call AddCustomPulgDoc('nerdtree')
"uninstall:   注释掉
"configure:   插件相关配置
"something:		:help NERDTree


"plug:     bufexplorer    历史打开文件"
"install:
call AddCustomPulgPath('bufexplorer')     
"call AddCustomPulgDoc('bufexplorer')
"uninstall:   注释掉
"configure:   插件相关配置
"something:		:help NERDTree

"plug:        monokai.vim    颜色插件"
"url:		  https://github.com/sickill/vim-monokai
"install:			
"call SourceSkin('monokai')
"call AddCustomPulgPath('molokai')     
"uninstall:   移除vimfiles\colors\monokai.vim
"configure:   插件相关配置
colorscheme monokai


"字体设置
set guifont=Consolas:h14
set guicursor=a:ver10-Cursor/lCursor

"插件设置}}}



" vim:fen:fdm=marker:fmr={{{,}}}:fdl=99:fdc=1:ts=2:sw=2:sts=2
