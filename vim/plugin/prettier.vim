let g:prettier#autoformat = 0

" print semicolons
" Prettier default: true
let g:prettier#config#semi = 'false'
let g:prettier#config#trailing_comma = 'all'

" print spaces between brackets
" Prettier default: true
let g:prettier#config#bracket_spacing = 'true'

autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md PrettierAsync

nmap <Leader>p <Plug>(PrettierAync)
