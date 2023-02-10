" Title:        vim-tts
" Description:  Edit and build your Tabletop Simulator scripts with thsi integration for the TTS API.
" Last Change:  10FEB2023
" Maintainer:   TBD

" Prevents the plugin from being loaded multiple times. If the loaded
" variable exists, do nothing more. Otherwise, assign the loaded
" variable and continue running this instance of the plugin.
if exists("g:loaded_vim_tts")
    finish
endif
let g:loaded_vim_tts = 1

" Exposes the plugin's functions for use as commands in Vim.
command! -nargs=0 DisplayTime call example-plugin#DisplayTime()
command! -nargs=0 DefineWord call example-plugin#DefineWord()
command! -nargs=0 AspellCheck call example-plugin#AspellCheck()

function! tts#DisplayTime(...)
    if a:0 > 0 && (a:1 == "d" || a:1 == "t")
        if a:1 == "d"
            echo strftime("%b %d")
        elseif a:1 == "t"
            echo strftime("%H:%M")
        endif
    else
        echo strftime("%b %d %H:%M")
    endif
endfunction
