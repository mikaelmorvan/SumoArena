package model
{
	import controller.signals.LogSignal;
	
	import flash.geom.Matrix;
	import flash.geom.Point;
	
	import model.vo.Player;
	import model.vo.Sphere;
	
	import mx.collections.ArrayList;
	import mx.controls.Image;
	
	import org.robotlegs.mvcs.Actor;
	
	public class SphereModel extends Actor
	{
		[Inject]
		public var logSignal:LogSignal;
		
		public function create(player:Player, radius:uint, speedVariation:uint):Sphere
		{
			var sphere:Sphere = new Sphere();
			sphere.radius = radius;
			sphere.player = player;
			sphere.maxSpeedVariation = speedVariation;
			sphere.image = new Image();
			sphere.image.source = player.avatar;
			sphere.image.width = radius * 2;
			sphere.image.height = radius * 2;
			return sphere;
		}
		
		public function resetSpheres(spheres:ArrayList):void{
			for (var i:int = 0; i < spheres.length; i++)
			{
				var sphere:Sphere = spheres.getItemAt(i) as Sphere;
				sphere.x = 300;
				sphere.y = 300;
				sphere.speedVectorX = 0;
				sphere.speedVectorY = 0;
				sphere.isInArena = true;
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
				if(sphere.speedVectorX 
					|| sphere.speedVectorY)
				{
					updateImageRotation(sphere);
				}
			}
		}

		private function updateImageRotation(sphere:Sphere):void
		{
			var rotation:Number = Math.atan2(sphere.speedVectorY, sphere.speedVectorX);
			
		    var matrix:Matrix = new Matrix();
		    matrix.translate(- sphere.image.x, -sphere.image.y);
		    matrix.rotate(rotation);
		    matrix.translate(sphere.image.x, sphere.image.y);
//		    matrix.concat(sphere.image.transform.matrix);
			sphere.image.transform.matrix = matrix;
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