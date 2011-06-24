package controller.commands
{
	import model.ArenaModel;
	import model.vo.Arena;
	
	import org.robotlegs.mvcs.SignalCommand;
	
	public class SetShrinkingCommand extends SignalCommand
	{
		[Inject]
		public var shrinking:uint;
		
		[Inject]
		public var arenaModel:ArenaModel;
		
		public override function execute():void
		{
			arenaModel.shrinking = shrinking;
		}
	}
}