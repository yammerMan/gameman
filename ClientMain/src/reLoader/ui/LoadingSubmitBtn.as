package reLoader.ui
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.display.MovieClip;
	
	import reLoader.LoadingHandle;
	
	public class LoadingSubmitBtn extends MovieClip
	{
		public function LoadingSubmitBtn()
		{
			this.addEventListener(MouseEvent.CLICK,clickHandle);
			TextField(this["btn_txt"]).mouseEnabled=false;
			this["btnMc"].useHandCursor=false;
		}
		
		public function set btnText(str:String):void{
			this["btn_txt"].text=str;
		}
		private function clickHandle(event:MouseEvent):void{
			LoadingHandle.loginHandle();
		}

	}
}