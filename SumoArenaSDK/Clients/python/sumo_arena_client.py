#! /usr/bin/python

import sys

import asyncore
import socket

import json


GAME_SERVER_NAME = 'localhost'
GAME_SERVER_PORT = 9090


class StartGameInfo(object):

    def __init__(self, raw_data):

        self.ownIndex           = raw_data["yourIndex"]
        self.playerCount        = raw_data["playerCount"]
        self.arenaInitialRadius = raw_data["arenaInitialRadius"]
        self.sphereRadius       = raw_data["sphereRadius"]
        self.maxSpeedVariation  = raw_data["maxSpeedVariation"]
        self.currentRound       = raw_data["currentRound"]
        self.roundForVictory    = raw_data["roundForVictory"]


class Sphere(object):
    
    def __init__(self, raw_data):

        #self.index    = raw_data["index"]
        self.index    = raw_data["id"] # XXX Differs from the doc.
        self.position = (raw_data["x"],  raw_data["y"])
        self.speed    = (raw_data["vx"], raw_data["vy"])
        self.inArena  = raw_data["inArena"]


class PlaygroundInformation(object):

    def __init__(self, raw_data):

        self.arenaRadius = raw_data["arenaRadius"]
        self.players = [Sphere(data) for data in raw_data["players"]]


class EndGameInfo(object):

    def __init__(self, raw_data):

        print raw_data

        self.currentRound     = raw_data["currentRound"]
        self.roundWinnerIndex = raw_data["roundWinnerId"] # XXX Differs from the doc.
        self.gameWinnerIndex  = raw_data["gameWinnerId"] # XXX Differs from the doc.
        #self.roundWinnerIndex = raw_data["roundWinnerIndex"]
        #self.gameWinnerIndex  = raw_data["gameWinnerIndex"]


class Player(object):

    def __init__(self, client):
        
        self._client = client

    def on_prepare_information(self, startInfo):
        
        self._startInfo = startInfo

        # Get a few useful data.
        self.ownIndex  = startInfo.ownIndex
        self.radius    = startInfo.sphereRadius
        self.maxVar    = startInfo.maxSpeedVariation

        print "Round is about to start."
        print "Now playing..."

    def on_play_request(self, playgroundInfo):
        
        if not playgroundInfo.players[self.ownIndex].inArena:
            # I'm out of the arena.
            return None

        result = self._choose_acceleration(playgroundInfo)

        # Check given rules.
        #
        # Assert()ions would be a little hard on us, isn't it?

        if not isinstance(result, tuple):
            print "*** Acceleration is supposed to be a (int, int) tuple."
        if not isinstance(result[0], int):
            print "*** Acceleration is supposed to be a (int, int) tuple."
        if not isinstance(result[0], int):
            print "*** Acceleration is supposed to be a (int, int) tuple."
        if not len(result) == 2:
            print "*** Acceleration is supposed to be a (int, int) tuple."

        sq_norm = result[0] * result[0] + result[1] * result[1] 
        if sq_norm > self.maxVar * self.maxVar:
            print "*** Acceleration is too big."

        return result

    def _choose_acceleration(self, playgroundInfo):
        # Your tough job starts here.
        #
        # Your are expected to return an (int, int)
        # tuple that gives (dVx, dVy) acceleration.
        return (10, 0)

    def on_round_finished(self, endInfo):
        
        # Did I win the round?
        if endInfo.roundWinnerIndex == self.ownIndex:
            print "Hey, I just won this round."
        else:
            print "Well, I have lost this round."

        # Is the game over?
        winnerIdx = endInfo.gameWinnerIndex
        if winnerIdx < 0:
            print "I lost a battle, but I dit not lose the war."
            return

        # If so, am I the king?
        if winnerIdx == self.ownIndex:
            print "Hey, I also won this game, it seems."
        else:
            print "Kuddos to the brilliant winner (not me, sadly)."


class GameClient(asyncore.dispatcher):

    def __init__(self, address, name, avatar_url=''):

        self._player = None

        # Protocol automaton data.
        self._callbacks = {
                'acknowledgeConnection':    self._on_connection_ack,
                'prepare':                  self._on_prepare,
                'play':                     self._on_play,
                'finishRound':              self._on_finish_round
            }
        self._actions = self._callbacks.keys()

        # Prepara connection information and send it ASAP.
        self._to_send = '{ "action": "connectPlayer", "parameters": {"name": "' + name + '", "avatar_url": "' + avatar_url + '"} }'
        self._received = ''

        # Connect to the server.
        asyncore.dispatcher.__init__(self)
        self.create_socket(socket.AF_INET, socket.SOCK_STREAM)
        self.connect(address)

    def handle_connect(self):
        # Now we are connected, we need a brain.
        self._player = Player(self)

    def handle_write(self):
        # Send waiting data.
        sent = self.send(self._to_send)
        self._to_send = self._to_send[sent:]

    def handle_read(self):

        # Read what is available
        data = self.recv(1024)
        if not data:
            return
        self._received += data

        # Parse what we received.
        valid, action, params = self._parse_server_request(self._received)
        if valid:
            self._callbacks[action](params)
        else:
            print action, self._received
        self._received = '' # FIXME Could have problem with partial requests.

    def handle_close(self):
        print "Connection closed."
        self.close()

    def _parse_server_request(self, data):

        # Check JSON validity.
        req = None
        try:
            req = json.loads(data)
        except ValueError, ve:
            return False, 'Invalid JSON data', None

        # Check acceptable server actions.
        action = req.get('action', None)
        if not action:
            return False, 'No action in request', None
        if action not in self._actions:
            return False, 'Requested action is unknown', None

        # Get parameters.
        parameters = req.get('parameters', None)

        return True, action, parameters

    def _on_connection_ack(self, params):
        print "I'm connected as '%s'" % params["yourName"]

    def _on_prepare(self, params):
        info = StartGameInfo(params)
        self._player.on_prepare_information(info)

    def _on_play(self, params):
        info = PlaygroundInformation(params)
        result = self._player.on_play_request(info)
        if result:
            data = {
                "action":     "updateVector",
                "parameters": {
                    "dVx": result[0],
                    "dVy": result[1]
                }
            }
            self._to_send = json.dumps(data)

    def _on_finish_round(self, params):
        info = EndGameInfo(params)
        self._player.on_round_finished(info)


def main(argv=None):
    name = "Python example client"
    if len(argv) > 1:
        name = argv[1]
    client = GameClient( (GAME_SERVER_NAME, GAME_SERVER_PORT) , name)
    asyncore.loop()


if __name__ == "__main__":
    sys.exit( main(sys.argv) )

