set expandtab
set tabstop=2
set shiftwidth=2
set autoindent
set number

command! -nargs=1 SaveWithDir execute 'silent !mkdir -p %:h' | execute 'e'

augroup ShebangEntry
  autocmd!
  " --- Python ---
  autocmd BufNewFile  *.py call setline(1, ["#!/usr/bin/env python3", ""])
  autocmd BufWritePost *.py silent !chmod +x %
  " --- Bash ---
  autocmd BufNewFile  *.sh call setline(1, ["#!/bin/bash", ""])
  autocmd BufWritePost *.sh silent !chmod +x %
  " --- YAML ---
  autocmd BufNewFile *.yaml,*.yml call setline(1, ["---", ""])
  autocmd BufNewFile *.py,*.sh,*.yaml,*.yml normal! G
augroup END
