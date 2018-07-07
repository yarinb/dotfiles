let g:ale_linters = {
\   'python': ['flake8']
\}

let g:ale_sign_error = '●'
let g:ale_sign_warning = '.'
nmap <silent> <C-n> <Plug>(ale_next_wrap)
nmap <silent> <C-N> <Plug>(ale_previous_wrap)
