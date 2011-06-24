package controller.signals
{
	import model.vo.Sphere;
	
	import org.osflash.signals.Signal;
	
	public class DestroySphereSignal extends Signal
	{
		public function DestroySphereSignal()
		{
			//the name of the sphere to be destroyed
			super(Sphere);
		}
	}
}