package model
{
	import model.vo.Arena;
	import model.vo.Game;
	import model.vo.Player;
	import model.vo.Sphere;
	import model.vo.SphereConfiguration;
	
	import org.osflash.signals.Signal;
	import org.robotlegs.mvcs.Actor;
	
	import service.Server;
	
	public class GameModel extends Actor
	{
		[Inject]
		public var server:Server;
		
		public const COLORS:Array = [0x000000, 0x8C1717, 0x385E0F, 0x236B8E, 0xFFCC11, 0x6600FF, 0xFF00AA];
		
		public var game:Game;

		
		public var roundStartedSignal:Signal;
		
		public var roundFinishedSignal:Signal;
		
		public var gameStartedSignal:Signal;
		
		public var gameFinishedSignal:Signal;
		
		public function GameModel()
		{
			game = new Game();
			roundStartedSignal = new Signal();
			roundFinishedSignal = new Signal();
			gameStartedSignal = new Signal();
			gameFinishedSignal = new Signal();
		}

		/**
		 * Starts the game
		 * sends game description to clients 
		 */		
		public function startRound(sphereConfiguration:SphereConfiguration):void
		{
			if(game.currentRound == 0) {
				gameStartedSignal.dispatch();
			}
			game.currentRound++;
			game.currentTick = 0;
			_nextRequest = 0;
			initAliveSphere();
			
			for (var i:int = 0; i < game.selectedPlayers.length; i++)
			{
				var player:Player = game.selectedPlayers.getItemAt(i) as Player;
				player.id = i;
				var roundDescription:Object = {
					"action": "prepare",
					"parameters" : 
					{
						"yourIndex": player.id,
						"playerCount": game.selectedPlayers.length,
						"arenaInitialRadius": game.arena.initialRadius,
						"sphereRadius": sphereConfiguration.radius,
						"maxSpeedVariation": sphereConfiguration.speedVariation,
						"currentRound": game.currentRound,
						"roundForVictory": game.roundRequiredToWin
					}
				}
				
				server.send(player, roundDescription);
			}
			roundStartedSignal.dispatch();
		}
		
		/**
		 * Places the spheres on the arena, according to their number
		 */ 
		public function placeSpheresToInitialPosition(distanceFromCenter:uint = 0):void 
		{
			var sphereNumber:int = game.spheres.length;
			const angle:Number = 2 * Math.PI / sphereNumber;
				for (var i:int = 0; i < game.spheres.length; i++)
				{
					var sphere:Sphere = game.spheres.getItemAt(i) as Sphere;
					if (sphereNumber > 1)
					{
						sphere.x = Math.round(distanceFromCenter * Math.cos(angle * i));
						sphere.y = Math.round(distanceFromCenter * Math.sin(angle * i));
					}
					else  {
						sphere.x = 0;
						sphere.y = 0;
					}
//					sphere.xOffset = game.arena.width / 2 - sphere.radius;
//					sphere.yOffset = game.arena.height / 2 - sphere.radius;
				}
		}
		
		// the number of ticks at which the players must be interrogated
		private var _nextRequest:int;
		
		public function update():void
		{
			game.currentTick++;
			
			if(game.currentTick >= _nextRequest)
			{
				_nextRequest = game.currentTick + Game.REQUEST_INTERVAL_IN_TICKS;
				requestPlayers();
			}
		}

		/**
		 * Ask players their next action
		 */ 
		private function requestPlayers():void
		{
			var players:Array = [];
		
			for (var i:int = 0; i < game.selectedPlayers.length; i++)
			{
				var player:Player = game.selectedPlayers.getItemAt(i) as Player;
				players[i] = {
					"id": player.id,
					"x": Math.round(player.sphere.x),
					"y": Math.round(player.sphere.y),
					"vx": Math.round(player.sphere.speedVector.x),
					"vy": Math.round(player.sphere.speedVector.y),
					"inArena" : player.sphere.isInArena
				}
			}
		
			var turnInformation:Object = {
				"action": "play",
				"parameters" : 
				{
					"players": players,
					"arenaRadius": game.arena.radius
				}
			}
			server.sendToPlayers(game.selectedPlayers, turnInformation, true);
		}


		
		
		/**
		 * Removes of the alive sphere list the ones which are out of the arena 
		 */		
		public function checkSpherePosition():void
		{
			for (var i:int = 0; i < game.aliveSpheres.length;) 
			{
				var sphere:Sphere = Sphere(game.aliveSpheres.getItemAt(i));
				if (sphere.x*sphere.x + sphere.y*sphere.y > game.arena.squareRadius)
				{
					sphere.isInArena = false;
					game.aliveSpheres.removeItem(sphere);
					if(game.aliveSpheres.length < 2){
						finishRound();
					}
				} else {
					i++;
				}
			}			
		}
		
		public function finishRound():void
		{
			var roundWinnerId:int = -1;
			var gameWinnerId:int = -1;
			
			if(game.aliveSpheres.length == 1)
			{
				var winner:Player = Sphere(game.aliveSpheres.getItemAt(0)).player;
				roundWinnerId = winner.id;
				winner.wonRounds++;
				roundFinishedSignal.dispatch();
				if(winner.wonRounds >= game.roundRequiredToWin){
					gameWinnerId = roundWinnerId;
					finishGame();
				}
			}
			var data:Object = {
				"action" : "finishRound",
				"parameters" :  
					{
						"currentRound" : game.currentRound,
						"roundWinnerId" : roundWinnerId,
						"gameWinnerId" : gameWinnerId
					}
			}
			server.sendToPlayers(game.selectedPlayers, data);
		}
		
		public function finishGame():void 
		{
			game.currentRound = 0;
			gameFinishedSignal.dispatch();
		}
		
		/**
		 *  
		 * @param sphere the spehre to be added
		 * @param totalSphereNumber the total numbrer of spheres in this game
		 * @param distanceFromCenter the initial distance between the sphere and the center of the arena
		 * @return the number of spheres in the game
		 */		
		public function addSphere(sphere:Sphere, totalSphereNumber:uint=1, distanceFromCenter:uint = 0):int
		{
			game.spheres.addItem(sphere);
			return game.spheres.length;
		}
		
		public function removeSphere(sphere:Sphere):void
		{
			game.spheres.removeItem(sphere);
			sphere.isInArena = false;
		}

		private function initAliveSphere():void
		{
			game.aliveSpheres.removeAll();
			for (var i:int = 0; i < game.spheres.length; i++) 
			{	
				var sphere:Sphere = game.spheres.getItemAt(i) as Sphere;
				game.aliveSpheres.addItem(sphere);
				sphere.isInArena = true;
			}
		}
		
		public function addPlayer(player:Player):void
		{
			if(game.availablePlayers.getItemIndex(player) < 0
			   && game.selectedPlayers.getItemIndex(player) < 0)
			{
				game.availablePlayers.addItem(player);
			}
		}
		
		public function removePlayer(player:Player):void
		{
			game.availablePlayers.removeItem(player);
		}
		
		public function selectPlayer(player:Player):void
		{
			if(game.availablePlayers.getItemIndex(player) >= 0)
			{
				game.availablePlayers.removeItem(player);
				game.selectedPlayers.addItem(player);
			}
		}
		
		public function unselectPlayer(player:Player):void
		{
			if(game.selectedPlayers.getItemIndex(player) >= 0)
			{
				game.availablePlayers.addItem(player);
				game.selectedPlayers.removeItem(player);
			}
		}		
		
		public function set arena(value:Arena):void
		{
			game.arena = value;
		}

		public function set currentTick(value:uint):void
		{
			game.currentTick = value;
		}

		public function set maxWinningRounds(value:int):void
		{
			game.roundRequiredToWin = value;
		}

		public function set turnDuration(value:int):void
		{
			game.requestInterval = value;
			game.stepByTurn = game.requestInterval / Game.REQUEST_INTERVAL_IN_TICKS;
		}
		
		public function set roundDuration(value:int):void
		{
			game.roundDuration = value;
		}
		
		public function getSphereByPlayer(player:Player):Sphere
		{
			for (var i:int = 0; i < game.spheres.length; i++)
			{
				var sphere:Sphere = game.spheres.getItemAt(i) as Sphere;
				if(sphere.player == player)
				{
					return sphere;
				}
			}
			return null;
		}
	}
}