package roma.war.ui
{
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.display.MovieClip;

	public class HeroItem extends Sprite
	{
		public function HeroItem()
		{
			super();
			while(iconMc.numChildren)iconMc.removeChildAt(0);
			tf = new TextFormat();
			tf.font = "Tahoma";
//			addEventListener(Event.REMOVED_FROM_STAGE,dispose);
		}
		
		public var key:Number;
		private var tf:TextFormat;
		
		public function get iconMc():Sprite{
			return this["icon_mc"];
		}
		public function get nameTxt():TextField{
			return this["name_txt"];
		}
		public function get stateTxt():TextField{
			return this["state_txt"];
		}
		
		public function get heroName():String{
			return nameTxt.text;
		}
		public function set heroName(s:String):void{
			if(s!=nameTxt.text){
				nameTxt.text = s;
				nameTxt.setTextFormat(tf);
			}
		}
		public function get state():String{
			return stateTxt.text;
		}
		public function set state(s:String):void{
			if(s != stateTxt.text){
				stateTxt.text = s;
				stateTxt.setTextFormat(tf);
			}
		}
		
		public function set logo(bmp:BitmapData):void{
			if(bmp != null)
			draw(bmp);
		}
		
		public function dispose(event:Event = null):void{
//			if(tbmp)tbmp.dispose();
//			if(iconMc)iconMc.graphics.clear();
		}
		
		private var tbmp:BitmapData 
		public function dead():void{
			if(tbmp)return;
			if(iconMc.width <=0 || iconMc.height <=0)return;
			tbmp = new BitmapData(iconMc.width,iconMc.height,true,0x00000000);
			tbmp.draw(iconMc);
			for(var i:Number = 3;i< iconMc.height-3;i++)
			for(var j:Number = 3;j< iconMc.width-3;j++)
				{
					var cn:uint = tbmp.getPixel(j,i);
					var crgb:uint = (((cn>>>16)*3+(cn>>>8&0xff)*6+(cn&0xff))/10)>>0;
					var cc:uint = crgb<<16 | crgb << 8 | crgb
					tbmp.setPixel(j,i,cc);
				}
			draw(tbmp);
		}
		
		private function draw(bmp:BitmapData):void{
			iconMc.graphics.clear();
			iconMc.graphics.beginBitmapFill(bmp);
			iconMc.graphics.drawRect(0,0,bmp.width,bmp.height);
			iconMc.graphics.endFill();
		}
	}
}