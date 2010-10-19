package roma.war.resource.embedsObj
{
	import flash.display.BitmapData;
	import flash.geom.Rectangle;
	
	public class BaseEmbedsObj
	{
		public var curFrame:int = 0;
		
		public var statusTypes:String;
		public var actionArr:Array = [];
		public var embedsArr:Array = [];
		
		public var frame:int = 1;
		
		public var posX:int = 0;
		public var posY:int = 0;
		
		public function BaseEmbedsObj()
		{
		}
		
		public function getBit(state:int=-1):BitmapData{
			this.curFrame ++;
			if(this.curFrame >= frame){
				this.curFrame = 0;
			}
			return embedsArr[curFrame];
		}
		
		private var bit:BitmapData;
		private var rect:Rectangle = new Rectangle(0,0,0,0);
	}
}