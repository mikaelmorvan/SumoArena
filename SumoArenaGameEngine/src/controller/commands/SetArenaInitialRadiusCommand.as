package controller.commands
{
	import model.ArenaModel;
	import model.vo.Arena;
	
	import org.robotlegs.mvcs.SignalCommand;
	
	public class SetArenaInitialRadiusCommand extends SignalCommand
	{
		[Inject]
		public var initialRadius:uint;
		
		[Inject]
		public var arenaModel:ArenaModel;

		public override function execute():void
		{
			arenaModel.initialRadius = initialRadius;
		}
	}
}