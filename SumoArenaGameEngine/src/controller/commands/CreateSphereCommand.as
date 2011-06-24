package controller.commands
{
	import controller.signals.CreateSphereSignal;
	
	import model.GameModel;
	import model.SphereConfigurationModel;
	import model.SphereModel;
	import model.vo.Player;
	import model.vo.Sphere;
	import model.vo.SphereConfiguration;
	
	import org.robotlegs.mvcs.SignalCommand;
	
	/**
	 * Creates a new sphere then adds it to the game
	 * @author peal6230
	 */
	public class CreateSphereCommand extends SignalCommand
	{
		[Inject]
		public var player:Player;
		
		[Inject]
		public var createSphereSignal:CreateSphereSignal;
		
		[Inject]
		public var sphereModel:SphereModel;

		[Inject]
		public var sphereConfigurationModel:SphereConfigurationModel;
		
		[Inject]
		public var gameModel:GameModel;
		
		public override function execute():void
		{
			var sphereConfiguration:SphereConfiguration = sphereConfigurationModel.sphereConfiguration;
			var sphere:Sphere  = sphereModel.create(player, sphereConfiguration.radius, sphereConfiguration.speedVariation);
			gameModel.addSphere(sphere);
			player.sphere = sphere;
		}
	}
}