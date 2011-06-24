package controller.commands
{
	import model.LogModel;
	
	import org.robotlegs.mvcs.SignalCommand;
	
	public class LogCommand extends SignalCommand
	{
		[Inject]
		public var messsage:String;

		
		[Inject]
		public var logModel:LogModel;
		
		[Inject]
		public override function execute():void
		{
			logModel.log(messsage);	
		}


	}
}