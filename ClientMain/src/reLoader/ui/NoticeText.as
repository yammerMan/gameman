package reLoader.ui
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.display.MovieClip;

	public class NoticeText extends MovieClip
	{
		public function NoticeText()
		{
			super();
			txt.addEventListener(Event.SCROLL,textScrollHandler);
			scroll.addEventListener(Event.SCROLL,scrollHandler);
		}
		
		public function get txt():TextField{
			return this["text_txt"];
		}		
		public function get scroll():ScrollBar{
			return this["scroll_mc"]?this["scroll_mc"]:this["scrollSort_mc"];
		}
		
		public function set text(s:String):void{
			txt.htmlText = s;
			if(txt.maxScrollV > 1){
				scroll.visible = true;
				if(txt.scrollV >= txt.maxScrollV-2){
					scrollToBottom();
				}
			}else{
				scroll.visible = false;
			}
		}
		
		public function scrollToBottom():void{
			txt.scrollV = txt.maxScrollV;
			scroll.scrollTo(txt.scrollV-1,txt.maxScrollV-1);	
		}
		
		public function get text():String{
			return txt.htmlText;
		}
		
		private function textScrollHandler(event:Event):void{
			scroll.scrollTo(txt.scrollV-1,txt.maxScrollV-1);
		}
		private function scrollHandler(event:Event):void{
			txt.scrollV = Math.ceil(txt.maxScrollV * scroll.position);
		}
		
	}
}