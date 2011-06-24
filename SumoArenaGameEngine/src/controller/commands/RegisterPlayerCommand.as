package controller.commands
{
	import model.GameModel;
	import model.vo.Player;
	
	import org.robotlegs.mvcs.SignalCommand;
	
	public class RegisterPlayerCommand extends SignalCommand
	{
		[Inject]
		public var player:Player;
		
		[Inject]
		public var gameModel:GameModel;
		
		public override function execute():void
		{
			gameModel.addPlayer(player);
		}
	}
}