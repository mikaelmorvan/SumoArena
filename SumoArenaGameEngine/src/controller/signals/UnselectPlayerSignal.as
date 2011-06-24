package controller.signals
{
	import model.vo.Player;
	
	import org.osflash.signals.Signal;
	
	public class UnselectPlayerSignal extends Signal
	{
		public function UnselectPlayerSignal()
		{
			//the player to be removed from the game
			super(Player);
		}
	}
}