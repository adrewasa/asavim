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
		execute 'so e:\code\github\asavim\asa.common.vim\autoload\test\test.vim'
endfunction
execute 'so e:\code\github\asavim\asa.common.vim\autoload\test\test.vim'

"搜索当前光标下的单词
function! FindKeyWordOnCursor()
		"在当前文件中进行查找
		let n = search(expand('<cword>'),'ew')
endfunction
"F键进行调用该函数
nmap F :call FindKeyWordOnCursor()<CR>
"TODO 查找模式仍然没能完善，应该做成按F之后能按n进行下一处


set tabline=%!MyTabLine()  " custom tab pages line
function! MyTabLine()
        let s = '' " complete tabline goes here
        " loop through each tab page
        for t in range(tabpagenr('$'))
                " set highlight
                if t + 1 == tabpagenr()
                        let s .= '%#TabLineSel#'
                else
                        let s .= '%#TabLine#'
                endif
                " set the tab page number (for mouse clicks)
                let s .= '%' . (t + 1) . 'T'
                let s .= ' '
                " set page number string
                let s .= t + 1 . ' '
                " get buffer names and statuses
                let n = ''      "temp string for buffer names while we loop and check buftype
                let m = 0       " &modified counter
                let bc = len(tabpagebuflist(t + 1))     "counter to avoid last ' '
                " loop through each buffer in a tab
                for b in tabpagebuflist(t + 1)
                        " buffer types: quickfix gets a [Q], help gets [H]{base fname}
                        " others get 1dir/2dir/3dir/fname shortened to 1/2/3/fname
                        if getbufvar( b, "&buftype" ) == 'help'
                                let n .= '[H]' . fnamemodify( bufname(b), ':t:s/.txt$//' )
                        elseif getbufvar( b, "&buftype" ) == 'quickfix'
                                let n .= '[Q]'
                        else
                                let n .= pathshorten(bufname(b))
                        endif
                        " check and ++ tab's &modified count
                        if getbufvar( b, "&modified" )
                                let m += 1
                        endif
                        " no final ' ' added...formatting looks better done later
                        if bc > 1
                                let n .= ' '
                        endif
                        let bc -= 1
                endfor
                " add modified label [n+] where n pages in tab are modified
                if m > 0
                        let s .= '[' . m . '+]'
                endif
                " select the highlighting for the buffer names
                " my default highlighting only underlines the active tab
                " buffer names.
                if t + 1 == tabpagenr()
                        let s .= '%#TabLineSel#'
                else
                        let s .= '%#TabLine#'
                endif
                " add buffer names
                if n == ''
                        let s.= '[New]'
                else
                        let s .= n
                endif
                " switch to no underlining and add final space to buffer list
                let s .= ' '
        endfor
        " after the last tab fill with TabLineFill and reset tab page nr
        let s .= '%#TabLineFill#%T'
        " right-align the label to close the current tab page
        if tabpagenr('$') > 1
                let s .= '%=%#TabLineFill#%999Xclose'
        endif
        return s
endfunction
"}}}

" vim:fen:fdm=marker:fmr={{{,}}}:fdl=99:fdc=1:ts=2:sw=2:sts=2
