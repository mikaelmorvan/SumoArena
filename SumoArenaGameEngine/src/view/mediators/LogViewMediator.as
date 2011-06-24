package view.mediators
{
	import model.LogModel;
	
	import org.robotlegs.mvcs.Mediator;
	
	import view.components.LogView;
	
	public class LogViewMediator extends Mediator
	{
		[Inject]
		public var logModel:LogModel;
		
		[Inject]
		public var logView:LogView;		

		public override function onRegister():void
		{
			logModel.logged.add(onLogged);
		}
		private function onLogged(logs:String):void
		{
			logView.text = logModel.logs;
		}

		
	}
}