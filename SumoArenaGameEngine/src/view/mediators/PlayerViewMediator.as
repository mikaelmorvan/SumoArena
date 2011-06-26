package view.mediators
{
	import controller.signals.CreateSphereSignal;
	import controller.signals.SelectPlayerSignal;
	import controller.signals.UnselectPlayerSignal;
	
	import flash.events.MouseEvent;
	
	import model.GameModel;
	import model.vo.Player;
	
	import mx.collections.ArrayList;
	
	import org.osflash.signals.natives.NativeSignal;
	import org.robotlegs.mvcs.Mediator;
	
	import view.components.PlayerView;
	
	public class PlayerViewMediator extends Mediator
	{

		[Inject]
		public var playerView:PlayerView;

		// view signals
		private var _selectButtonClicked:NativeSignal;
		private var _unselectButtonClicked:NativeSignal;
		
		// command signals
		
		[Inject]
		public var createSphereSignal:CreateSphereSignal;

		[Inject]
		public var selectPlayerSignal:SelectPlayerSignal;
		
		[Inject]
		public var unselectPlayerSignal:UnselectPlayerSignal;

		// model
		[Inject]
		public var gameModel:GameModel;
		
		public override function onRegister():void
		{
			playerView.availablePlayers.dataProvider = gameModel.game.availablePlayers;
			playerView.selectedPlayers.dataProvider = gameModel.game.selectedPlayers;
			
			//add view listeners
			_selectButtonClicked = new NativeSignal(playerView.availablePlayers, MouseEvent.CLICK);
			_selectButtonClicked.add(addPlayerClicked);
			_unselectButtonClicked = new NativeSignal(playerView.selectedPlayers, MouseEvent.CLICK);
			_unselectButtonClicked.add(removePlayerClicked);
			
		}

		private function addPlayerClicked(event:MouseEvent):void 
		{
			var selectedPlayer:Player = playerView.availablePlayers.selectedItem as Player; 
			if(selectedPlayer)
			{
				selectPlayerSignal.dispatch(selectedPlayer);
				playerView.availablePlayers.selectedIndex = 0;
			}
		}

		private function removePlayerClicked(event:MouseEvent):void 
		{
			var selectedPlayer:Player = playerView.selectedPlayers.selectedItem as Player; 
			if(selectedPlayer)
			{
				unselectPlayerSignal.dispatch(selectedPlayer);
				playerView.selectedPlayers.selectedIndex = 0;
			}
		}

	}
}