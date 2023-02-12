vim9script noclear
# Title:        tabletop_sim
# Description:  Edit and build your Tabletop Simulator scripts with this
#               integration for the tabletop_sim API.
# Last Change:  10FEB2023
# Maintainer:   TBD


# Prevents the plugin from being loaded multiple times. If the loaded
# variable exists, do nothing more. Otherwise, assign the loaded
# variable and continue running this instance of the plugin.

if exists('g:loaded_tabletop_sim')
    finish
endif
var loaded_tabletop_sim = 1


# Key Mappings
#### GetLuaScripts()
if !hasmapto('<Plug>tabletop_simGetLuaScripts;')
    map <unique> <Leader>g  <Plug>tabletop_simGetLuaScripts;
endif
noremap <unique> <script> <Plug>tabletop_simGetLuaScripts; <SID>GetLuaScripts
noremenu <script> Plugin.Tanletop\ Simulator.Get\ Lua\ Scripts  <SID>GetLuaScripts  # Menu entry
noremap <SID>GetLuaScripts  :call tabletop_sim#GetLuaScripts()<CR>
if !exists(':GetLuaScripts')
  command -nargs=1  GetLuaScripts  :call tabletop_sim#GetLuaScripts()
endif

#### save_and_play()
if !hasmapto('<Plug>tabletop_simSaveAndPlay;')
    map <unique> <Leader>p  <Plug>tabletop_simSaveAndPlay;
endif
noremap <unique> <script> <Plug>tabletop_simSaveAndPlay; <SID>SaveAndPlay
noremenu <script> Plugin.Tanletop\ Simulator.Save\ and\ Play  <SID>SaveAndPlay  # Menu entry
noremap <SID>SaveAndPlay  :call tabletop_sim#SaveAndPlay()<CR>
if !exists(':SaveAndPlay')
  command -nargs=1  SaveAndPlay  :call tabletop_sim#SaveAndPlay()
endif

#### send_custom_message()
if !hasmapto('<Plug>tabletop_simSendCustomMessage;')
    map <unique> <Leader>m  <Plug>tabletop_simSendCustomMessage;
endif
noremap <unique> <script> <Plug>tabletop_simSendCustomMessage; <SID>SendCustomMessage
noremenu <script> Plugin.Tanletop\ Simulator.Send\ Custom\ Message  <SID>SendCustomMessage  # Menu entry
noremap <SID>SendCustomMessage  :call tabletop_sim#SendCustomMessage()<CR>
if !exists(':SendCustomMessage')
  command -nargs=1  SendCustomMessage  :call tabletop_sim#SendCustomMessage()
endif

#### execute_lua_code()
if !hasmapto('<Plug>tabletop_simExecuteLuaCode;')
   map <unique> <Leader>x  <Plug>tabletop_simExecuteLuaCode;
endif
noremap <unique> <script> <Plug>tabletop_simExecuteLuaCode; <SID>ExecuteLuaCode
noremenu <script> Plugin.Tanletop\ Simulator.Execute\ Lua\ Code  <SID>ExecuteLuaCode  # Menu entry
noremap <SID>ExecuteLuaCode  :call tabletop_sim#ExecuteLuaCode()<CR>
if !exists(':ExecuteLuaCode')
  command -nargs=1  ExecuteLuaCode  :call tabletop_sim#ExecuteLuaCode()
endif
