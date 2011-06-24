package controller.signals
{
	import model.vo.Player;
	
	import org.osflash.signals.Signal;
	
	public class SelectPlayerSignal extends Signal
	{
		public function SelectPlayerSignal()
		{
			// the name of the player
			super(Player);
		}
	}
}