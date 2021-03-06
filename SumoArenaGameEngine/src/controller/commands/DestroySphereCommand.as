package controller.commands
{
	import controller.signals.CreateSphereSignal;
	
	import model.GameModel;
	import model.SphereConfigurationModel;
	import model.SphereModel;
	import model.vo.Player;
	import model.vo.Sphere;
	
	import org.robotlegs.mvcs.SignalCommand;
	
	/**
	 * Removes a sphere from the game
	 * @author peal6230
	 */
	public class DestroySphereCommand extends SignalCommand
	{
		[Inject]
		public var player:Player;
		
		[Inject]
		public var sphereModel:SphereModel;

		[Inject]
		public var gameModel:GameModel;
		
		public override function execute():void
		{
			var sphere:Sphere = player.sphere;
			if(sphere)
			{
				gameModel.removeSphere(sphere);
				sphereModel.destroy(sphere);
			}
		}
	}
}