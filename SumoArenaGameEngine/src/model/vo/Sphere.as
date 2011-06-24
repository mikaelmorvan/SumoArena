package model.vo
{
	import flash.geom.Point;

	[Bindable]
	public class Sphere
	{

		public var x:Number;
		
		public var y:Number;
		
		public var xOffset:int;
		
		public var yOffset:int;
		
		public var speedVector:Point;
		
		public var maxSpeedVariation:Number;
		
		public var player:Player;
		
		public var radius:int = 20;
		
		public var wonRounds:int;
		
		public var isInArena:Boolean;
		
		
		public function toString():String
		{
			return "Sphere{x:" + x + ", y:" + y + ", xOffset:" + xOffset + ", yOffset:" + yOffset + ", speedVector:" + speedVector + ", maxSpeedVariation:" + maxSpeedVariation + ", player:" + player.name + ", radius:" + radius + ", wonRounds:" + wonRounds + ", isInArena:" + isInArena + "}";
		}


	}
}