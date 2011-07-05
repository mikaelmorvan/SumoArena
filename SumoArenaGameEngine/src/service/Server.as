package service
{
	import com.adobe.protocols.dict.Dict;
	import com.adobe.serialization.json.JSON;
	
	import controller.signals.LogSignal;
	import controller.signals.RegisterPlayerSignal;
	import controller.signals.UpdateSphereSignal;
	
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.events.ServerSocketConnectEvent;
	import flash.geom.Point;
	import flash.net.ServerSocket;
	import flash.net.Socket;
	import flash.utils.Dictionary;
	import flash.utils.getTimer;
	
	import model.vo.Player;
	
	import mx.collections.ArrayList;
	import mx.collections.IList;
	
	import org.osflash.signals.Signal;
	import org.robotlegs.mvcs.Actor;
		
	public class Server extends Actor
	{
		///////////// signals dispatched by this service //////////////
		
		[Inject]
		public var registerPlayerSignal:RegisterPlayerSignal;
		
		[Inject]
		public var logSignal:LogSignal;
		
		// dispatched when a clients sockets is closed
		public var clientDisconnected:Signal;
		
		///////////////////////////////////////////////////////////////
		
		public function Server()
		{
			clients = new Dictionary();
			clientDisconnected = new Signal(Player);
		}
		
		private var clients:Dictionary; // (name, User)
		private var serverSocket:ServerSocket;
		private var clientSockets:Array;
		
		public var respondedPlayerCount:int = 0;
		
		public function start(port:int):void
		{
			if (!serverSocket)
			{
				clientSockets = [];
				startSocketServer(port);
			}
		}

		/**
		 * Broadcast a Json Message to a given player
		 * @param data the object to be serialized to json
		 */ 
		public function send(player:Player, data:Object, expectResponse:Boolean=false):void
		{
			player.responseExpected = expectResponse;
			try
			{
				var dataToString:String = JSON.encode(data) + "\n";
				player.socket.writeUTFBytes(dataToString);
				player.socket.flush();
				log("SEND: " + getTimer() + dataToString);
			}
			catch (error:Error) {
				log("ERROR: can't write on socket for player " + player.name);
			}
		}
		
		/**
		 * Broadcast a Json Message to a given player list
		 * @param data the object to be serialized to json
		 * @param expectResponse when true, the client should send a response
		 */ 
		public function sendToPlayers(players:ArrayList, data:Object, expectResponse:Boolean=false):void
		{
			if (expectResponse)
			{
				respondedPlayerCount = 0;
			}
			for each (var player:Player in players.source) 
			{
				send(player, data, expectResponse);
			}
		}
		
		public function stop():void
		{
			if (serverSocket)
			{
				serverSocket.removeEventListener(ServerSocketConnectEvent.CONNECT, onConnect);
				serverSocket.close();
				serverSocket = null;
			}	
		}	
		
		private function startSocketServer(port:int):void 
		{
			if(!serverSocket)
			{
				try {
					serverSocket = new ServerSocket();
					serverSocket.addEventListener(ServerSocketConnectEvent.CONNECT, onConnect);
					serverSocket.bind(port);
					serverSocket.listen();
					log(">server started, listening on port " + port);
					
				}
				catch (error:Error) {
					log("ERROR: " + error); 
				}
			}
			else {
				log(">server is already listening on port " + port);
			}
		}
		
		protected function onConnect(event:ServerSocketConnectEvent):void
		{
			var clientSocket:Socket = event.socket;
			clientSocket.addEventListener(ProgressEvent.SOCKET_DATA, onData);
			clientSocket.addEventListener(Event.CLOSE, onClientConnectionClosed);
			
			log(">new client socket opened");
			clientSockets.push(clientSocket);
		}
		
		protected function onData(event:ProgressEvent):void
		{
			var clientSocket:Socket = event.target as Socket;
			if (clientSocket.bytesAvailable)
			{
				var s:String = clientSocket.readUTFBytes(clientSocket.bytesAvailable);
				
				var player:Player = Player(clients[clientSocket]);
				var playerName:String = player ? player.name : "new player"; 
				log(">received data from " + playerName  + " = " + s);
				if(s == "<policy-file-request/>") 
				{
					clientSocket.writeUTFBytes("<cross-domain-policy><allow-access-from domain='*' to-ports='*' secure='false' /></cross-domain-policy>"
						+ String.fromCharCode(0));
					clientSocket.flush();
				}
				else {
					try {
						var data:Object = JSON.decode(s);
						processData(data, clientSocket);
					}
					catch (error:Error) {
						log("ERROR: " + playerName + " response is not a valid Json : " + s); 
					}
				}
			}
		}
		
		protected function onClientConnectionClosed(event:Event):void
		{
			var clientSocket:Socket = event.target as Socket;
			var index:int = clientSockets.indexOf(clientSocket);
			clientSockets.splice(index, 1);
			
			var player:Player = Player(clients[clientSocket]);
			var playerName:String = player ? player.name : "unknown player";
			clientDisconnected.dispatch(player);
			log(">client disconnected " + playerName);
		}
		
		
		private function log(message:String):void
		{
			logSignal.dispatch(message);
		}
		
		
		
		public function processData(data:Object, clientSocket:Socket):void
		{
			var player:Player = clients[clientSocket];
			if (!player)
			{
				player = new Player();
				player.socket = clientSocket;
				clients[clientSocket] = player;
			}
			if(data.action == 'updateVector' || data.action == 'connectPlayer') 
			{
				this[data.action](player, data.parameters);
			}
			else {
				log("WARNING: unknown action requested by client " + player.name);
			}
		}
		
		/**
		 * Called when a client sends a connection message
		 * @param player
		 * @param data
		 */		
		public function connectPlayer(player:Player, data:Object):void
		{
			player.name = data.name;
			player.avatar = data.avatarUrl;
			registerPlayerSignal.dispatch(player);
			var response:Object = {
					"action": "acknowledgeConnection",
					"parameters": {	"yourName" : player.name }
				};
			send(player, response);
		}
		
		public function updateVector(player:Player, data:Object):void
		{
			if(player.responseExpected)
			{
				respondedPlayerCount++; 
				if(player.requestedDx != data.dVx || player.requestedDy != data.dVy)
				{
					player.requestedDx = data.dVx;
					player.requestedDy = data.dVy;
				}
				player.responseExpected = false;
			}
			else {
				log("WARNING: unexpected message from client " + player.name);
			}
		}
	}
}