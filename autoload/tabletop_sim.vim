" Starts a section for Python 3 code.
python3 << EOF
# Imports Python modules to be used by the plugin.
from json import dumps
import requests
import selectors
import socket
from sys import stderr
from threading import Thread

from jsonschema import validate, ValidationError
import vim


def err(*args):
    print(*args, file=stderr)


def send(json_dict):
    '''Create a thread to call the _send function.'''
    thread = None
    thread = Thread(target=_send, args=[json_dict])
    thread.start()

def _send(json_dict):
    '''Create a socket and attempt to send data to Tabletop Simulator.'''
    # Tabletop Simulator listens on localhost:39999
    HOST = "127.0.0.1"
    PORT = 39999

    with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as s:
        #s.settimeout(0)
        try:
            s.connect((HOST, PORT))
        except (ConnectionError, TimeoutError) as error:
            msg = ''
            if type(error) is ConnectionError:
                msg += 'Connection Refused: TTS is either not in a game, or needs a'
                msg += ' restart.'
            elif type(error) is TimeoutError:
                msg += 'Connection Timed Out: Maybe try again in a second'

            print(error)
            err(f'ERROR: {msg}')
            return

        try:
            print(f'Sending: {json_dict}')
            s.sendall(bytes(dumps(json_dict), 'UTF8'))
        except (ConnectionError, TimeoutError):
            pass
        data = s.recv(1024)

    print(f"Received {data!r}")


class Server():
    '''An IP server that listens on host:port'''
    def __init__(self, host, port):
        self.thread = Thread(target=self.listen, args=[host, port])
        self.thread.start()

    def listen(self, host, port):
        with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as s:
            s.bind((host, port))
            s.listen()
            conn, addr = s.accept()
            with conn:
                print(f"Connected by {addr}")
                while True:
                    data = conn.recv(1024)
                    if not data:
                        break
                    conn.sendall(data)


# Tabletop Simulator sends to localhost:39998
HOST = "127.0.0.1"
PORT = 39998
server = Server(HOST, PORT)


class TTS_Message():
    # Valid JSON must match this schema.
    schema = { }  # Any valid JSON

    # If JSON is invalid, don't even instance the class.
    def __new__(cls, json_dict):
        try:
            validate(json_dict, schema)
            return TTS_Message.__new__(json_dict)
        except ValidationError:
            return None

    def __init__(self, json_dict):
        self.json_dict = json_dict
        self.message_id = json_dict.messageID


# API functions with VIM as the server
# VIM listens on port 39998
def recieve_new_object(json_dict):
    # messageID: 0
    pass


def load_new_game(json_dict):
    # messageID: 1
    mID = 1


def recieve_debug_message(json_dict):
    # messageID: 2
    pass


def recieve_error_message(json_dict):
    # messageID: 3
    pass


def recieve_custom_message(json_dict):
    # messageID: 4
    pass


def recieve_return_message(json_dict):
    # messageID: 5
    pass


def game_saved(json_dict):
    # messageID: 6
    pass


def object_created(json_dict):
    # messageID: 7
    pass


# API functions with VIM as the server
# TTS listens on port 39999
def get_lua_scripts():
    # messageID: 0
    print('get_lua_scripts')
    mID = 2
    json_dict = {
        "messageID": mID
    }
    # Client
#     with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as s:
#         HOST = "127.0.0.1"
#         PORT = 39999  # TTS listens on this port
# 
#         s.connect((HOST, PORT))
#         data = json.dumps(json_dict)
#         s.sendall(bytes(data, 'UTF8'))


# #Server
# lsock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
# HOST = "127.0.0.1"
# PORT = 39998  # TTS sends to this port
# 
# lsock.bind((HOST, PORT))
# lsock.listen()
# print(f'Listening on {(host, port)}')
# lsock.setblocking(False)
# sel.register(lsock, selectors.EVENT_READ, data=None)


def save_and_play(json_dict):
    mID = 1
    print('save_and_play')
    send({'messageID': mID})


def send_custom_message(json_dict):
    # messageID: 2
    mID = 2
    msg = 'Sending A Custom Message...'
    print(msg)
    json_dict = {
        "messageID": mID,
        "customMessage": msg
    }

    send(json_dict)


def execute_lua_code(json_dict):
    mID = 3
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
