" =============================================================================
" File:          common.vim
" Description:   这里放一些通用的函数
" Author:        andrew asa
" Version:       1.00.00
" =============================================================================

"常用函数{{{
" CallSource(stringCmd)				(字符串命令)							解析字符串{{{	
function! CallSource(stringCmd)
		execute 'source ' . a:stringCmd
		echo 'execute source ' . a:stringCmd
endfunction
"}}}
" SourceVimrcFile()						()											重新解析vimrc文件{{{	
function! SourceVimrcFile()
	" 获取vimrc文件目录
	let s:vimrcPath = g:custom_plug_base_path . '.vimrc'
  execute 'source ' . s:vimrcPath
	echo '重新加载vimrc文件,文件目录[' . s:vimrcPath . ']'
endfunction
"" SourceSkin(skinName)				(皮肤名字)							source vim的皮肤{{{	
function! SourceSkin(skinName)
		"皮肤路径
		let s:skinPath = g:custom_plug_base_path . a:skinName . '/colors/' . a:skinName . '.vim'
		cal CallSource(s:skinPath)
endfunction
"}}}}}}
" ChangeSkin(skinName)				(皮肤名字)							改变vim的皮肤{{{	
function! ChangeSkin(skinName)
		"皮肤路径
		let s:skinPath = g:custom_plug_base_path . a:skinName . '/colors/' . a:skinName . '.vim'
		cal CallSource(s:skinPath)
		let s:changeSkinCmd = 'colorscheme ' . a:skinName
		execute s:changeSkinCmd
		echo '更换皮肤[' . a:skinName .'] 路径 [' . s:skinPath . ']'
endfunction
"}}}
" function ListAllCommonFunc 列出所有公用的方法{{{	
function! ListAllCommonFunc()
	echo 'SourceVimrcFile()						解析vimrc文件'	
	echo 'ListAllCommonFunc()					列出所有公用的方法'
	echo 'SourceSkin(skinName)				source vim的皮肤'
	echo 'ChangeSkin(skinName)				改变vim的皮肤'
	echo 'CallSource(stringCmd)				解析字符串'
endfunction
"}}}

"
function! SourceTest()
		execute 'so e:\code\github\vimplug\asa.common.vim\autoload\test\test.vim'
endfunction
"}}}

" vim:fen:fdm=marker:fmr={{{,}}}:fdl=99:fdc=1:ts=2:sw=2:sts=2
