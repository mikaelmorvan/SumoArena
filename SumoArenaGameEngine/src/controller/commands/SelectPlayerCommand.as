package controller.commands
{
	import controller.signals.CreateSphereSignal;
	
	import model.GameModel;
	import model.vo.Player;
	
	import org.robotlegs.mvcs.SignalCommand;
	
	public class SelectPlayerCommand extends SignalCommand
	{
		
		[Inject]
		public var player:Player;
		
		[Inject]
		public var gameModel:GameModel;
		
		[Inject]
		public var createSphereSignal:CreateSphereSignal;
		
		public override function execute():void
		{
			if(gameModel.game.selectedPlayers.length < gameModel.COLORS.length)
			{
				player.color = gameModel.COLORS[gameModel.game.selectedPlayers.length];
				gameModel.selectPlayer(player);
				createSphereSignal.dispatch(player);
			}
		}
	}
}