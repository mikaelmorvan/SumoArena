package view.mediators
{
	import controller.signals.StartSignal;
	
	import flash.events.MouseEvent;
	
	import org.osflash.signals.natives.NativeSignal;
	import org.robotlegs.mvcs.Mediator;
	
	import view.components.ControlView;
	
	public class ControlViewMediator extends Mediator
	{
		[Inject]
		public var controlView:ControlView;
		
		[Inject]
		public var startSignal:StartSignal;
		
		public override function onRegister():void
		{
			var startRoundClickedSignal:NativeSignal = new NativeSignal(controlView.startRoundButton, MouseEvent.CLICK, MouseEvent);
			startRoundClickedSignal.add(startRoundClicked);
		}
		
		private function startRoundClicked(event:MouseEvent):void
		{
			startSignal.dispatch();
		}

		
	}
}