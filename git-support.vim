
command! GitInit :!git init
command! GitAdd :!git add %
command! GitCommit :call <SID>GitCommit(0)
command! GitCommitWithMsg :call <SID>GitCommit(1)
command! GitPush :call <SID>GitPush()
command! GitStatus :call <SID>SetBuffer("status")
command! GitDiff :call <SID>SetBuffer("diff")
command! GitLog :call <SID>SetBuffer("log")
command! GitHub :!git hub

nmap <leader>gi :GitInit<cr>
nmap <leader>ga :GitAdd<cr>
nmap <leader>gc :GitCommitWithMsg<cr>
nmap <leader>gp :GitPush<cr>
nmap <leader>gs :GitStatus<cr>
nmap <leader>gd :GitDiff<cr>
nmap <leader>gl :GitLog<cr>
nmap <leader>gh :GitHub<cr>

"--- main script ---
func! s:SetBuffer(cmd)
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
  exe 'set ft=Git' . a:cmd

  syn region GitCommit start=/^commit/ end=/$/
  hi link GitCommit keyword
  syn region GitCommitMsg start=/^    ./ end=/$/
  hi link GitCommitMsg function

  syn region GitStatus start=/^#/ end=/$/
    \ contains=GitStatusModified, GitStatusNewfile, GitStatusDeleted, GitStatusRenamed
  syn region GitStatusNewfile start=/new file:/ end=/$/ contained
  hi link GitStatusNewfile type
  syn region GitStatusModified start=/modified:/ end=/$/ contained
  hi link GitStatusModified title
  syn region GitStatusRenamed start=/renamed:/ end=/$/ contained
  hi link GitStatusRenamed keyword
  syn region GitStatusDeleted start=/deleted:/ end=/$/ contained
  hi link GitStatusDeleted string
  " TODO: Untrackedなファイルを赤く表示したい

  syn region GitDiffPlus start=/^+/ end=/$/
  hi link GitDiffPlus type
  syn region GitDiffMinus start=/^-/ end=/$/
  hi link GitDiffMinus string
  syn region GitDiffAtmark start=/^@/ end=/$/
  hi link GitDiffAtmark function
endfunc

func! s:GitCommit(edit)
  if a:edit == 1
    let msg = input('commit message > ')
    if msg == ''
      echohl ErrorMsg
      echo 'no commit message'
      echohl None
      return
    endif
    exe "!git commit % -m '" . msg . "'"
  else
    exe '!git commit %'
  endif
endfunc

func! s:GitPush()
  let to   = input('to > ', 'origin')
  let from = input('from > ', 'master')
  exe "!git push " . to . ' ' . from
endfunc

