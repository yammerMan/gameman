package roma.war
{
	public class WareplayerSettings
	{
		public static var instance:WareplayerSettings = new WareplayerSettings();
		
		public var fps:Number = 24;
		//rapid play
		public var rapid:Number = .5;
		//one round times
		public var roundTimes:Number = 10;
		//auto play
		public var autoPlay:Boolean = true;
		// 语言资源
		public var langStr:String = "";
		
		public function dispose():void{
		}
		
		public function WareplayerSettings()
		{
		}
		
		public function parseXMLString(value:Object):void{
			var input:String = value.toString();
			try{
				parseXML(new XML(input));
			}catch(e:Error){
				trace(this,e);
			}
		}
		
		public function setLanguege(l:String):void{
			this.langStr = l;
		}
		
		public function parseXML(value:XML):void{
			var input:XML = value;
			//player
			fps = Number(input.player.fps);
			rapid = Number(input.player.rapid);
			roundTimes = Number(input.player.roundtimes);
			autoPlay = input.player.autoplay.toString()=="true";
			
			var i:uint = 0;
		}
		
	}
}