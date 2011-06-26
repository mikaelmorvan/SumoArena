package model.vo
{
	import flash.geom.Point;

	[Bindable]
	public class Sphere
	{

		public var x:Number = 0;
		
		
		public var y:Number = 0;
		
		public const xOffset:int = 280; // arena.width/2 - sphere.radius
		
		public const yOffset:int = 280; // arena.height/2 - sphere.radius
		
		public var speedVector:Point;
		
		public var maxSpeedVariation:Number;
		
		public var player:Player;
		
		public var radius:int = 20;
		
		public var isInArena:Boolean;
		
		
		public function toString():String
		{
			return "Sphere{x:" + x + ", y:" + y + ", xOffset:" + xOffset + ", yOffset:" + yOffset + ", speedVector:" + speedVector + ", maxSpeedVariation:" + maxSpeedVariation + ", player:" + player.name + ", radius:" + radius + ", isInArena:" + isInArena + "}";
		}


	}
}