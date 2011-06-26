package model
{
	import org.osflash.signals.Signal;
	import org.robotlegs.mvcs.Actor;
	
	
	public class LogModel
	{
		[Bindable]
		public var logs:String;
		
	    public const MAX_LENGTH:int = 4000;
		
		public var logged:Signal;
		
		public function LogModel()
		{
			logs = '';
			logged = new Signal(String);
		}
		//TODO corriger bug
		private var _previousMessage:String; // workaround for a bug: the signal is received twice
		
		public function log(message:String):void 
		{
//			trace("call to logmodel.log");
			if(logs.length > MAX_LENGTH)
			{
				logs = logs.substring(message.length);
			}
			if(message != _previousMessage) {
				_previousMessage = message;
				logs += message + "\n";
				logged.dispatch(logs);
			}
			else {
				_previousMessage = null;
			}
		}
	}
}