package controller.signals
{
	import model.vo.Player;
	
	import org.osflash.signals.Signal;
	
	public class UpdateSphereSignal extends Signal
	{		
		public function UpdateSphereSignal()
		{
			super(Player);
		}
	}
}