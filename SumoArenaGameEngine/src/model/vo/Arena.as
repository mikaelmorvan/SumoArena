package model.vo
{
	/**
	 * The arena is a circle in a square 
	 */	
	[Bindable]
	public class Arena
	{	
		public var height:int;
		
		public var width:int;
		
		
		public var initialRadius:int = 250;
		
		public var minimalRadius:int = 0;
		
		public var radius:Number = 250;
		
		public var squareRadius:uint = radius * radius; 
		
		// the number of ticks from the begining of the game after which the arena will start reducing
		public var shrinkingStartTick:int = -1;
		
		// the number of ticks from the begining of the game when the next shrinking will occur
		public var nextShrinkingTick:uint;
		
		public var shrinking:uint = 10;
		
		public var shrinkingInterval:uint = 10;
		
		public function toString():String
		{
			return "Arena{height:" + height + ", width:" + width + ", initialRadius:" + initialRadius + ", radius:" + radius + ", squareRadius:" + squareRadius + ", shrinkingStartTick:" + shrinkingStartTick + ", nextShrinkingTick:" + nextShrinkingTick + ", shrinking:" + shrinking + ", shrinkingInterval:" + shrinkingInterval + "}";
		}


	}
}