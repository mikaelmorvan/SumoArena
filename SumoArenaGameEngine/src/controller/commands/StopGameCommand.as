package controller.commands
{
	import model.GameModel;
	
	import org.robotlegs.mvcs.SignalCommand;
	
	public class StopGameCommand extends SignalCommand
	{
		
		[Inject]
		public var gameModel:GameModel;
		
		public override function execute():void
		{
//			gameModel.stop();
		}


	}
}