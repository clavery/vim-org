"if (exists("b:did_vimorg"))
"  finish
"endif
"let b:did_vimorg = 1

let s:cpo_save = &cpo
set cpo&vim

setlocal iskeyword=@,@-@,48-57,_,192-255
iabbr <expr> @n strftime('[%a %m/%d %H:%M]')

" setup python
let g:_vopy=":py "
exec g:_vopy "import vim, os, sys"
exec g:_vopy "new_path = vim.eval('expand(\"<sfile>:h\")')"
exec g:_vopy "sys.path.append(new_path)"
exec g:_vopy "import vimorg"

command! -nargs=* VimOrgClockIn :python vimorg.clock_in()
nnoremap <silent> <leader>qi :VimOrgClockIn<CR>

function! VimOrgFoldLevel(lnum)
  exec g:_vopy "vimorg.FoldLevel(".a:lnum.")"
  return l:foldLevel
endfunction

setlocal foldmethod=expr
setlocal foldexpr=VimOrgFoldLevel(v:lnum)

silent! g/:LOGBOOK:/norm za
silent! g/:PROPERTIES:/norm za

""" Project (fold) text objects
" 'around fold' takes the entire project
vnoremap af :<C-U>silent! normal! zcVza<CR>
omap af :normal Vaf<CR>
" Inner fold takes the projects contents but leaves the project line
vnoremap if :<C-U>silent! normal! V]zoj<CR>
omap if :normal Vif<CR>

let &cpo = s:cpo_save
unlet s:cpo_save
