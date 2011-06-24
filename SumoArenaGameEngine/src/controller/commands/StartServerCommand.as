package controller.commands
{
	import org.robotlegs.mvcs.SignalCommand;
	
	import service.Server;
	
	public class StartServerCommand extends SignalCommand
	{
		[Inject]
		public var server:Server;
		
		[Inject]
		public var port:uint;
		
		public override function execute():void
		{
			server.start(port);
		}
	}
}