package roma.war.resource
{
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import roma.war.resource.embedsObj.BaseEmbedsObj;
	
	public class Motion
	{
	
		private var items:Object;
		
		private static var instance:Motion = new Motion();
		
		public function Motion()
		{
			items = new Object();
		}
		
		public function getStateByName(s:String):BaseEmbedsObj{
			return items[s];
		}
		
		internal function addMotionResource(ms:BaseEmbedsObj):void{
			items[ms.statusTypes] = ms; 
		}
		
		public function dispose():void{
			for each(var n:String in items){
				items[n] = null;
			}
		} 
		
		/**
		 * motion maker 
		 * @param ms	[MotionState,MotionState..]
		 **/
		public static function make(res:BitmapData,w:int,h:int,offsetX:int,offsetY:int,ms:Array):Motion{
			for(var i:int = 0;i<ms.length;i++){
				instance.setEmbedsArray(ms[i],res,w,h,ms[i].statusTypes);
				instance.addMotionResource(ms[i]);
			}
			return instance;
		}

		private function setEmbedsArray(b:BaseEmbedsObj,res:BitmapData,w:int,h:int,n:String):void{
			var r:Rectangle = new Rectangle(0,0,w,h);
			for(var i:int =0;i<b.actionArr.length;i++){
				var a:Array = String(b.actionArr[i]).split("");
				var p:Point;
				if(a.length<=1)p = new Point(int(a[0])*w,0);
				else{p = new Point(int(a[1])*w,int(a[0])*h);}
				b.embedsArr.push(MyResourceManager.instance.getBitmapData(res,r,p,n));
			}
			b.frame = b.embedsArr.length;
		}
	
	}
}