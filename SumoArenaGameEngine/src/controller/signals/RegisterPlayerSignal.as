package controller.signals
{
	import model.vo.Player;
	
	import org.osflash.signals.Signal;
	
	public class RegisterPlayerSignal extends Signal
	{
		public function RegisterPlayerSignal()
		{
			// the name of the player
			super(Player);
		}
	}
}