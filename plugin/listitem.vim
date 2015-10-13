" @Author:      Tom Link (micathom AT gmail com?subject=[vim])
" @License:     GPL (see http://www.gnu.org/licenses/gpl.txt)
" @Last Change: 2015-10-12
" @Revision:    4
" GetLatestVimScripts: 0 0 :AutoInstall: listitem.vim
" A list item text object (map: ii)

if &cp || exists("loaded_listitem")
    finish
endif
let loaded_listitem = 1

let s:save_cpo = &cpo
set cpo&vim


if !exists('g:listitem_filetypes')
    let g:listitem_filetypes = ['text', 'markdown', 'markdown.pandoc', 'rst', 'viki']   "{{{2
endif


augroup AU_NAME
    for s:ft in g:listitem_filetypes
        " this one is which you're most likely to use?
        exec 'autocmd FileType' s:ft 'call listitem#Install(1)'
    endfor
    unlet! s:ft
augroup END


let &cpo = s:save_cpo
unlet s:save_cpo
