" Title:        vim-tabletop_sim
" Description:  Edit and build your Tabletop Simulator scripts with this
"               integration for the tabletop_sim API.
" Last Change:  10FEB2023
" Maintainer:   TBD


" Prevents the plugin from being loaded multiple times. If the loaded
" variable exists, do nothing more. Otherwise, assign the loaded
" variable and continue running this instance of the plugin.

if exists("g:loaded_vim_tabletop_sim")
    finish
endif
let g:loaded_vim_tabletop_sim = 1


" Key Mappings
if !hasmapto('<Plug>tabletop_sim;')           
    map <unique> <Leader>a  <Plug>tabletop_simAdd; 
endif
noremap <unique> <script> <Plug>tabletop_simAdd; <SID>Add
noremenu <script> Plugin.Add\ Correction      <SID>Add  " Menu entry


" Exposes the plugin's functions for use as commands in Vim.
noremap <SID>Add  :call <SID>Add(expand("<cword>"), true)<CR>
def Add(from: string, correct: bool)
    var to = input($"type the correction for {from}: ")
    exe $":iabbrev {from} {to}"
    if correct | exe "normal viws\<C-R>\" \b\e" | endif 
    count += 1                                          
    echo "you now have " .. count .. " corrections"     
enddef
if !exists(":Correct")                                 
  command -nargs=1  Correct  :call Add(<q-args>, false)
endif                                                  
