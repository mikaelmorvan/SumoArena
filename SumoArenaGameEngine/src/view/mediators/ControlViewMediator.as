package view.mediators
{
	import controller.signals.StartSignal;
	
	import flash.events.MouseEvent;
	
	import model.GameModel;
	
	import org.osflash.signals.natives.NativeSignal;
	import org.robotlegs.mvcs.Mediator;
	
	import view.components.ControlView;
	
	public class ControlViewMediator extends Mediator
	{
		[Inject]
		public var controlView:ControlView;
		
		[Inject]
		public var startSignal:StartSignal;
		
		[Inject]
		public var gameModel:GameModel;
		
		public override function onRegister():void
		{
			var startRoundClickedSignal:NativeSignal = new NativeSignal(controlView.startRoundButton, MouseEvent.CLICK, MouseEvent);
			startRoundClickedSignal.add(startRoundClicked);
			
			gameModel.roundFinishedSignal.add(roundEnded);
			
		}
		
		private function startRoundClicked(event:MouseEvent):void
		{
			startSignal.dispatch();
			controlView.startRoundButton.enabled = false;
		}

		private function roundEnded():void
		{
			controlView.startRoundButton.enabled = true;
		}
	}
}