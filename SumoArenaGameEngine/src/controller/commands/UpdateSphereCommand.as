package controller.commands
{
	import model.GameModel;
	import model.SphereModel;
	import model.vo.Sphere;
	import model.vo.Player;
	
	import org.robotlegs.mvcs.SignalCommand;
	
	public class UpdateSphereCommand extends SignalCommand
	{
		[Inject]
		public var player:Player;
		
		[Inject]
		public var sphereModel:SphereModel;

		// model
		[Inject]
		public var gameModel:GameModel;
		
		
		public override function execute():void
		{
			var sphere:Sphere = gameModel.getSphereByPlayer(player);
			if(sphere && sphere.isInArena){
				sphereModel.updateSpeed(sphere, player.requestedDx, player.requestedDy);
			}
		}


	}
}