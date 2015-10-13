" @Author:      Tom Link (mailto:micathom AT gmail com?subject=[vim])
" @Website:     https://github.com/tomtom
" @License:     GPL (see http://www.gnu.org/licenses/gpl.txt)
" @Last Change: 2015-10-13
" @Revision:    3


function! tinykeymap#listitem#ShiftListItem(direction) "{{{3
    call listitem#SelectListItem('.')
    exec 'norm!' a:direction
endf


function! tinykeymap#listitem#MoveListItem(direction) "{{{3
    let t = @t
    try
        let item_indent = listitem#SelectListItem('.')
        if item_indent > 0
            " TLogVAR 1, line('.')
            norm! "td
            let lnum = line('.')
            if a:direction == 'up'
                let lmove = -1
                let lnum -= 1
            else
                let lmove = 1
            endif
            let lmax = line('$')
            while lnum > 0 && lnum <= lmax && (indent(lnum) > item_indent || getline(lnum) !~ '\S')
                let lnum += lmove
            endwh
            if lnum == 0 || lnum > lmax
                norm! u
            else
                exec lnum
                if listitem#SelectListItem('.') > 0
                    " TLogVAR 2, line('.')
                    exec "norm! \<Esc>"
                    if a:direction == 'up'
                        exec line("'<")
                        " TLogVAR 3, line('.')
                        norm! "tP
                    else
                        exec line("'>")
                        " TLogVAR 3, line('.')
                        norm! "tp
                    endif
                    " TLogVAR 4, line('.')
                else
                    norm! u
                endif
            endif
        endif
    finally
        let @t = t
    endtry
endf


