package view.mediators
{
	import controller.signals.CancelRoundSignal;
	import controller.signals.CreateSphereSignal;
	import controller.signals.StartSignal;
	import controller.signals.StopServerSignal;
	import controller.signals.UpdateSignal;
	
	import flash.events.Event;
	import flash.utils.getTimer;
	
	import model.GameModel;
	import model.vo.Game;
	
	import org.robotlegs.mvcs.Mediator;
	
	public class ApplicationMediator extends Mediator
	{
		[Inject]
		public var applicationView:SumoArenaGameEngine;
		
		[Inject]
		public var startSignal:StartSignal;

		[Inject]
		public var cancelRoundSignal:CancelRoundSignal;
		
		[Inject]
		public var updateSignal:UpdateSignal;
		
		[Inject]
		public var stopServerSignal:StopServerSignal;
		
		[Inject]
		public var gameModel:GameModel;
		
		public override function onRegister():void
		{
			startSignal.add(gameStartedHandler);
			cancelRoundSignal.add(gameStoppedHandler);
			gameModel.roundFinishedSignal.add(gameStoppedHandler);
			gameModel.gameFinishedSignal.add(gameStoppedHandler);
			applicationView.addEventListener(Event.CLOSING, onClosingHandler);
		}
		
		protected function onClosingHandler(event:Event):void
		{
			stopServerSignal.dispatch();
		}
		
		private function gameStartedHandler():void 
		{
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