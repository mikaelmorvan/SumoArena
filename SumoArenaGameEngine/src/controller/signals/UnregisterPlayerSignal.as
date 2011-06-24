package controller.signals
{
	import model.vo.Player;
	
	import org.osflash.signals.Signal;
	
	public class UnregisterPlayerSignal extends Signal
	{
		public function UnregisterPlayerSignal()
		{
			super(Player);
		}
	}
}