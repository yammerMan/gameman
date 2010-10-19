package roma.war.ui
{
	import flash.display.Sprite;
	import flash.display.MovieClip;
	
	public class LineHP extends Sprite
	{
		public function get line():Sprite{
			return this["mask_mc"] as Sprite;
		}
		
		public function LineHP()
		{
		}
		
		public var currentNumber:Number = 0;
		public var targetNumberber:Number = 0;
		public var totalNumber:Number;
		public var step:Number = 1;
		
		private var right:Boolean = false;
		public function setProgress(currentNumber:Number,totalNumber:Number,right:Boolean = true):void{
			if(totalNumber>0){
				this.targetNumberber = currentNumber;
				this.totalNumber = totalNumber;
			}else{
				this.targetNumberber = 0;
			}
			
			this.right = right;
		}
		
		/**
		 * 血槽的更新
		 */ 
		public function hpUpdate():void{
			if(this.targetNumberber/totalNumber > 0.01)
				line.scaleX = targetNumberber/totalNumber;
			else{
				line.scaleX = 1;
			}
			
		}
		
		public function update():void{
			this.step = (this.currentNumber - this.targetNumberber)*.3
			/*
			 if(Math.abs(this.step)<10){
				this.step = this.step>0 ? 100 : -100;
			 } 
			 */
			
			if(Math.abs(currentNumber - targetNumberber)/totalNumber < 0.01){
				currentNumber = targetNumberber;
			}else if(currentNumber!=targetNumberber){
				currentNumber -= step;
			}
			if(right)
			line.scaleX = (totalNumber-currentNumber)/totalNumber;
			else
			line.scaleX = currentNumber/totalNumber;
			
		}

	}
}