package model
{
	import model.vo.SphereConfiguration;
	
	import org.robotlegs.mvcs.Actor;
	
	public class SphereConfigurationModel extends Actor
	{
		public var sphereConfiguration:SphereConfiguration;
		
		public function SphereConfigurationModel()
		{
			sphereConfiguration = new SphereConfiguration();
		}

		public function set radius(value:uint):void
		{
			sphereConfiguration.radius = value;
		}

		public function set speedVariation(value:uint):void
		{
			sphereConfiguration.speedVariation = value;
		}

		public function set initialDistance(value:uint):void
		{
			sphereConfiguration.initialDistance = value;
		}
	}
}