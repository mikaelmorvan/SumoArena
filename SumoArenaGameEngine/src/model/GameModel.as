package model
{
	import model.vo.Arena;
	import model.vo.Game;
	import model.vo.Player;
	import model.vo.Sphere;
	import model.vo.SphereConfiguration;
	
	import org.robotlegs.mvcs.Actor;
	
	import service.Server;
	
	public class GameModel extends Actor
	{
		[Inject]
		public var server:Server;
		
		public var game:Game;
		
		public const COLORS:Array = [0x000000, 0x8C1717, 0x385E0F, 0x236B8E, 0xFFCC11, 0x6600FF, 0xFF00AA];
		
		public function GameModel()
		{
			game = new Game();
		}

		/**
		 * Starts the game
		 * sends game description to clients 
		 */		
		public function start(sphereConfiguration:SphereConfiguration):void
		{
			game.currentTick = 0;
			_nextRequest = 0;
			initAliveSphere();
			
			for (var i:int = 0; i < game.selectedPlayers.length; i++)
			{
			//TODO gérer les rounds
				var player:Player = game.selectedPlayers.getItemAt(i) as Player;
				player.id = "player" + (i + 1);
				var roundDescription:Object = {
					"action": "prepare",
					"parameters" : 
					{
						"yourId": player.id,
						"playerCount": game.selectedPlayers.length,
						"arenaInitialRadius": game.arena.initialRadius,
						"sphereRadius": sphereConfiguration.radius,
						"maxSpeedVariation": sphereConfiguration.speedVariation,
						"currentRound": 1,
						"roundForVictory": 1
					}
				}
				server.send(player, roundDescription);
			}
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
					sphere.xOffset = game.arena.width / 2 - sphere.radius;
					sphere.yOffset = game.arena.height / 2 - sphere.radius;
				}
		}
		
		// the number of ticks at which the players must be interrogated
		private var _nextRequest:int;
		
		public function update():void
		{
			game.currentTick++;
			
			if(game.currentTick >= _nextRequest)
			{
				_nextRequest = game.currentTick + Game.REQUEST_INTERVAL;
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
					"x": player.sphere.x,
					"y": player.sphere.y,
					"vx": player.sphere.speedVector.x,
					"vy": player.sphere.speedVector.y,
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
					//TODO: dispatch a signal
					sphere.isInArena = false;
					game.aliveSpheres.removeItem(sphere);
				} else {
					i++;
				}
			}			
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
			game.maxWinningRounds = value;
		}

		public function set turnDuration(value:int):void
		{
			game.turnDuration = value;
			game.stepByTurn = game.turnDuration / Game.REQUEST_INTERVAL;
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