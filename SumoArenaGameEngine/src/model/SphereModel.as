package model
{
	import controller.signals.LogSignal;
	
	import flash.geom.Matrix;
	import flash.geom.Point;
	
	import model.vo.Player;
	import model.vo.Sphere;
	
	import mx.collections.ArrayList;
	import mx.controls.Image;
	import mx.core.BitmapAsset;
	
	import org.robotlegs.mvcs.Actor;
	
	public class SphereModel extends Actor
	{
		[Inject]
		public var logSignal:LogSignal;
		
		[Embed(source="assets/blue.png")]
		public var blueImageClass:Class;
		
		[Embed(source="assets/green.png")]
		public var greenImageClass:Class;

		[Embed(source="assets/yellow.png")]
		public var yellowImageClass:Class;

		[Embed(source="assets/red.png")]
		public var redImageClass:Class;

		private var _blueImage:BitmapAsset;
		private var _greenImage:BitmapAsset;
		private var _yellowImage:BitmapAsset;
		private var _redImage:BitmapAsset;
		private var _availableImages:Array;
		
		public function SphereModel()
		{
			_blueImage = new blueImageClass() as BitmapAsset;
			_redImage = new redImageClass() as BitmapAsset;
			_greenImage = new greenImageClass() as BitmapAsset;
			_yellowImage = new yellowImageClass() as BitmapAsset;
			_availableImages = [_yellowImage, _blueImage, _redImage, _greenImage];
		}
		
		
		public function create(player:Player, radius:uint, speedVariation:uint):Sphere
		{
			var sphere:Sphere = new Sphere();
			sphere.radius = radius;
			sphere.player = player;
			sphere.maxSpeedVariation = speedVariation;
			sphere.image = new Image();
			if(player.avatar)
			{
				sphere.image.source = player.avatar;
			}
			else 
			{
				sphere.image.source = _availableImages.pop();
			}
			sphere.image.width = radius * 2;
			sphere.image.height = radius * 2;
			sphere.image.x = -radius;
			sphere.image.y = -radius;
			return sphere;
		}

		public function destroy(sphere:Sphere):void
		{
			if(!sphere.player.avatar)
			{
				_availableImages.push(sphere.image);
			}
			sphere.image = null;
			sphere.player = null;
		}		
		
		public function resetSpheres(spheres:ArrayList):void{
			for (var i:int = 0; i < spheres.length; i++)
			{
				var sphere:Sphere = spheres.getItemAt(i) as Sphere;
				sphere.x = sphere.offset;
				sphere.y = sphere.offset;
				sphere.speedVectorX = 0;
				sphere.speedVectorY = 0;
				sphere.isInArena = true;
				sphere.player.requestedDx = 0;
				sphere.player.requestedDy = 0;
			}			
		}
		
		public function setSpeed(sphere:Sphere, x:Number, y:Number):void
		{
			sphere.speedVectorX = x;
			sphere.speedVectorY = y;
		}
		
		public function setPosition(sphere:Sphere, x:Number, y:Number):void
		{
			sphere.x = x;
			sphere.y = y;
		}

		
		public function updateAllPositions(spheres:ArrayList, stepByTurn:uint):void
		{
			for (var i:int = 0; i < spheres.length; i++)
			{
				var sphere:Sphere = spheres.getItemAt(i) as Sphere;
				sphere.x += sphere.speedVectorX / stepByTurn;
				sphere.y += sphere.speedVectorY / stepByTurn;
			}
		}

		public function updateSpeed(sphere:Sphere, dx:Number, dy:Number):void
		{
			if (dx * dx + dy * dy <= sphere.maxSpeedVariation * sphere.maxSpeedVariation)
			{
				sphere.speedVectorX += dx;
				sphere.speedVectorY += dy;
			}
			else {
				logSignal.dispatch("WARNING: " + sphere.player.name + " speed update values are out range. dx=" + dx + " dy=" + dy); 
			}
		}
		

		public function setMaxSpeedVariation(sphere:Sphere, value:Number):void
		{
			sphere.maxSpeedVariation = value;
		}

		public function setPlayer(sphere:Sphere, player:Player):void
		{
			sphere.player = player;
		}

		public function setRadius(sphere:Sphere, value:int):void
		{
			sphere.radius = value;
		}

		public function handleCollisions(aliveSpheres:ArrayList):void
		{
			var sphereNumber:int = aliveSpheres.length;
			
			
			for (var i:int = 0; i < sphereNumber; i++)
			{
				var sphere:Sphere = aliveSpheres.getItemAt(i) as Sphere;
				
				for (var j:int = i + 1; j < sphereNumber; j++)
				{
					var otherSphere:Sphere = aliveSpheres.getItemAt(j) as Sphere;
					
					var distX:Number = otherSphere.x - sphere.x;
					var distY:Number = otherSphere.y - sphere.y;
					var radius:Number = sphere.radius + otherSphere.radius;
					var distance:Number = Math.sqrt(distX * distX + distY * distY);
					
					if (distance < radius)
					{
						repulse(sphere, otherSphere, distX, distY, distance);
					}
				}
			}			
		}
		
		
		private function repulse(sphere:Sphere, otherSphere:Sphere, distX:Number, distY:Number, distance:Number):void
		{
			var normalX:Number = distX/distance;
			var normalY:Number = distY/distance;
			
			var midpointX:Number = (sphere.x + otherSphere.x)/2;
			var midpointY:Number = (sphere.y + otherSphere.y)/2;
			
			sphere.x = midpointX - normalX * sphere.radius;
			sphere.y = midpointY - normalY * sphere.radius;
			otherSphere.x = midpointX + normalX * otherSphere.radius;
			otherSphere.y = midpointY + normalY * otherSphere.radius;
			
			var vector:Number = ((sphere.speedVectorX - otherSphere.speedVectorX) * normalX) + ((sphere.speedVectorY - otherSphere.speedVectorY) * normalY);
			var vectorX:Number = vector * normalX;
			var vectorY:Number = vector * normalY;
			
			sphere.speedVectorX -= vectorX;
			sphere.speedVectorY -= vectorY;
			otherSphere.speedVectorX += vectorX;
			otherSphere.speedVectorY += vectorY;
		}
	}
}