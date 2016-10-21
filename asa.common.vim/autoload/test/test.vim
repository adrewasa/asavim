"测试专用
" =============================================================================
" File:          test.vim
" Description:   测试专用
" Author:        andrew asa
" Version:       1.00.00
" =============================================================================
 let g:BindTestCommand = 0
 if g:BindTestCommand
 else
		g:BindTestComand=1 command! -nargs=? Test :call TestMain('<args>')
 endif

"插件测试插件{{{
"重新加载自己
"test插件的入口 思想待完善
function! TestMain(...)
		let watch = input("输入测试的函数>>>")
		echo watch
endfunction
"}}}

" vim:fen:fdm=marker:fmr={{{,}}}:fdl=99:fdc=1:ts=2:sw=2:sts=2
