package view.mediators
{
	import model.ArenaModel;
	import model.GameModel;
	
	import org.robotlegs.mvcs.Mediator;
	
	import view.components.ArenaView;
	import view.components.GameView;
	
	public class ArenaViewMediator extends Mediator
	{
//		[Inject]
//		public var arenaView:ArenaView;
		
		[Inject]
		public var arenaView:GameView;
		
		[Inject]
		public var gameModel:GameModel;

		[Inject]
		public var arenaModel:ArenaModel;
		
		public override function onRegister():void
		{
			arenaView.arena = arenaModel.arena;
			arenaView.dataProvider = gameModel.game.spheres;
		}
	}
}