package controller.commands
{
	import model.SphereConfigurationModel;
	
	import org.robotlegs.mvcs.SignalCommand;
	
	public class SetSpeedVariationCommand extends SignalCommand
	{
		[Inject]
		public var speedVariation:uint;
		
		[Inject]
		public var sphereConfigurationModel:SphereConfigurationModel;

		public override function execute():void
		{
			sphereConfigurationModel.speedVariation = speedVariation;
		}
	}
}