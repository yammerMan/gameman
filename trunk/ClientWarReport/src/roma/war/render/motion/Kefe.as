package roma.war.render.motion
{
	import flash.geom.Point;
	
	import roma.war.resource.MotionResource;
	
	public class Kefe
	{
		public function Kefe()
		{
		}
		
		public var resLink:MotionResource;
		
		public var frame:Number = 0;
		
		//** 原地的攻击和有距离的攻击 */
//		public var attackType:int = 0;
		
		public var state:String = "normal";
		public var step:Number = 1;
		
		public var alpha:Number = 1;
		
		public var p:Point;
		public var sp:Point;
		public var tp:Point;
		//抛物线
		public var bounds:Number = 50;
		
		public var waitTime:Number = 0;
		
		public function getFrames():Number{
			// 这里会出现resLink为null的情况的，需要查明
			if(resLink == null)return -10000;
			return resLink.motion.getStateByName(state).frames.length;
		}
		
		public function canAction():Boolean{
			return waitTime-- < 0;
		}
		
		public function canRemove():Boolean{
			return frame > getFrames();
		}
		
		public function dispose():void{
			resLink = null;
		}
		
	}
}