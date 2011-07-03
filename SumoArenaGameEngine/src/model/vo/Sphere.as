package model.vo
{
	import flash.geom.Matrix;
	import flash.geom.Point;
	
	import mx.controls.Image;

	[Bindable]
	public class Sphere
	{

		
		public var x:Number = 0;
		
		public var y:Number = 0;
		
		public var offset:int = 300;
		

		public function get speedVectorX():int
		{
			return _speedVectorX;
		}

		public function set speedVectorX(value:int):void
		{
			_speedVectorX = value;
		}

		public function get speedVectorY():int
		{
			return _speedVectorY;
		}

		public function set speedVectorY(value:int):void
		{
			_speedVectorY = value;
			
			var rotation:Number = Math.atan2(speedVectorY, speedVectorX);
			var matrix:Matrix = new Matrix();
			matrix.translate(-radius, -radius);
			matrix.rotate(rotation);
			image.transform.matrix = matrix;
			
		}

		private var _speedVectorX:int = 0;

		private var _speedVectorY:int = 0;
		
		public var maxSpeedVariation:Number;
		
		public var player:Player;
		
		public var radius:int = 20;
		
		private var _isInArena:Boolean;
		
		public var image:Image;

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
					+ ", maxSpeedVariation:" + maxSpeedVariation 
					+ ", player:" + player.name 
					+ ", radius:" + radius 
					+ ", isInArena:" + isInArena + "}";
		}


	}
}