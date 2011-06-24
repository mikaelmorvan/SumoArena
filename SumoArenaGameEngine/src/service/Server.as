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
	
	import model.vo.Player;
	
	import mx.collections.ArrayList;
	import mx.collections.IList;
	
	import org.robotlegs.mvcs.Actor;
		
	public class Server extends Actor
	{
		///////////// signals dispatched by this service //////////////
		
		[Inject]
		public var registerPlayerSignal:RegisterPlayerSignal;
		
		[Inject]
		public var updateSphereSignal:UpdateSphereSignal;
		
		[Inject]
		public var logSignal:LogSignal;
		
		///////////////////////////////////////////////////////////////
		
		public function Server()
		{
			clients = new Dictionary();
		}
		
		private var clients:Dictionary; // (name, User)
		private var serverSocket:ServerSocket;
		private var clientSockets:Array;
		
		public function start(port:int):void
		{
//			close();
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
				player.socket.writeUTFBytes(JSON.encode(data) + "\n");
				player.socket.flush();
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
		public function sendToPlayers(players:ArrayList, data:Object, expectResponse:Boolean):void
		{
			for each (var player:Player in players.source) 
			{
				send(player, data, expectResponse);
			}
		}
		
		public function allowClientsToRespond():void
		{
			for each (var player:Player in clients) // TODO devrait être selected players
			{
				player.responseExpected = true;
			}
		}
		
		public function close():void
		{
			if (serverSocket)
			{
				serverSocket.removeEventListener(ServerSocketConnectEvent.CONNECT, onConnect);
				serverSocket.close();
				serverSocket = null;
			}	
		}	
		
		private function startSocketServer(port:int):void {
			if(!serverSocket)
			{
				try {
					serverSocket = new ServerSocket();
					serverSocket.addEventListener(ServerSocketConnectEvent.CONNECT, onConnect);
					//			serverSocket.addEventListener(Event.CLOSE, onClose);
					serverSocket.bind(port);
					serverSocket.listen();
					log(">server listening on port " + port);
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
			clientSocket.addEventListener(Event.CLOSE, onConnectionClosed);
			
			log(">new client connected");
			clientSockets.push(clientSocket);
			
			
//			{
//				"action": "acknowledgeConnection"
//				"parameters": "yourName" : "..."
//			}
			
			
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
				try {
					var data:Object = JSON.decode(s);
					processData(data, clientSocket);
				}
				catch (error:Error) {
					log("ERROR: " + playerName + " response is not a valid Json : " + s); 
				}
			}
		}
		
		protected function onConnectionClosed(event:Event):void
		{
			var clientSocket:Socket = event.target as Socket;
			var index:int = clientSockets.indexOf(clientSocket);
			clientSockets.splice(index, 1);
			
			var player:Player = Player(clients[clientSocket]);
			var playerName:String = player ? player.name : "unknown player"; 
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
		}
		
		public function updateVector(player:Player, data:Object):void
		{
			if(player.responseExpected)
			{
				if(player.requestedDx != data.dVx && player.requestedDy != data.dVy)
				{
					player.requestedDx = data.dVx;
					player.requestedDy = data.dVy;
					updateSphereSignal.dispatch(player);
				}
				player.responseExpected = false;
					
			}
			else {
				log("WARNING: unexpected message from client " + player.name);
			}
		}
	}
}