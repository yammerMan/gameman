package roma.war.ui
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextFormat;
	import flash.utils.Dictionary;
	import flash.display.MovieClip;
	
	public class HeroesList extends Sprite
	{
		private var tf:TextFormat = new TextFormat("Tahoma");
		// <HeroItem>
		public var heroDic:Dictionary = new Dictionary();
		
		public function HeroesList()
		{
			super();
			heroDic = new Dictionary();
//			clear();
			listMc.mask = maskMc;
			
			addEventListener(MouseEvent.MOUSE_WHEEL,mouseWheelHandler);
			scroll.addEventListener(Event.SCROLL,scrollHandler);
		}
		
		private function scrollHandler(event:Event):void{
			if(maskMc.height < listMc.height)
				listScroll(scroll.position * (maskMc.height-listMc.height) - listMc.y);
		}
		
		public function get scroll():ScrollBar{
			return this["scroll_mc"];
		}
		public function get listMc():Sprite{
			return this["list_mc"];
		}
		public function get maskMc():Sprite{
			return this["mask_mc"];
		}
		
		
		public function addHero(h:heroItem):void{
			h.nameTxt.setTextFormat(tf);
			h.stateTxt.setTextFormat(tf);
			h.y = listMc.numChildren * h.height;
			scroll.scrollTo(0,listMc.height - maskMc.height);
			
			heroDic[h.key] = h;
		}
		
		public function addHeroList(arr:Array):void{
			var hi:heroItem = new heroItem();
			var c:int = 0;
			for each(hi in arr){
				hi.y = c * hi.height;
				listMc.addChild(hi);
				c ++;
			} 
		}
		
		private function mouseWheelHandler(event:MouseEvent):void{
			if(this.maskMc.height<this.listMc.height)
				listScroll(event.delta*2)
		}
		
		private function listScroll(delta:Number):void{
			var tn:Number = listMc.y + delta;
			if(tn>0)tn = 0;
			if(tn<maskMc.height-listMc.height){
				tn = maskMc.height-listMc.height
			}
			listMc.y = tn;
			
			//update scrollBar
			scroll.scrollTo(listMc.y>>0,maskMc.height - listMc.height);
		}
		
		public function clear():void{
			while(listMc.numChildren)listMc.removeChildAt(0);
		}
	}
}