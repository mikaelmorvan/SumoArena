package model.vo
{
	import mx.collections.ArrayList;

	[Bindable]
	public class Game
	{
		// the interval in ticks between two player requests
		public static const REQUEST_INTERVAL:uint = 20;
		
		public var arena:Arena;
		
		public var availablePlayers:ArrayList = new ArrayList(); /* of strings */
		
		public var selectedPlayers:ArrayList = new ArrayList(); /* of strings */
		
		public var spheres:ArrayList = new ArrayList(); /* of spheres */

		public var aliveSpheres:ArrayList = new ArrayList(); /* of spheres */
		
		//TODO : à supprimer ?
		public var maxTime:uint = 1000;
		
		public var currentTick:uint;
		
		public var maxWinningRounds:int = 2;
		
		public var turnDuration:int = 1000;
		
		public var stepByTurn:int = turnDuration / REQUEST_INTERVAL;
		
		// The maximum duration of a round, if no ball is out before the maximal arena shrinking
		public var roundDuration:int;
		

		public function toString():String
		{
			return "Game{arena:" + arena + ", spheres:" + spheres + ", aliveSpheres:" + aliveSpheres + ", maxTime:" + maxTime + ", currentTick:" + currentTick + ", maxWinningRounds:" + maxWinningRounds + ", turnDuration:" + turnDuration + ", stepByTurn:" + stepByTurn + ", roundDuration:" + roundDuration + "}";
		}



	}
}