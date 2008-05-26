" TODO: 別のディレクトリにいる時でも正常に動作するようにする。
"       cdすれば良いだけなので近いうちにやる

command! Gitinit :!git init
command! Gitadd :!git add %
command! Gitcommit :call <SID>GitCommit()
command! Gitpush :call <SID>GitPush()
command! Gitstatus :call <SID>SetBuffer("status", [])
command! Gitdiff :call <SID>SetBuffer("diff", ["setlocal syntax=diff"])
command! Gitlog :call <SID>SetBuffer("log", [])
command! Github :!git hub

nmap <leader>gi :Gitinit<cr>
nmap <leader>ga :Gitadd<cr>
nmap <leader>gc :Gitcommit<cr>
nmap <leader>gp :Gitpush<cr>
nmap <leader>gs :Gitstatus<cr>
nmap <leader>gd :Gitdiff<cr>
nmap <leader>gl :Gitlog<cr>
nmap <leader>gh :Github<cr>


func! s:SetBuffer(cmd, statements)
   exe 'bo sp [' . a:cmd . ']'
   call eval("append(0, split(system('git " . a:cmd . "'), '\n'))")
   call cursor(1, 1)

   setlocal nomodifiable
   setlocal nobuflisted
   setlocal nonumber
   setlocal noswapfile
   setlocal buftype=nofile
   setlocal bufhidden=delete
   setlocal noshowcmd
   setlocal nowrap
   noremap <buffer> <silent> q :close<cr>
   for s:statement in a:statements
     exe s:statement
   endfor
endfunc

func! s:GitCommit()
  let msg = input('commit message > ')
  if msg == ''
    echohl ErrorMsg
    echo 'no commit message'
    echohl None
    return
  endif
  exe "!git commit % -m '" . msg . "'"
endfunc

func! s:GitPush()
  let to   = input('to > ', 'origin')
  let from = input('from > ', 'master')
  exe "!git push " . to . ' ' . from
endfunc
