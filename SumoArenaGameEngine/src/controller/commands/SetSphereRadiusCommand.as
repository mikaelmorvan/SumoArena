package controller.commands
{
	import model.ArenaModel;
	import model.SphereConfigurationModel;
	
	import mx.core.mx_internal;
	
	import org.robotlegs.mvcs.SignalCommand;
	
	public class SetSphereRadiusCommand extends SignalCommand
	{
		[Inject]
		public var radius:uint;
		
		[Inject]
		public var sphereConfigurationModel:SphereConfigurationModel;
		
		[Inject]
		public var arenaModel:ArenaModel;

		public override function execute():void
		{
			sphereConfigurationModel.radius = radius;
			arenaModel.arena.minimalRadius = radius * 2 -1;
		}
	}
}