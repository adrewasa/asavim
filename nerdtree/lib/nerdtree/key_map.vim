"CLASS: KeyMap
"============================================================
"存放事件的变量，就像jquery里面的一样??
let s:KeyMap = {}
let g:NERDTreeKeyMap = s:KeyMap

"FUNCTION: KeyMap.All() {{{1
function! s:KeyMap.All()
    if !exists("s:keyMaps")
        let s:keyMaps = []
    endif
    return s:keyMaps
endfunction

"FUNCTION: KeyMap.FindFor(key, scope) {{{1
"在事件集合中寻找符合的键和域的事件并返回
function! s:KeyMap.FindFor(key, scope)
    for i in s:KeyMap.All()
         if i.key ==# a:key && i.scope ==# a:scope
            return i
        endif
    endfor
    return {}
endfunction

"FUNCTION: KeyMap.BindAll() {{{1
"进行绑定所有注册的事件
function! s:KeyMap.BindAll()
    for i in s:KeyMap.All()
        call i.bind()
    endfor
endfunction

"FUNCTION: KeyMap.bind() {{{1
function! s:KeyMap.bind()
    " If the key sequence we're trying to map contains any '<>' notation, we
    " must replace each of the '<' characters with '<lt>' to ensure the string
    " is not translated into its corresponding keycode during the later part
    " of the map command below
    " :he <>
    let specialNotationRegex = '\m<\([[:alnum:]_-]\+>\)'
    if self.key =~# specialNotationRegex
        let keymapInvokeString = substitute(self.key, specialNotationRegex, '<lt>\1', 'g')
    else
        let keymapInvokeString = self.key
    endif

    let premap = self.key == "<LeftRelease>" ? " <LeftRelease>" : " "

    "真正的事件绑定
    exec 'nnoremap <buffer> <silent> '. self.key . premap . ':call nerdtree#ui_glue#invokeKeyMap("'. keymapInvokeString .'")<cr>'
endfunction

"FUNCTION: KeyMap.Remove(key, scope) {{{1
function! s:KeyMap.Remove(key, scope)
    let maps = s:KeyMap.All()
    for i in range(len(maps))
         if maps[i].key ==# a:key && maps[i].scope ==# a:scope
            return remove(maps, i)
        endif
    endfor
endfunction

"FUNCTION: KeyMap.invoke() {{{1
"Call the KeyMaps callback function
"事件的触发
function! s:KeyMap.invoke(...)
    let Callback = function(self.callback)
    "主要是有参数和没有参数的区别，当a:0为真的时候表示有参数,反之表示没有参数
    if a:0
        call Callback(a:1)
    else
        call Callback()
    endif
endfunction

"FUNCTION: KeyMap.Invoke() {{{1
"Find a keymapping for a:key and the current scope invoke it.
"
"Scope is determined as follows:
"   * if the cursor is on a dir node then "DirNode"
"   * if the cursor is on a file node then "FileNode"
"   * if the cursor is on a bookmark then "Bookmark"
"
"If a keymap has the scope of "all" then it will be called if no other keymap
"is found for a:key and the scope.
"这里才是真正的事件调用相应的地方这里传进来的是普通模式下的按键值
function! s:KeyMap.Invoke(key)

    "required because clicking the command window below another window still
    "invokes the <LeftRelease> mapping - but changes the window cursor
    "is in first
    "
    "TODO: remove this check when the vim bug is fixed
    if !g:NERDTree.ExistsForBuf()
        return {}
    endif

    " 获取当前选中的节点
    let node = g:NERDTreeFileNode.GetSelected()
    if !empty(node)

        "try file node
        if !node.path.isDirectory
            let km = s:KeyMap.FindFor(a:key, "FileNode")
            if !empty(km)
                return km.invoke(node)
            endif
        endif

        "try dir node
        if node.path.isDirectory
            let km = s:KeyMap.FindFor(a:key, "DirNode")
            if !empty(km)
                return km.invoke(node)
            endif
        endif

        "try generic node
        let km = s:KeyMap.FindFor(a:key, "Node")
        if !empty(km)
            return km.invoke(node)
        endif

    endif

    "try bookmark
    let bm = g:NERDTreeBookmark.GetSelected()
    if !empty(bm)
        let km = s:KeyMap.FindFor(a:key, "Bookmark")
        if !empty(km)
            return km.invoke(bm)
        endif
    endif

    "try all
    let km = s:KeyMap.FindFor(a:key, "all")
    if !empty(km)
        return km.invoke()
    endif
endfunction

"FUNCTION: KeyMap.Create(options) {{{1
function! s:KeyMap.Create(options)
    let opts = extend({'scope': 'all', 'quickhelpText': ''}, copy(a:options))

    "dont override other mappings unless the 'override' option is given
    if get(opts, 'override', 0) == 0 && !empty(s:KeyMap.FindFor(opts['key'], opts['scope']))
        return
    end

    let newKeyMap = copy(self)
    let newKeyMap.key = opts['key']
    let newKeyMap.quickhelpText = opts['quickhelpText']
    let newKeyMap.callback = opts['callback']
    let newKeyMap.scope = opts['scope']

    call s:KeyMap.Add(newKeyMap)
endfunction

"FUNCTION: KeyMap.Add(keymap) {{{1
function! s:KeyMap.Add(keymap)
    call s:KeyMap.Remove(a:keymap.key, a:keymap.scope)
    call add(s:KeyMap.All(), a:keymap)
endfunction

" vim: set sw=4 sts=4 et fdm=marker:
