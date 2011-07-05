package model.event
{
	import flash.events.Event;
	
	public class UpdateSphereEvent extends Event
	{
		public static const UPDATE:String = "update";
		
		public var x:Number;
		
		public var y:Number;
		
		public function UpdateSphereEvent(type:String, x:Number, y:Number, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.x = x;
			this.y = y;
		}
	}
}