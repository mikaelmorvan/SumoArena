package model
{
	import model.vo.Arena;
	
	import org.robotlegs.mvcs.Actor;
	
	public class ArenaModel extends Actor
	{
		public var arena:Arena;
		
		public function ArenaModel()
		{
			super();
			arena = new Arena();
		}
		
//		public function set initialRadius (value:int):void
//		{
//			arena.initialRadius = value;
//			arena.height = arena.initialRadius * 2 + 100;
//			arena.width = arena.height;
//			trace(arena.toString());
//		}
		
		public function set radius (value:int):void
		{
			arena.radius = value;
			arena.squareRadius = value * value;
			trace(arena.toString());
		}
		
		public function set shrinkingStartTick(value:int):void
		{
			arena.shrinkingStartTick = value;
		}
		
		/**
		 * @param value the number of pixels of which the arena radius will be reduced at each shrinking
		 */
		public function set shrinking(value:int):void
		{
			arena.shrinking = value;
		}
		
		/**
		 * @param value the interval between two diameter reductions, in number of ticks
		 */		
		public function set shrinkingInterval(value:int):void
		{
			arena.shrinkingInterval = value;
		}		
		
		/**
		 * Update the arenas size according to the tick number 
		 * @param tick the current tick number
		 */		
		public function update(tick:uint, stepByTurn:int):void 
		{
			if (arena.shrinkingStartTick >= 0 && tick >= arena.nextShrinkingTick && arena.radius > arena.minimalRadius) 
			{
				arena.radius -= arena.shrinking / stepByTurn;
				arena.squareRadius = arena.radius * arena.radius;
				arena.nextShrinkingTick += arena.shrinkingInterval / stepByTurn;
			}
		}
		
	}
}