package controller.commands
{
	import org.robotlegs.mvcs.SignalCommand;
	
	import service.Server;
	
	public class StopServerCommand extends SignalCommand
	{
		[Inject]
		public var server:Server;
		
		public override function execute():void
		{
			server.stop();
		}
	}
}