package roma.war.resource
{
	import flash.display.BitmapData;
	
	public class MotionResource
	{		
		public var motion:Motion;
		
		public function MotionResource(motion:Motion)
		{
			this.motion = motion;
			
		}
		
		//后期添加，用于快速开发,有潜在内存溢出危险
		/* internal var tempBMP:BitmapData;
		public function getFrameBMP(frame:Number,state:String = "normal"):BitmapData{
			if(!tempBMP)tempBMP = new BitmapData(tileWidth,tileHeight,true,0x00000000);
			var ms:MotionState = motion.getStateByName(state);
			frame = ms.frames[frame];
			var mtx:Matrix = new Matrix();
				mtx.tx = -(frame % lineCount) * tileWidth;
				mtx.ty = -Math.floor(frame/lineCount) * tileHeight;
			tempBMP.fillRect(new Rectangle(0,0,tempBMP.width,tempBMP.height),0x00000000);
			tempBMP.draw(resLink,mtx);
			return tempBMP;
		} 
		
		public function dispose():void{
			if(tempBMP)tempBMP.dispose();
			if(resLink)resLink = null;
		} */
	}
}