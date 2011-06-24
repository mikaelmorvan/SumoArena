package controller.commands
{
	import model.ArenaModel;
	import model.vo.Arena;
	
	import org.robotlegs.mvcs.SignalCommand;
	
	public class SetShrinkingStartCommand extends SignalCommand
	{
		[Inject]
		public var shrinkingStart:uint;
		
		[Inject]
		public var arenaModel:ArenaModel;
		
		public override function execute():void
		{
			arenaModel.shrinkingStartTick = shrinkingStart;
		}
	}
}