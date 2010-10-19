package roma.war.ui
{
	import flash.display.Sprite;
	
	public class PlayBar extends Sprite
	{
		public function PlayBar()
		{
		}
		public function get position():Number{
			return progress.position;
		}
		
		public function get stateBtns():PlayStateBtn{
			return this["stateBtn_mc"];
		}
		public function get progress():ProgressLine{
			return this["progress_mc"];
		}
		public function get windowBtns():WindowStateBtn{
			return this["windowBtn_mc"];
		}
		
		public function setProgress(pos:Number,length:Number):void{
			progress.setProgress(pos,length);
		}
		
		public function update():void{
			progress.update();
		}
		
	}
}