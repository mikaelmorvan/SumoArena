package view.mediators
{
	import controller.signals.CreateSphereSignal;
	import controller.signals.StartSignal;
	import controller.signals.CancelRoundSignal;
	import controller.signals.UpdateSignal;
	
	import flash.events.Event;
	import flash.utils.getTimer;
	
	import model.GameModel;
	import model.vo.Game;
	
	import org.robotlegs.mvcs.Mediator;
	
	public class ApplicationMediator extends Mediator
	{
		[Inject]
		public var applicationView:SumoBotGameEngine;
		
		[Inject]
		public var startSignal:StartSignal;

		[Inject]
		public var stopSignal:CancelRoundSignal;
		
		[Inject]
		public var updateSignal:UpdateSignal;
		
		[Inject]
		public var gameModel:GameModel;
		
		public override function onRegister():void
		{
			startSignal.add(gameStartedHandler);
			stopSignal.add(gameStoppedHandler);
			gameModel.roundFinishedSignal.add(gameStoppedHandler);
			gameModel.gameFinishedSignal.add(gameStoppedHandler);
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