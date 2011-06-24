package controller.commands
{
	import model.GameModel;
	
	import org.robotlegs.mvcs.SignalCommand;
	
	public class SetTurnDurationCommand extends SignalCommand
	{
		[Inject]
		public var turnDuration:uint;
		
		[Inject]
		public var gameModel:GameModel;
		
		override public function execute():void
		{
			gameModel.turnDuration = turnDuration;
		}
	}
}