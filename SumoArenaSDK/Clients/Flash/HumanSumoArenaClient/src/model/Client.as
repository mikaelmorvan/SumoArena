package model
{
	import com.adobe.serialization.json.JSON;
	
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.Socket;
	import flash.net.sendToURL;
	
	public class Client extends Socket
	{
		public var log:Function;
		
		public var createSpheres:Function;
		
		public var updateSpheres:Function;
		
		
		public function Client()
		{
			super();
			addEventListener(Event.CLOSE, onClose);
			addEventListener(Event.CONNECT, onConnect);
			addEventListener(IOErrorEvent.IO_ERROR, onError);
			addEventListener(ProgressEvent.SOCKET_DATA, onData);
			addEventListener(SecurityErrorEvent.SECURITY_ERROR, onError);
		}
		
		public var name:String;
		
		public var host:String;
		
		public var port:int;
		
		public function connectToServer():void
		{
			connect(host, port);
			log(">connect");
		}
		
		public function updateSphere(dVx:Number, dVy:Number):void
		{
			var data:Object = 
				{
					action: "updateVector",
					parameters:
					{
						dVx: dVx,
						dVy: dVy
					}
				};
			send(data);
		}
		
		private function send(data:Object):void
		{
			var dataToString:String = JSON.encode(data);
			log(">send: " + dataToString);
			try {
				writeUTFBytes(dataToString);
				flush();
			} catch (error:Error) {
				log(">error: can not send data");
			}
		}
		
		protected function onData(event:ProgressEvent):void
		{
			if (bytesAvailable)
			{
				var s:String = readUTFBytes(bytesAvailable);
				log(">data: " + s);
				try {
					var data:Object = JSON.decode(s);
					if(data.hasOwnProperty("action")) 
					{
						if (data.action == "play")
						{
							updateSpheres(data.parameters)
						} else if (data.action == "prepare") {
							createSpheres(data.parameters);
						} else {
							log(">error: response is not a valid");
						}
					} else {
						log(">error: response is not a valid");
					}
				}
				catch (error:Error) {
					log(">error: response is not a valid Json"); 
				}
			}
		}
		
		protected function onError(event:ErrorEvent):void
		{
			log(">error: " + event.text);
		}
		
		protected function onClose(event:Event):void
		{
			log(">closed");			
		}
		
		protected function onConnect(event:Event):void
		{
			log(">connected");
			var data:Object = 
				{
					action: "connectPlayer",
					parameters: 
					{
						name: name
					}
				};
			
			send(data);
		}
	}
}