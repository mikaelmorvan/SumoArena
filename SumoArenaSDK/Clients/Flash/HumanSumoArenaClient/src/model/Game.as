package model
{
	import mx.collections.ArrayList;

	[Bindable]
	public class Game
	{
		public function Game()
		{
		}
		
		public var arena:Arena;
		
		public var spheres:ArrayList;
		
		public function createSpheres(data:Object):void
		{
			spheres = new ArrayList();
			arena = new Arena();
			arena.radius = data.arenaInitialRadius;
			for (var i:int = 0; i < data.playerCount; i++) 
			{
				var sphere:Sphere = new Sphere();
				sphere.isInArena = true;
				sphere.maxSpeedVariation = data.maxSpeedVariation;
				sphere.radius = data.sphereRadius;
				sphere.isPlayer = i == data.yourIndex;
				spheres.addItem(sphere);
			}
		}
		
		public function updateSpheres(data:Object):void
		{
			arena.radius = data.arenaRadius;
			for (var i:int = 0; i < data.players.length; i++) 
			{
				var sphere:Sphere = spheres.getItemAt(i) as Sphere;
				var player:Object = data.players[i];
				sphere.isInArena = player.inArena;
				sphere.x = player.x;
				sphere.y = player.y;
				sphere.xSpeed = player.vx;
				sphere.ySpeed = player.vy;
				spheres.addItem(sphere);
			}
		}
	}
}