package view.mediators
{
	import controller.signals.StartServerSignal;
	
	import flash.events.MouseEvent;
	
	import org.robotlegs.mvcs.Mediator;
	
	import view.components.ServerView;
	
	public class ServerViewMediator extends Mediator
	{

		[Inject]
		public var serverView:ServerView;

		[Inject]
		public var startServerSignal:StartServerSignal;
		
		public override function onRegister():void
		{
			serverView.startButton.addEventListener(MouseEvent.CLICK, mouseClickHandler);
		}

		private function mouseClickHandler(event:MouseEvent):void 
		{
			var port:uint = uint(serverView.port.text);
			if(port > 0 && port <= 65535)
			{
				startServerSignal.dispatch(port);
			}
		}
	}
}