"测试专用
" =============================================================================
" File:          test.vim
" Description:   测试专用
" Author:        andrew asa
" Version:       1.00.00
" =============================================================================
command! -nargs=? Test :call s:TestMain('<args>')
command! -n=? -complete=dir -bar Argcv :call s:Argcv('<args>')

"插件测试插件{{{
"重新加载自己
"test插件的入口 思想待完善
function! TestMain(...)
		let watch = input("输入测试的函数>>>")
		execute 'call ' . s:watch .'()'
endfunction

function! s:Argcv(...)
		let index = 0
		let msg = ""
		while index < argc()
			let msg .= argv(index)
			let index += 1
		endwhile
		echo msg
endfunction

function! g:Info(...)
		let s:info  = ""
    for s in a:000
      let s:info .= s
    endfor
		echo "info->[" . s:info "]"
endfunction

"打开一个窗口并往里面输出构造的文件
function! s:CreatTabAndInput(...)
		
endfunction

"This function can then be called with: >
 " call Table("Table", "line1", "line2")
  "call Table("Empty Table")
"}}}

" vim:fen:fdm=marker:fmr={{{,}}}:fdl=99:fdc=1:ts=2:sw=2:sts=2
