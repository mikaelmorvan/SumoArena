package view.mediators
{
	import controller.signals.ChangeArenaRadiusSignal;
	import controller.signals.ChangeInitialDistanceSignal;
	import controller.signals.ChangeShrinkingIntervalSignal;
	import controller.signals.ChangeShrinkingSignal;
	import controller.signals.ChangeShrinkingStartSignal;
	import controller.signals.ChangeSpeedVariationSignal;
	import controller.signals.ChangeSphereRadiusSignal;
	import controller.signals.ChangeTurnDurationSignal;
	import controller.signals.ChangeWinningRoundsSignal;
	
	import flash.events.Event;
	
	import model.ArenaModel;
	import model.GameModel;
	import model.SphereConfigurationModel;
	
	import org.osflash.signals.Signal;
	import org.osflash.signals.natives.NativeSignal;
	import org.robotlegs.mvcs.Mediator;
	
	import view.components.ConfigurationView;

	public class ConfigurationViewMediator extends Mediator
	{
		[Inject]
		public var configurationView:ConfigurationView;

		////////////////////// dispatched signals //////////////////////
		[Inject]
		public var changeSphereRadiusSignal:ChangeSphereRadiusSignal;
		
		[Inject]
		public var changeSpeedVariationSignal:ChangeSpeedVariationSignal;
		
		[Inject]
		public var changeInitialDistanceSignal:ChangeInitialDistanceSignal;		
		
		[Inject]
		public var changeArenaRadiusSignal:ChangeArenaRadiusSignal;
		
		[Inject]
		public var changeShrinkingStartSignal:ChangeShrinkingStartSignal;
		
		[Inject]
		public var changeShrinkingIntervalSignal:ChangeShrinkingIntervalSignal;

		[Inject]
		public var changeShrinkingSignal:ChangeShrinkingSignal;	
		
		[Inject]
		public var changeTurnDurationSignal:ChangeTurnDurationSignal;
		
		[Inject]
		public var changeWinningRoundsSignal:ChangeWinningRoundsSignal;
		
		////////////////////// view signals //////////////////////
		private var sphereRadiusChangedSignal:NativeSignal;
		private var speedVariationChangedSignal:NativeSignal;
		private var initialDistanceChangedSignal:NativeSignal;
		
		private var arenaRadiusChangedSignal:NativeSignal;
		private var shrinkingStartChangedSignal:NativeSignal;
		private var shrinkingIntervalChangedSignal:NativeSignal;
		private var shrinkingChangedSignal:NativeSignal;
		
		private var turnDurationChangedSignal:NativeSignal;
		private var winningRoundsChangedSignal:NativeSignal;
		
		
		////////////////////// models //////////////////////
		[Inject]
		public var gameModel:GameModel;
		
		[Inject]
		public var arenaModel:ArenaModel;
		
		[Inject]
		public var sphereConfigurationModel:SphereConfigurationModel;
		
		
		/////////////////////////////////////////////////////
		
		public override function onRegister():void
		{
			registerViewEventListeners();
			
			configurationView.arena = arenaModel.arena;
			configurationView.game = gameModel.game;
			configurationView.sphereConfiguration = sphereConfigurationModel.sphereConfiguration;
		}

		private function registerViewEventListeners():void
		{
			// listen to view events
			sphereRadiusChangedSignal = new NativeSignal(configurationView.sphereRadiusInput, Event.CHANGE);
			sphereRadiusChangedSignal.add(sphereRadiusChangedHandler);
		
			speedVariationChangedSignal = new NativeSignal(configurationView.speedVariationInput, Event.CHANGE);
			speedVariationChangedSignal.add(speedVariationChangedHandler);
		
			initialDistanceChangedSignal = new NativeSignal(configurationView.initialDistanceInput, Event.CHANGE);
			initialDistanceChangedSignal.add(initialDistanceChangedHandler);
		
			arenaRadiusChangedSignal = new NativeSignal(configurationView.arenaInitialRadiusInput, Event.CHANGE);
			arenaRadiusChangedSignal.add(arenaRadiusChangedHandler);
		
			shrinkingStartChangedSignal = new NativeSignal(configurationView.shrinkingStartInput, Event.CHANGE);
			shrinkingStartChangedSignal.add(shrinkingStartChangedHandler);
		
			shrinkingIntervalChangedSignal = new NativeSignal(configurationView.shrinkingIntervalInput, Event.CHANGE);
			shrinkingIntervalChangedSignal.add(shrinkingIntervalChangedHandler);
		
			shrinkingChangedSignal = new NativeSignal(configurationView.shrinkingInput, Event.CHANGE);
			shrinkingChangedSignal.add(shrinkingChangedHandler);
		
			turnDurationChangedSignal = new NativeSignal(configurationView.turnDurationInput, Event.CHANGE);
			turnDurationChangedSignal.add(turnDurationChangedHandler);
			
			winningRoundsChangedSignal = new NativeSignal(configurationView.winningRoundInput, Event.CHANGE);
			winningRoundsChangedSignal.add(winningRoundsChangedHandler);
		}


		private function sphereRadiusChangedHandler(event:Event):void 
		{
			changeSphereRadiusSignal.dispatch(configurationView.sphereRadiusInput.value);
		}
		
		private function speedVariationChangedHandler(event:Event):void 
		{
			changeSpeedVariationSignal.dispatch(configurationView.speedVariationInput.value);
		}
		
		private function initialDistanceChangedHandler(event:Event):void 
		{
			changeInitialDistanceSignal.dispatch(configurationView.initialDistanceInput.value);
		}
		
		private function arenaRadiusChangedHandler(event:Event):void 
		{
			changeArenaRadiusSignal.dispatch(configurationView.arenaInitialRadiusInput.value);
		}
		private function shrinkingStartChangedHandler(event:Event):void
		{
			changeShrinkingStartSignal.dispatch(configurationView.shrinkingStartInput.value);
		}
		
		private function shrinkingIntervalChangedHandler(event:Event):void
		{
			changeShrinkingIntervalSignal.dispatch(configurationView.shrinkingIntervalInput.value);
		}
		
		private function shrinkingChangedHandler(event:Event):void
		{
			changeShrinkingSignal.dispatch(configurationView.shrinkingInput.value);
		}
		
		private function turnDurationChangedHandler(event:Event):void
		{
			changeTurnDurationSignal.dispatch(configurationView.turnDurationInput.value);
		}
		
		private function winningRoundsChangedHandler(event:Event):void
		{
			changeWinningRoundsSignal.dispatch(configurationView.winningRoundInput.value);
		}
	}
}