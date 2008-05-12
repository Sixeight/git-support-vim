
command Gitadd :!git add %
command Gitcommit :call s:GitCommit()
command Gitstatus :!git status
command Gitdiff :!git diff

nmap <leader>ga :Gitadd<cr><cr>
nmap <leader>gc :Gitcommit<cr>
nmap <leader>gs :Gitstatus<cr>
nmap <leader>gd :Gitdiff<cr>

func! s:GitCommit()
  let msg = input('commit message > ')
  exe "!git commit % -m '" . msg . "'"
endfunc
