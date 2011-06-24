package controller.commands
{
	import model.ArenaModel;
	import model.vo.Arena;
	
	import org.robotlegs.mvcs.SignalCommand;
	
	public class SetShrinkingIntervalCommand extends SignalCommand
	{
		[Inject]
		public var shrinkingInterval:uint;
		
		[Inject]
		public var arenaModel:ArenaModel;

		public override function execute():void
		{
			arenaModel.shrinkingInterval = shrinkingInterval;
		}
	}
}