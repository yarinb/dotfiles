let g:gitgutter_map_keys = 0
let g:gitgutter_sh = $SHELL
let g:gitgutter_sign_added = '▎'
let g:gitgutter_sign_modified = '▎'
let g:gitgutter_sign_removed = '▏'
let g:gitgutter_sign_removed_first_line = '▔'
let g:gitgutter_sign_modified_removed = '▋'
nmap <leader>hj <plug>gitgutternexthunk
nmap <leader>hk <plug>gitgutterprevhunk
nmap <leader>hs <plug>gitgutterstagehunk
nmap <leader>hr <plug>gitgutterundohunk
nmap <Leader>hp <Plug>GitGutterPreviewHunk
