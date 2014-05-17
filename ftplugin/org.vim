"if (exists("b:did_vimorg"))
"  finish
"endif
"let b:did_vimorg = 1

let s:cpo_save = &cpo
set cpo&vim

setlocal iskeyword=@,@-@,48-57,_,192-255
iabbr <expr> @n strftime('[%a %m/%d %H:%M]')

setlocal suffixesadd=.rst,.org,.txt

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

setlocal foldmethod=indent

silent! g/:LOGBOOK:/norm za
silent! g/:PROPERTIES:/norm za

function! ArchiveSelection() range
  python from datetime import date
  python wnum = "%s" % (date.today().isocalendar()[1])
  python weeknum = wnum.zfill(2)
  python datestr = date.today().strftime('%Y-%m')
  let weeknum = pyeval('weeknum')
  let datestr = pyeval('datestr')
  let curfname = expand("%:r")
  let archivefolder = expand('%:h') . "/Archive/" . datestr
  let archivefname = archivefolder . "/" . curfname . "-Week-" . weeknum . ".org"
  silent! call mkdir(archivefolder, 'p')
  exec "'<,'>w! >>" . archivefname
  norm gvd
endfunction

nnoremap <localleader>a :call ArchiveSelection()<cr>

let &cpo = s:cpo_save
unlet s:cpo_save
