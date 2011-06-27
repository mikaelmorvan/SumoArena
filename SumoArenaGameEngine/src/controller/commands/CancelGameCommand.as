package controller.commands
{
	import model.GameModel;
	
	import org.robotlegs.mvcs.SignalCommand;
	
	public class CancelGameCommand extends SignalCommand
	{
		
		[Inject]
		public var gameModel:GameModel;
		
		public override function execute():void
		{
			gameModel.finishRound();
			gameModel.finishGame();
		}


	}
}