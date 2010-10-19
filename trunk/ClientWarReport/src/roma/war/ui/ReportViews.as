package roma.war.ui
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	
	import roma.war.controler.MsgComDispatch;

	public class ReportViews extends Sprite
	{
		public var isStayLine:Boolean = false;
		
		public function ReportViews()
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
		
		public function set viewText(s:String):void{
			txt.htmlText = s;
			if(txt.maxScrollV > 1){
				scroll.visible = true;
				// 需要考虑是否为停留在某一行
				if(!isStayLine){
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
		
		private var eventObj:Object = {};
		public static var VIEW_ALL_SIZE:int = 21;
		public static var VIEW_SHORT_SIZE:int = 4;
		private function scrollHandler(event:Event):void{
			if(scroll.position >= 1){
				isStayLine = false;
			}else{
				isStayLine = true;
				MsgComDispatch.dispatch(new UiEvent(UiEvent.SCROLL_ACTION));
			}
			MsgComDispatch.dispatch(new UiEvent(UiEvent.SCROLL_STAY,isStayLine));
			txt.scrollV = Math.ceil(txt.maxScrollV * scroll.position);
		}
		
	}
}