" ��װ˵��
" 1:��vimrc��_vimrc��.vimrc�ļ������ȫ�ֱ���vim�����·��g:custom_plug_base_path
" ��: let g:custom_plug_base_path = 'E:/code/github/vimplug/'
" 2:��� execute 'source ' . g:custom_plug_base_path . '.vimrc'
" 3:���ļ����Ƶ�vim��colors·��(���������Ҫ���ƣ�����һ������vimplug�вź�)
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

"�Զ���ȫ�ֱ���{{{
"vim ��װĿ¼
let g:vim_install_path = 'D:/Program Files (x86)/Vim/'	

"}}}

" �������� {{{

set shortmess=atI      "ȥ��������Ԯ����ʾ
set belloff=all        "ȡ��vim�ĵε���

set nu                 "������ʾ�к�
syntax on              "�﷨���� 
set nocompatible       "��Ҫʹ��vi�ļ���ģʽ������vim�Լ��� 
set history=100        "history�ļ�����Ҫ��¼������ 
set clipboard+=unnamed "��windows���������
set iskeyword+=_,$,@,%,#,-  "�������·��ŵĵ��ʲ�Ҫ�����зָ� 

set ignorecase         "����ʱ���Դ�Сд
set incsearch          "����ʱ������Ĵʾ����ַ�����
set showmatch          "������ʾƥ�������
set matchtime=5        "ƥ�����Ÿ�����ʱ�� ʮ��֮һ��
set hlsearch           "������ʾ�������
set nohlsearch				 "��Ҫ�����������ľ��ӣ�phrases��
set cursorline         "������ʾ��ǰ��
set laststatus=2			 "������ʾ״̬��
set ruler              "���½���ʾ���λ�õ�״̬��
set rulerformat=%20(%2*%<%f%=\ %m%r\ %3l\ %c\ %p%%%) "��״̬������ʾ�������λ�õ��кź��к�
set statusline=%F%m%r%h%w\[POS=%l,%v][%p%%]\%{strftime(\"%d/%m/%y\ -\ %H:%M\")}  " �ҵ�״̬����ʾ�����ݣ������ļ����ͺͽ��룩

set tabstop=4          "�Ʊ��Ϊ4
set shiftwidth=4       "ͳһ����Ϊ4
set noexpandtab        "��Ҫ�ÿո�����Ʊ��

filetype on						 "����ļ�����
filetype plugin on     "�����ļ����Ͳ�� 
filetype indent on     "Ϊ�ض��ļ�����������������ļ� 
set confirm            "����δ�������ֻ���ļ�ʱ��������ʾ
set autoread           " �ļ����Ķ�ʱ�Զ�����
set fileencoding=utf-8 "�ļ��������
language messages zh_CN.utf-8 "vim��ʾ��Ϣ����Ľ��
set termencoding=utf-8 "�ն���ʾ����Ϊutf-8
set fileencodings=utf-8,gb2312,gbk,gb18030,cp936  "�ļ�����ʱ���ı���

set guioptions-=T      "ע�� = ǰ�� �� - �� ,���ز����õ��Ĺ�����
set autoindent         "�̳�ǰһ�е�������ʽ
set smartindent        "����������ʹ�������Զ�����
set cindent            "ʹ��c��ʽ������
set cmdheight=3        "�����У���״̬���£��ĸ߶ȣ�Ĭ��Ϊ1��������2
set backspace=indent,eol,start "����ʹ���˸��
set wildmenu					 "��ǿģʽ�е��������Զ���ɲ���
set foldlevel=99	   "Ĭ�ϲ��۵��ļ�
set showmode           "��ʾ�ı�����ģʽ ??
set viminfo+=!         "����ȫ�ֱ��� 
set linespace=0				 "�ַ���������������Ŀ
set mouse=a						 "������buffer���κεط�ʹ����꣨����office���ڹ�����˫����궨λ��
set selection=exclusive 
set selectmode=mouse,key
"��������}}}


"��ݼ�����{{{
nmap w :w<CR>
"��ݼ�����}}}


"�������{{{

"��Ӳ��·������
function! AddCustomPulgPath(path)
  let s:path = g:custom_plug_base_path . a:path
  execute 'set runtimepath^=' . s:path
endfunction
"�����Զ��Ʋ������
function! g:SourceCustomPulgin(pluginDir,pluginName)
  let s:pulginPath = g:custom_plug_base_path . a:pluginDir . '/plugin/' . a:pluginName . '.vim' 
  "echo 'source ' . s:pulginPath
  execute 'source ' . s:pulginPath
endfunction
"��ȡ�Լ���װ�Ĳ��·��
function! GetCustomPulgPath(plugName)
	return g:custom_plug_base_path . a:plugName
endfunction
"��װָ�����Ŀ¼����İ����ĵ�
function! AddCustomPulgDoc(plugName)
	let s:docPath = g:custom_plug_base_path . a:plugName . '/doc'
	echo '��װ' . a:plugName . '�����ļ� ·��[ ' . s:docPath ' ]'
	execute 'helptags ' . s:docPath
endfunction

"��װģ��
"plug:        �������    �������"
"url:		  
"install:     ��װ����(���ò��·����װ�������������˵��)
call AddCustomPulgPath('')
"uninstall:   ж�ط���������˵��(��ע�͵�)
"configure:   ����������

"plug:        common    �Լ���д��ͨ�ú��� ����ģ�����ã�������Ҫ�Ƚ��м���"
"install:
call AddCustomPulgPath('asa.common.vim')     
" ���ý���·��
call SourceCustomPulgin('asa.common.vim','common')
"uninstall:   ע�͵�
"configure:   ���������� ���õ�ȫ�ֱ�����

"plug:        ctrlp       �ļ�����"
"url:		  http://ctrlpvim.github.io/ctrlp.vim/#installation
"install:
call AddCustomPulgPath('ctrlp.vim')
"call AddCustomPulgPath('ctrlp.vim')     
"uninstall:   ע�͵�
"configure:
"something:		:help ctrlp

"plug:        wmtoggle    �򿪶ര��"
"install:
"call AddCustomPulgPath('winmanager')     
"uninstall:   ע�͵�
"configure:   ����������

"plug:        nerdtree    �ļ������"
"install:
call AddCustomPulgPath('nerdtree')     
"call AddCustomPulgDoc('nerdtree')
"uninstall:   ע�͵�
"configure:   ����������
"something:		:help NERDTree


"plug:     bufexplorer    ��ʷ���ļ�"
"install:
call AddCustomPulgPath('bufexplorer')     
"call AddCustomPulgDoc('bufexplorer')
"uninstall:   ע�͵�
"configure:   ����������
"something:		:help NERDTree

"plug:        monokai.vim    ��ɫ���"
"url:		  https://github.com/sickill/vim-monokai
"install:			
"call SourceSkin('monokai')
"call AddCustomPulgPath('molokai')     
"uninstall:   �Ƴ�vimfiles\colors\monokai.vim
"configure:   ����������
colorscheme monokai


"��������
set guifont=Consolas:h14
set guicursor=a:ver10-Cursor/lCursor

"�������}}}



" vim:fen:fdm=marker:fmr={{{,}}}:fdl=99:fdc=1:ts=2:sw=2:sts=2
