package
{
	import controller.commands.CreateSphereCommand;
	import controller.commands.DestroySphereCommand;
	import controller.commands.LogCommand;
	import controller.commands.RegisterPlayerCommand;
	import controller.commands.SelectPlayerCommand;
	import controller.commands.SetArenaInitialRadiusCommand;
	import controller.commands.SetInitialDistanceCommand;
	import controller.commands.SetShrinkingCommand;
	import controller.commands.SetShrinkingIntervalCommand;
	import controller.commands.SetShrinkingStartCommand;
	import controller.commands.SetSpeedVariationCommand;
	import controller.commands.SetSphereRadiusCommand;
	import controller.commands.SetTurnDurationCommand;
	import controller.commands.SetWinningRoundsCommand;
	import controller.commands.StartGameCommand;
	import controller.commands.StartServerCommand;
	import controller.commands.StopGameCommand;
	import controller.commands.UnregisterPlayerCommand;
	import controller.commands.UnselectPlayerCommand;
	import controller.commands.UpdateCommand;
	import controller.commands.UpdateSphereCommand;
	import controller.signals.ChangeArenaRadiusSignal;
	import controller.signals.ChangeInitialDistanceSignal;
	import controller.signals.ChangeShrinkingIntervalSignal;
	import controller.signals.ChangeShrinkingSignal;
	import controller.signals.ChangeShrinkingStartSignal;
	import controller.signals.ChangeSpeedVariationSignal;
	import controller.signals.ChangeSphereRadiusSignal;
	import controller.signals.ChangeTurnDurationSignal;
	import controller.signals.ChangeWinningRoundsSignal;
	import controller.signals.CreateSphereSignal;
	import controller.signals.DestroySphereSignal;
	import controller.signals.LogSignal;
	import controller.signals.RegisterPlayerSignal;
	import controller.signals.SelectPlayerSignal;
	import controller.signals.StartServerSignal;
	import controller.signals.StartSignal;
	import controller.signals.StopSignal;
	import controller.signals.UnregisterPlayerSignal;
	import controller.signals.UnselectPlayerSignal;
	import controller.signals.UpdateSignal;
	import controller.signals.UpdateSphereSignal;
	
	import model.ArenaModel;
	import model.GameModel;
	import model.LogModel;
	import model.SphereConfigurationModel;
	import model.SphereModel;
	
	import org.robotlegs.mvcs.SignalContext;
	
	import service.Server;
	
	import view.components.ArenaView;
	import view.components.ConfigurationView;
	import view.components.ControlView;
	import view.components.GameView;
	import view.components.LogView;
	import view.components.PlayerView;
	import view.components.ServerView;
	import view.mediators.ApplicationMediator;
	import view.mediators.ArenaViewMediator;
	import view.mediators.ConfigurationViewMediator;
	import view.mediators.ControlViewMediator;
	import view.mediators.LogViewMediator;
	import view.mediators.PlayerViewMediator;
	import view.mediators.ServerViewMediator;
	
	public class SumoContext extends SignalContext 
	{
		public override function startup():void
		{
			mapModels();
			mapControllers();
			mapViews();
			mapServices(); 
			super.startup();
		}

		
		private function mapModels():void
		{
			injector.mapSingleton(GameModel);
			injector.mapSingleton(ArenaModel);
			injector.mapSingleton(SphereModel);
			injector.mapSingleton(SphereConfigurationModel);
			injector.mapSingleton(LogModel);
		}		
		
		private function mapViews():void
		{
			mediatorMap.mapView(SumoBotGameController, ApplicationMediator);
			mediatorMap.mapView(ServerView, ServerViewMediator);
			mediatorMap.mapView(PlayerView, PlayerViewMediator);
			mediatorMap.mapView(ConfigurationView, ConfigurationViewMediator);
			mediatorMap.mapView(ControlView, ControlViewMediator);
//			mediatorMap.mapView(ArenaView, ArenaViewMediator);
			mediatorMap.mapView(GameView, ArenaViewMediator);
			mediatorMap.mapView(LogView, LogViewMediator);
		}		
		
		private function mapControllers():void
		{
			//application
			signalCommandMap.mapSignalClass(UpdateSignal, UpdateCommand);
			
			//server
			signalCommandMap.mapSignalClass(StartServerSignal, StartServerCommand);
			
			//logs
			signalCommandMap.mapSignalClass(LogSignal, LogCommand);
			
			//sphere
			signalCommandMap.mapSignalClass(CreateSphereSignal, CreateSphereCommand);
			signalCommandMap.mapSignalClass(DestroySphereSignal, DestroySphereCommand);
			signalCommandMap.mapSignalClass(ChangeSphereRadiusSignal, SetSphereRadiusCommand);
			signalCommandMap.mapSignalClass(ChangeSpeedVariationSignal, SetSpeedVariationCommand);
			signalCommandMap.mapSignalClass(ChangeInitialDistanceSignal, SetInitialDistanceCommand);
			signalCommandMap.mapSignalClass(UpdateSphereSignal, UpdateSphereCommand);
			
			//arena
			signalCommandMap.mapSignalClass(ChangeArenaRadiusSignal, SetArenaInitialRadiusCommand);
			signalCommandMap.mapSignalClass(ChangeShrinkingStartSignal, SetShrinkingStartCommand);
			signalCommandMap.mapSignalClass(ChangeShrinkingIntervalSignal, SetShrinkingIntervalCommand);
			signalCommandMap.mapSignalClass(ChangeShrinkingSignal, SetShrinkingCommand);
			
			//game
			signalCommandMap.mapSignalClass(ChangeTurnDurationSignal, SetTurnDurationCommand);
			signalCommandMap.mapSignalClass(ChangeWinningRoundsSignal, SetWinningRoundsCommand);
			signalCommandMap.mapSignalClass(StartSignal, StartGameCommand);
			signalCommandMap.mapSignalClass(StopSignal, StopGameCommand);
			signalCommandMap.mapSignalClass(SelectPlayerSignal, SelectPlayerCommand);
			signalCommandMap.mapSignalClass(UnselectPlayerSignal, UnselectPlayerCommand);
			signalCommandMap.mapSignalClass(RegisterPlayerSignal, RegisterPlayerCommand);
			signalCommandMap.mapSignalClass(UnregisterPlayerSignal, UnregisterPlayerCommand);
		}
		
		private function mapServices():void
		{
			injector.mapSingleton(Server);
		}		

	}
}