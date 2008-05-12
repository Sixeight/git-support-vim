
command Gitinit :!git init
command Gitadd :!git add %
command Gitcommit :call s:GitCommit()
command Gitpush :call s:GitPush()
command Gitstatus :!git status
command Gitdiff :!git diff
command Gitlog :!git log

nmap <leader>gi :Gitinit<cr>
nmap <leader>ga :Gitadd<cr>
nmap <leader>gc :Gitcommit<cr>
nmap <leader>gp :Gitpush<cr>
nmap <leader>gs :Gitstatus<cr>
nmap <leader>gd :Gitdiff<cr>
nmap <leader>gl :Gitlog<cr>

func! s:GitCommit()
  let msg = input('commit message > ')
  echo msg
"   exe "!git commit % -m '" . msg . "'"
endfunc

func! s:GitPush()
  let to   = input('to > ', 'origin')
  let from = input('from > ', 'master')
  exe "!git push " . to . ' ' . from
endfunc
