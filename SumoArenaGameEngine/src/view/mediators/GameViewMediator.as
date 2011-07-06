package view.mediators
{
	import controller.signals.CancelGameSignal;
	import controller.signals.CancelRoundSignal;
	import controller.signals.StartRoundSignal;
	
	import flash.events.MouseEvent;
	
	import model.ArenaModel;
	import model.GameModel;
	
	import org.osflash.signals.natives.NativeSignal;
	import org.robotlegs.mvcs.Mediator;
	
	import view.components.GameView;
	
	public class GameViewMediator extends Mediator
	{
		[Inject]
		public var gameView:GameView;
		
		[Inject]
		public var startRoundSignal:StartRoundSignal;

		[Inject]
		public var cancelRoundSignal:CancelRoundSignal;

		[Inject]
		public var cancelGameSignal:CancelGameSignal;
		
		[Inject]
		public var gameModel:GameModel;
		
		[Inject]
		public var arenaModel:ArenaModel;
		
		//TODO use states
		public override function onRegister():void
		{
			var startRoundClickedSignal:NativeSignal = new NativeSignal(gameView.startRoundButton, MouseEvent.CLICK, MouseEvent);
			startRoundClickedSignal.add(startRoundClicked);

			var cancelRoundClickedSignal:NativeSignal = new NativeSignal(gameView.cancelRoundButton, MouseEvent.CLICK, MouseEvent);
			cancelRoundClickedSignal.add(cancelRoundClicked);

			var cancelGameClickedSignal:NativeSignal = new NativeSignal(gameView.cancelGameButton, MouseEvent.CLICK, MouseEvent);
			cancelGameClickedSignal.add(cancelGameClicked);
			
			gameModel.roundFinishedSignal.add(roundEnded);
			
			gameModel.gameFinishedSignal.add(gameEnded);
			
			gameView.arenaView.arena = arenaModel.arena;
			gameView.arenaView.dataGroup.dataProvider = gameModel.game.spheres;
		}
		
		private function cancelRoundClicked(event:MouseEvent):void
		{
			cancelRoundSignal.dispatch();
			gameView.startRoundButton.enabled = true;
			gameView.cancelRoundButton.enabled = false;
			gameView.cancelGameButton.enabled = false;
		}
		
		private function startRoundClicked(event:MouseEvent):void
		{
			startRoundSignal.dispatch();
			gameView.startRoundButton.enabled = false;
			gameView.cancelRoundButton.enabled = true;
			gameView.cancelGameButton.enabled = true;
			gameView.players.dataProvider = gameModel.game.selectedPlayers;
		}

		private function cancelGameClicked(event:MouseEvent):void
		{
			cancelGameSignal.dispatch();
			gameView.startRoundButton.enabled = true;
			gameView.cancelRoundButton.enabled = false;
			gameView.cancelGameButton.enabled = false;
		}
		
		private function roundEnded():void
		{
			gameView.startRoundButton.enabled = true;
			gameView.cancelRoundButton.enabled = false;
		}
		
		private function gameEnded():void 
		{
			gameView.cancelGameButton.enabled = false;
		}
	}
}