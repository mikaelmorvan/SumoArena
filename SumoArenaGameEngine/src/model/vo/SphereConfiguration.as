package model.vo
{
	
	/**
	 * The default values to be used when creating a new sphere 
	 * @author peal6230
	 */
	[Bindable]
	public class SphereConfiguration
	{
		// default radius in pixels
		public var radius:uint = 20;
		
		// speedVariation in pixels/turn
		public var speedVariation:uint = 10;
		
		// initial distance from the arena center, in pixels
		public var initialDistance:uint = 200;
		
		
		public function toString():String
		{
			return "SphereConfiguration{radius:" + radius + ", speedVariation:" + speedVariation + ", initialDistance:" + initialDistance + "}";
		}
	}
}