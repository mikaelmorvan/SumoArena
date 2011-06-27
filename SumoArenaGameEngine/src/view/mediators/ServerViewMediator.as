package view.mediators
{
	import controller.signals.StartServerSignal;
	import controller.signals.StopServerSignal;
	
	import flash.events.MouseEvent;
	
	import org.robotlegs.mvcs.Mediator;
	
	import view.components.ServerView;
	
	public class ServerViewMediator extends Mediator
	{

		[Inject]
		public var serverView:ServerView;

		[Inject]
		public var startServerSignal:StartServerSignal;
		
		[Inject]
		public var stopServerSignal:StopServerSignal;
		
		public override function onRegister():void
		{
			serverView.startButton.addEventListener(MouseEvent.CLICK, startClickHandler);
			serverView.stopButton.addEventListener(MouseEvent.CLICK, stopClickHandler);
		}

		private function startClickHandler(event:MouseEvent):void 
		{
			var port:uint = uint(serverView.port.text);
			if(port > 0 && port <= 65535)
			{
				startServerSignal.dispatch(port);
			}
			serverView.currentState = "running";
		}
		
		private function stopClickHandler(event:MouseEvent):void 
		{
			stopServerSignal.dispatch();
			serverView.currentState = "stopped";
		}
	}
}