" Starts a section for Python 3 code.
python3 << EOF
# Imports Python modules to be used by the plugin.
import vim
import json, requests
from jsonschema import validate, ValidationError


class TTS_Message():
    # Valid JSON must match this schema.
    schema = { }  # Any valid JSON

    # If JSON is invalid, don't even instance the class.
    def __new__(cls, json):
        try:
            validate(json, schema)
            return TTS_Message.__new__(json)
        except ValidationError:
            return None

    def __init__(self, json):
        self.raw = json
        self.message_id = raw.messageID


# API functions with VIM as the server
# VIM listens on port 39998
def recieve_new_object(json):
    # messageID: 0
    pass


def load_new_game(json):
    # messageID: 1
    pass


def recieve_debug_message(json):
    # messageID: 2
    pass


def recieve_error_message(json):
    # messageID: 3
    pass


def recieve_custom_message(json):
    # messageID: 4
    pass


def recieve_return_message(json):
    # messageID: 5
    pass


def game_saved(json):
    # messageID: 6
    pass


def object_created(json):
    # messageID: 7
    pass


# API functions with VIM as the server
# TTS listens on port 39999
def get_lua_scripts():
    # messageID: 0
    print('get_lua_scripts')


def save_and_play(json):
    # messageID: 1
    print('save_and_play')


def send_custom_message(json):
    # messageID: 2
    print('send_custom_message')


def execute_lua_code(json):
    # messageID: 3
    print('execute_lua_code')
EOF

" Calls the Python 3 functions.
function tabletop_sim#GetLuaScripts()
    python3 get_lua_scripts()
endfunction

function tabletop_sim#SaveAndPlay()
    python3 save_and_play('{}')
endfunction

function tabletop_sim#SendCustomMessage()
    python3 send_custom_message('{}')
endfunction

function tabletop_sim#ExecuteLuaCode()
    python3 execute_lua_code('{}')
endfunction
