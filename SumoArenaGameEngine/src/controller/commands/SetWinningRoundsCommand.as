package controller.commands
{
	import model.GameModel;
	
	import org.robotlegs.mvcs.SignalCommand;
	
	public class SetWinningRoundsCommand extends SignalCommand
	{
		[Inject]
		public var winningRounds:uint;
		
		[Inject]
		public var gameModel:GameModel; 

		public override function execute():void
		{
			gameModel.maxWinningRounds = winningRounds;
		}
	}
}