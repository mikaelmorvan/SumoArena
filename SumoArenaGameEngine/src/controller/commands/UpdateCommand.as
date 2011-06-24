package controller.commands
{
	import model.ArenaModel;
	import model.GameModel;
	import model.SphereModel;
	
	import org.robotlegs.mvcs.SignalCommand;
	
	/**
	 * Updates the game in progress 
	 * @author peal6230
	 */	
	public class UpdateCommand extends SignalCommand
	{
		[Inject]
		public var sphereModel:SphereModel;
		
		[Inject]
		public var gameModel:GameModel;
		
		[Inject]
		public var arenaModel:ArenaModel
		
		public override function execute():void
		{
			gameModel.update();
			sphereModel.handleCollisions(gameModel.game.aliveSpheres);
			arenaModel.update(gameModel.game.currentTick, gameModel.game.stepByTurn);
			sphereModel.updateAllPositions(gameModel.game.aliveSpheres, gameModel.game.stepByTurn);
			gameModel.checkSpherePosition();
		}
	}
}