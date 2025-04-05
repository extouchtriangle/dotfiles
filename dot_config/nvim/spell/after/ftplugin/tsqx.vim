" tsqx -> asy compile and open
nnoremap <leader>tp :update<CR>:silent !python -m tsqx -p % > tsqx-out.asy && asy tsqx-out.asy -f pdf && zathura tsqx-out.pdf & <CR><cr>
" tsqx -> asy compile without opening
nnoremap <leader>tc :update<CR>:silent !python -m tsqx -p % > tsqx-out.asy && asy tsqx-out.asy -f pdf <CR><cr>
" tsqx -> asy verbose
nnoremap <leader>tv :update<CR>:!python -m tsqx -p % \| asy -f pdf -<CR>
" tsqx -> asy -> clipboard
nnoremap <leader>ta :update<CR>:silent !python -m tsqx -p % \| xsel --clipboard<cr>
set nocindent
