package model
{
	/**
	 * The arena is a circle in a square 
	 */	
	[Bindable]
	public class Arena
	{	
		public var height:int;
		
		public var width:int;

		public var radius:Number = 250;
		
		public var squareRadius:uint = radius * radius; 
		
	}
}