package controller.commands
{
	import model.ArenaModel;
	import model.GameModel;
	import model.SphereConfigurationModel;
	import model.SphereModel;
	
	import org.robotlegs.mvcs.SignalCommand;
	
	public class StartRoundCommand extends SignalCommand
	{
		
		[Inject]
		public var gameModel:GameModel;
		
		[Inject]
		public var sphereModel:SphereModel;
		
		[Inject]
		public var arenaModel:ArenaModel;
		
		[Inject]
		public var sphereConfigurationModel:SphereConfigurationModel;
		
		public override function execute():void
		{
			arenaModel.radius = arenaModel.arena.initialRadius;
			sphereModel.resetSpheres(gameModel.game.spheres);
			gameModel.game.arena = arenaModel.arena;
			gameModel.placeSpheresToInitialPosition(sphereConfigurationModel.sphereConfiguration.initialDistance);
			gameModel.startRound(sphereConfigurationModel.sphereConfiguration);
		}


	}
}