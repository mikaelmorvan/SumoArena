package model.vo
{
	import mx.collections.ArrayList;

	[Bindable]
	public class Game
	{
		// the interval in ticks between two player requests
		public static const REQUEST_INTERVAL_IN_TICKS:uint = 20;
		
		public var arena:Arena;
		
		public var availablePlayers:ArrayList = new ArrayList(); /* of strings */
		
		public var selectedPlayers:ArrayList = new ArrayList(); /* of strings */
		
		public var spheres:ArrayList = new ArrayList(); /* of spheres */

		public var aliveSpheres:ArrayList = new ArrayList(); /* of spheres */
		
		public var currentTick:uint;
		
		public var roundRequiredToWin:int = 2;
		
		public var requestInterval:int = 1000;
		
		public var stepByTurn:int = requestInterval / REQUEST_INTERVAL_IN_TICKS;
		
		// The maximum duration of a round, if no ball is out before the maximal arena shrinking
		public var roundDuration:int;
		
		public var currentRound:int;
		

		public function toString():String
		{
			return "Game{arena:" + arena + ", spheres:" + spheres + ", aliveSpheres:" + aliveSpheres + "currentTick:" + currentTick + ", maxWinningRounds:" + roundRequiredToWin + ", turnDuration:" + requestInterval + ", stepByTurn:" + stepByTurn + ", roundDuration:" + roundDuration + "}";
		}
	}
}