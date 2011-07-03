package model.vo
{
	import flash.geom.Point;
	
	import mx.controls.Image;

	[Bindable]
	public class Sphere
	{

		private var _x:Number = 0;
		
		
		private var _y:Number = 0;
		
		public var speedVectorX:int = 0;

		public var speedVectorY:int = 0;
		
		public var rotation:Number=0.0;
		
		public var maxSpeedVariation:Number;
		
		public var player:Player;
		
		public var radius:int = 20;
		
		private var _isInArena:Boolean;
		
		public var image:Image;
		


		public function get x():Number
		{
			return _x;
		}

		public function set x(value:Number):void
		{
			_x = value;
			image.x = _x - radius; 
		}

		public function get y():Number
		{
			return _y;
		}

		public function set y(value:Number):void
		{
			_y = value;
			image.y = _y - radius;
		}

		public function get isInArena():Boolean
		{
			return _isInArena;
		}

		public function set isInArena(value:Boolean):void
		{
			_isInArena = value;
			if(_isInArena) {
				image.alpha = 1.0;
			}
			else {
				image.alpha = 0.5;
			}
		}

		public function toString():String
		{
			return "Sphere{x:" + x + ", y:" + y 
					+ "image.x:" + image.x + ", image.y:" + image.y 
					+ ", speedVectorX:" + speedVectorX +  ", speedVectorY:" + speedVectorY
					+ ", rotation:"  + rotation
					+ ", maxSpeedVariation:" + maxSpeedVariation 
					+ ", player:" + player.name 
					+ ", radius:" + radius 
					+ ", isInArena:" + isInArena + "}";
		}


	}
}