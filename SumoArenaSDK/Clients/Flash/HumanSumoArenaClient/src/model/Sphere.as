package model
{
	
	[Bindable]
	public class Sphere
	{
		
		public var x:Number;
		
		public var y:Number;
		
		public var xSpeed:Number;
		public var ySpeed:Number;
		
		public var maxSpeedVariation:Number;
		
		public var isPlayer:Boolean;
		
		public var radius:int = 20;
		
		public var wonRounds:int;
		
		public var isInArena:Boolean;
		
	}
}