package reLoader.ui
{
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.ProgressEvent;
	import flash.text.TextField;
	
	
	public class LoadingSkin extends MovieClip
	{
		private var actionName:String

		private var totalSize:Number = 10000;//需要下载的总字节数

		private var newFile:Boolean = false;
		private var lastLen:Number = 0;
		private var curTotalLen:Number = 0;
		
		private var bgLoader:Loader;
		
		
		public function LoadingSkin()
		{
			super();
		}
		
		public function get numTextField():TextField{
			return this["numText"];
		}
		
		public function get byteTextField():TextField{
			return this["byteText"];
		} 
		
		public function get progressBarMc():Sprite{
			return this["progressBar_mc"];
		}
		
		
		public function setDebugTest(str:String):void {
			this["debugText"].text = str;
		}

		public function beginLoad(str:String):void {
			this.actionName = str;
			this.newFile = true;
		}

		public function setTotalSize(size:Number):void {
			this.totalSize = size;
		}
		
		public function setProgressEvent(e:ProgressEvent):void{
			if (e != null && e.bytesTotal >0) {
				
				if (this.newFile) {
					this.newFile = false;
					this.curTotalLen += this.lastLen;
					this.lastLen = e.bytesTotal;
					trace(this.actionName + " " + e.bytesTotal);
				}
				
				var loaded:Number = e.bytesLoaded + this.curTotalLen;
				if (e.bytesTotal + this.curTotalLen > this.totalSize) {
					this.totalSize = e.bytesTotal + this.curTotalLen;
				}
				
				var percent:Number = Math.round(loaded / this.totalSize * 100);
				this["progressBar_mc"].visible = true;
				this["progressBar_mc"]["progressBGMask"].scaleX = percent/100>1?1:percent/100;
	
				var text:String = this.actionName + "\n" + loaded + "/" + this.totalSize+"\t"+percent+"%";

				//trace(text);
				
				this.numTextField.text = percent + "%";
				this.byteTextField.text = this.actionName+"\t"+e.bytesLoaded+"/"+e.bytesTotal;
			} else {
				this.numTextField.text = "";
				this["progressBar_mc"].visible = false;
			}
		}
		
	}
}