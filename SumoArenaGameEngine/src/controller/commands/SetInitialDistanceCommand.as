package controller.commands
{
	import model.SphereConfigurationModel;
	
	import org.robotlegs.mvcs.SignalCommand;
	
	public class SetInitialDistanceCommand extends SignalCommand
	{
		[Inject]
		public var initialDistance:uint;
		
		[Inject]
		public var sphereConfigurationModel:SphereConfigurationModel;

		public override function execute():void
		{
			sphereConfigurationModel.initialDistance = initialDistance;
		}
	}
}