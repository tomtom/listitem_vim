" @Author:      Tom Link (mailto:micathom AT gmail com?subject=[vim])
" @License:     GPL (see http://www.gnu.org/licenses/gpl.txt)
" @Last Change: 2015-10-13
" @Revision:    52


if !exists('g:listitem#map')
    let g:listitem#map = 'ii'   "{{{2
endif


if !exists('g:listitem#ft_def')
    " :read: let g:listitem#ft_def = {...}    "{{{2
    let g:listitem#ft_def = {'*': {'rx': '^\s\+\ze\(#[A-Z]\d\?\|#\d[A-Z]\?\|[-+*#?@]\|[0-9#]\+\.\|[a-zA-Z?]\.\|.\{-1,}\s::\)\s', 'minindent': 1}
                \ , 'markdown': {'rx': '^\s*\ze[-+*]\s'}
                \ }
    if exists('g:listitem#ft_def_user')
        let g:listitem#ft_def = extend(g:listitem#ft_def, g:listitem#ft_def_user)
    endif
endif


function! listitem#Install(bufferlocal) abort "{{{3
    let mod = a:bufferlocal ? '<buffer>' : ''
    exec 'vnoremap' mod '<expr>' g:listitem#map 'listitem#ListItemTextObject()'
    exec 'omap' mod g:listitem#map ':normal V'. g:listitem#map .'<cr>'
endf


" " Create a new text-object ii that works on a inner list item. Once the 
" " maps are enabled, users may, e.g., visually select an item in a list 
" " by typing vii. See |listitem#SelectListItem()| for a definition of what is 
" " considered a list item.
function! listitem#ListItemTextObject() "{{{3
    if indent('.') == 0
        return "ip"
    else
        return ":\<c-u>silent! call listitem#SelectListItem('.')\<cr>"
    endif
endf


" Visually select the list item at line lnum.
" A list item also contains all its child items. E.g. in a list like:>
"
"   1. Venenatis diam dignissim dui. Praesent risus.
"   2. Tincidunt facilisis, est nisi pellentesque ligula.
"       a. Adipiscing dui non quam.
"       b. Duis posuere tortor.
"   3. Massa lorem, dignissim at, vehicula et.
"
" If the cursor is placed on item #2, this function also selects the 
" items a and b.
function! listitem#SelectListItem(lnum) "{{{3
    let lnum = line(a:lnum)
    if lnum == 0
        let lnum = a:lnum
    endif
    let lbeg = lnum
    let item_indent = -1
    let def = listitem#GetDef()
    let minindent = get(def, 'minindent', 0)
    " TLogVAR lbeg, indent(lbeg)
    while lbeg > 1 && indent(lbeg) >= minindent
        let item_indent = listitem#MatchList(lbeg)
        " TLogVAR lbeg, item_indent
        if item_indent >= minindent
            break
        endif
        let lbeg -= 1
    endwh
    " TLogVAR item_indent
    if item_indent >= minindent
        let lend = lnum
        let lmax = line('$')
        " TLogVAR lend, lmax
        while lend < lmax && indent(lend + 1) > item_indent
            " TLogVAR lend
            let lend += 1
        endwh
        " echom 'DBG' printf('norm! %dggV%dgg', lbeg, lend)
        exec printf('norm! %dggV%dgg', lbeg, lend)
        return item_indent
    else
        return -1
    endif
endf


function! listitem#GetDef() abort "{{{3
    let def = get(g:listitem#ft_def, &ft, {})
    if empty(def)
        let def = get(g:listitem#ft_def, '*')
    endif
    " TLogVAR def
    return def
endf


function! listitem#MatchList(lnum) "{{{3
    let def = listitem#GetDef()
    return matchend(getline(a:lnum), def.rx)
endf

