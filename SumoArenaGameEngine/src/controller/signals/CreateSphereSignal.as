package controller.signals
{
	import model.vo.Player;
	
	import org.osflash.signals.Signal;
	
	public class CreateSphereSignal extends Signal
	{
		public function CreateSphereSignal()
		{
			super(Player);
		}
	}
}