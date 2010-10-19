package roma.war.ui
{
	import flash.display.Sprite;
	import flash.display.MovieClip;
	
	public class BarHP extends Sprite
	{
		public function get line():Sprite{
			return this["hp_mc"] as Sprite;
		}
		
		public function BarHP()
		{
			
		}

		public function setProgress(currentNumber:Number,totalNumber:Number,isRealView:Boolean = false):void{
			if(isRealView){
				line.scaleX = currentNumber/totalNumber;
			}
		}
		
	}
}