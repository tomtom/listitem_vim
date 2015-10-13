" @Author:      Tom Link (mailto:micathom AT gmail com?subject=[vim])
" @License:     GPL (see http://www.gnu.org/licenses/gpl.txt)
" @Last Change: 2015-10-13.
" @Revision:    21

if !exists('g:tinykeymap#map#listitem#options')
    " :read: let g:tinykeymap#map#listitem#options = {...}   "{{{2
    let g:tinykeymap#map#listitem#options = {
                \ 'name': 'move list item',
                \ 'after': 'call tlib#buffer#ViewLine(line("."))',
                \ 'start': 'call tlib#buffer#ViewLine(line("."))',
                \ }
endif

" Move list items
call tinykeymap#EnterMap("listitem", g:tinykeymap#mapleader . g:listitem#map, g:tinykeymap#map#listitem#options)
call tinykeymap#Map("listitem", "h", "silent call tinykeymap#listitem#ShiftListItem('<')",
            \ {'desc': 'Shift list item left'})
call tinykeymap#Map("listitem", "l", "silent call tinykeymap#listitem#ShiftListItem('>')",
            \ {'desc': 'Shift list item right'})
call tinykeymap#Map("listitem", "j", "silent call tinykeymap#listitem#MoveListItem('down')",
            \ {'desc': 'Move list item down'})
call tinykeymap#Map("listitem", "k", "silent call tinykeymap#listitem#MoveListItem('up')",
            \ {'desc': 'Move list item up'})
call tinykeymap#Map("listitem", "p", "norm vii\<esc>'<kvii\<esc>'<^",
            \ {'desc': 'Go to previous list item'})
call tinykeymap#Map("listitem", "n", "norm vii\<esc>'>j^",
            \ {'desc': 'Go to next list item'})

