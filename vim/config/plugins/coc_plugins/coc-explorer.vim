""""""""""""""""
""" coc-explorer
""""""""""""""""
if g:HasCocPlug('coc-explorer')
    let g:coc_explorer_global_presets = {
        \   '.vim': {
        \      'root-uri': '~/.vim',
        \   },
        \   'floating': {
        \      'position': 'floating',
        \      'floating-position': 'center',
        \      'floating-width': 100,
        \      'open-action-strategy': 'sourceWindow',
        \      'file-child-template': '[git | 2] [selection | clip | 1] [indent] [icon | 1] [diagnosticError & 1] [filename omitCenter 1][modified][readonly] [linkIcon & 1][link growRight 1] [timeCreated | 8] [size]'
        \   },
        \   'floatingTop': {
        \     'position': 'floating',
        \     'floating-position': 'center-top',
        \     'open-action-strategy': 'sourceWindow',
        \   },
        \   'floatingLeftside': {
        \      'position': 'floating',
        \      'floating-position': 'left-center',
        \      'floating-width': 100,
        \      'open-action-strategy': 'sourceWindow',
        \   },
        \   'floatingRightside': {
        \      'position': 'floating',
        \      'floating-position': 'right-center',
        \      'floating-width': 100,
        \      'open-action-strategy': 'sourceWindow',
        \   },
        \   'simplify': {
        \     'file-child-template': '[selection | clip | 1] [indent][icon | 1] [filename omitCenter 1]'
        \   }
    \ }

    " Use preset argument to open it
    " nmap <space>rd :CocCommand explorer --preset .vim<CR>
    nmap <F2> :CocCommand explorer<CR>
    if !g:HasPlug('ranger.vim')
        nmap <leader>f :CocCommand explorer --preset floating<CR>
    endif

    " config
    call coc#config("explorer.icon.enableNerdfont", v:true)
    call coc#config("explorer.bookmark.child.template", "[selection | 1] [filename] [position] - [annotation]")
    " call coc#config("explorer.file.autoReveal", v:true)
    " call coc#config("explorer.keyMappingMode", "none")
      " "\ 'a': v:false,
    call coc#config("explorer.keyMappings.global", {
        \ 'i': 'nodePrev',
        \ 'I': 'normal:5i',
        \ 'k': 'nodeNext',
        \ 'K': 'normal:5k',
        \ 'j': 'collapse',
        \ 'l': ['expandable?', 'expand', 'open'],
        \ 'L': 'expand:recursive',
        \ 'J': 'collapse:recursive',
        \ '<cr>': ['expandable?', 'cd', 'open'],
        \ '<bs>': 'gotoParent',
        \ 'r': 'refresh',
        \ 't': ['toggleSelection', 'normal:j'],
        \ 'T': ['toggleSelection', 'normal:k'],
        \ '*': 'toggleSelection',
        \ 'os': 'open:split',
        \ 'ov': 'open:vsplit',
        \ 'ot': 'open:tab',
        \ 'dd': 'cutFile',
        \ 'Y': 'copyFile',
        \ 'D': 'delete',
        \ 'P': 'pasteFile',
        \ 'R': 'rename',
        \ 'a': 'addFile',
        \ 'yp': 'copyFilepath',
        \ 'yn': 'copyFilename',
        \ 'gp': 'preview:labeling',
        \ 'x': 'systemExecute',
        \ 'f': 'search',
        \ 'F': 'searchRecursive',
        \ '<tab>': 'actionMenu',
        \ '?': 'help',
        \ 'q': 'quit',
        \ '<esc>': 'esc',
        \ 'gf': 'gotoSource:file',
        \ 'gb': 'gotoSource:buffer',
        \ '[[': 'sourcePrev',
        \ ']]': 'sourceNext',
        \ '[d': 'diagnosticPrev',
        \ ']d': 'diagnosticNext',
        \ '[c': 'gitPrev',
        \ ']c': 'gitNext',
        \ '<<': 'gitStage',
        \ '>>': 'gitUnstage',
    \ })
endif
