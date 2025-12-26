let SessionLoad = 1
let s:so_save = &g:so | let s:siso_save = &g:siso | setg so=0 siso=0 | setl so=-1 siso=-1
let v:this_session=expand("<sfile>:p")
silent only
silent tabonly
cd ~/.config/nvim
if expand('%') == '' && !&modified && line('$') <= 1 && getline(1) == ''
  let s:wipebuf = bufnr('%')
endif
let s:shortmess_save = &shortmess
if &shortmess =~ 'A'
  set shortmess=aoOA
else
  set shortmess=aoO
endif
badd +17 lua/plugins/ui.lua
badd +24 lua/plugins/init.lua
badd +20 lua/plugins/lualine.lua
badd +11 init.lua
badd +212 lua/plugins/others.lua
badd +10 health://
badd +40 lua/lsp/init.lua
badd +6 lua/core/keymaps.lua
badd +51 /usr/share/nvim/runtime/lua/vim/keymap.lua
argglobal
%argdel
tabnew +setlocal\ bufhidden=wipe
tabnew +setlocal\ bufhidden=wipe
tabnew +setlocal\ bufhidden=wipe
tabnew +setlocal\ bufhidden=wipe
tabnew +setlocal\ bufhidden=wipe
tabnew +setlocal\ bufhidden=wipe
tabnew +setlocal\ bufhidden=wipe
tabnew +setlocal\ bufhidden=wipe
tabrewind
edit lua/plugins/ui.lua
argglobal
let s:l = 15 - ((14 * winheight(0) + 39) / 78)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 15
normal! 0
tabnext
edit lua/plugins/ui.lua
argglobal
let s:l = 15 - ((14 * winheight(0) + 39) / 78)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 15
normal! 0
tabnext
tabnext
tabnext
tabnext
tabnext
edit lua/plugins/ui.lua
argglobal
let s:l = 15 - ((14 * winheight(0) + 39) / 78)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 15
normal! 0
tabnext
tabnext
edit lua/plugins/init.lua
let s:save_splitbelow = &splitbelow
let s:save_splitright = &splitright
set splitbelow splitright
wincmd _ | wincmd |
vsplit
wincmd _ | wincmd |
vsplit
2wincmd h
wincmd w
wincmd w
let &splitbelow = s:save_splitbelow
let &splitright = s:save_splitright
wincmd t
let s:save_winminheight = &winminheight
let s:save_winminwidth = &winminwidth
set winminheight=0
set winheight=1
set winminwidth=0
set winwidth=1
wincmd =
argglobal
let s:l = 24 - ((23 * winheight(0) + 39) / 79)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 24
normal! 012|
wincmd w
argglobal
if bufexists(fnamemodify("lua/core/keymaps.lua", ":p")) | buffer lua/core/keymaps.lua | else | edit lua/core/keymaps.lua | endif
if &buftype ==# 'terminal'
  silent file lua/core/keymaps.lua
endif
balt /usr/share/nvim/runtime/lua/vim/keymap.lua
let s:l = 138 - ((40 * winheight(0) + 39) / 79)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 138
normal! 0
wincmd w
argglobal
if bufexists(fnamemodify("lua/lsp/init.lua", ":p")) | buffer lua/lsp/init.lua | else | edit lua/lsp/init.lua | endif
if &buftype ==# 'terminal'
  silent file lua/lsp/init.lua
endif
balt lua/plugins/ui.lua
let s:l = 37 - ((36 * winheight(0) + 39) / 79)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 37
normal! 0
wincmd w
wincmd =
tabnext 9
if exists('s:wipebuf') && len(win_findbuf(s:wipebuf)) == 0 && getbufvar(s:wipebuf, '&buftype') isnot# 'terminal'
  silent exe 'bwipe ' . s:wipebuf
endif
unlet! s:wipebuf
set winheight=1 winwidth=20
let &shortmess = s:shortmess_save
let &winminheight = s:save_winminheight
let &winminwidth = s:save_winminwidth
let s:sx = expand("<sfile>:p:r")."x.vim"
if filereadable(s:sx)
  exe "source " . fnameescape(s:sx)
endif
let &g:so = s:so_save | let &g:siso = s:siso_save
set hlsearch
nohlsearch
let g:this_session = v:this_session
let g:this_obsession = v:this_session
doautoall SessionLoadPost
unlet SessionLoad
" vim: set ft=vim :
