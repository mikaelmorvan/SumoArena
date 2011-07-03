package model.vo
{
	import flash.net.Socket;

	public class Player
	{
		public var id:int;
		
		[Bindable]
		public var name:String;
		
		[Bindable]
		public var color:uint = 0x000000;
		
		public var requestedDx:Number;
		
		public var requestedDy:Number;
		
		public var responseExpected:Boolean;
		
		// url of the avatar
		[Bindable]
		public var avatar:String;
		
		public var socket:Socket;
		
		[Bindable]
		public var sphere:Sphere;
		
		[Bindable]
		public var wonRounds:int;
		
		
		public function toString():String
		{
			return "Player{id:" + id + ", name:\"" + name + "\", color:" + color + ", requestedDx:" + requestedDx + ", requestedDy:" + requestedDy + ", responseExpected:" + responseExpected + ", avatar:\"" + avatar + "\", socket:" + socket + ", wonRounds:" + wonRounds + "}";
		}


	}
}