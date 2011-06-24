package controller.signals
{
	import org.osflash.signals.Signal;
	
	public class LogSignal extends Signal
	{
		public function LogSignal()
		{
			// the message to be logged
			super(String);
		}
	}
}