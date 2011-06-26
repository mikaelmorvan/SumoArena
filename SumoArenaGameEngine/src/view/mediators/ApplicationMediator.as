package view.mediators
{
	import controller.signals.CreateSphereSignal;
	import controller.signals.StartSignal;
	import controller.signals.StopSignal;
	import controller.signals.UpdateSignal;
	
	import flash.events.Event;
	import flash.utils.getTimer;
	
	import model.GameModel;
	import model.vo.Game;
	
	import org.robotlegs.mvcs.Mediator;
	
	public class ApplicationMediator extends Mediator
	{
		[Inject]
		public var applicationView:SumoBotGameController;
		
		[Inject]
		public var startSignal:StartSignal;

		[Inject]
		public var stopSignal:StopSignal;
		
		[Inject]
		public var updateSignal:UpdateSignal;
		
		[Inject]
		public var gameModel:GameModel;
		
		public override function onRegister():void
		{
			startSignal.add(gameStartedHandler);
			stopSignal.add(gameStoppedHandler);
			gameModel.roundFinishedSignal.add(gameStoppedHandler);
		}

		private function gameStartedHandler():void 
		{
			applicationView.tabBar.selectedIndex = 4;
			applicationView.viewStack.selectedIndex = 4;
			addViewListener(Event.ENTER_FRAME, enterFrameHandler);
		}

		private function gameStoppedHandler():void 
		{
			eventMap.unmapListener(applicationView, Event.ENTER_FRAME, enterFrameHandler);
		}

		private function enterFrameHandler(event:Event):void
		{
			updateSignal.dispatch();
		}
	}
}