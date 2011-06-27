package controller.commands
{
	import model.GameModel;
	
	import org.robotlegs.mvcs.SignalCommand;
	
	public class CancelRoundCommand extends SignalCommand
	{
		
		[Inject]
		public var gameModel:GameModel;
		
		public override function execute():void
		{
			gameModel.finishRound();
		}


	}
}