package controller.commands
{
	import controller.signals.DestroySphereSignal;
	
	import model.GameModel;
	import model.vo.Player;
	
	import org.robotlegs.mvcs.SignalCommand;
	
	public class UnselectPlayerCommand extends SignalCommand
	{
		[Inject]
		public var player:Player;

		[Inject]
		public var gameModel:GameModel;
		
		[Inject]
		public var destroySphereSignal:DestroySphereSignal;
		
		public override function execute():void
		{
			gameModel.unselectPlayer(player);
			destroySphereSignal.dispatch(player.sphere);
		}


	}
}