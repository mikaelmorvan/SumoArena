package controller.signals
{
	import org.osflash.signals.Signal;

	public class StartServerSignal extends Signal
	{
		public function StartServerSignal()
		{
			//the port number
			super(uint);
		}
	}
}