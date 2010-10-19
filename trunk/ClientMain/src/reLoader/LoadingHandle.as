package reLoader
{
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	import roma.logic.CaesaryConfig;
	
	[Bindable]
	public class LoadingHandle
	{
		public static var instance:LoadingHandle=new LoadingHandle();
		 
		public var newString:String="";
		public var updataString:String="";
		public function LoadingHandle()
		{
		}
		/**
		 * 注册
		 */
		public static function loginHandle():void {
			
		}
		
		public static function loadNote():void {
           	var r:Number = new Date().valueOf();
           	if(CaesaryConfig.instance.noteUrl == "")return;
			var url:String=CaesaryConfig.instance.noteUrl+"?r="+r;
            try {
				var urlLoader:URLLoader = new URLLoader();
				urlLoader.addEventListener(Event.COMPLETE , instance.onConfigLoadCompleteHandle);
				urlLoader.addEventListener(ProgressEvent.PROGRESS,onProgressHandle);
				urlLoader.addEventListener(IOErrorEvent.IO_ERROR , ioErrorHandle);
				var urlRequest:URLRequest = new URLRequest(url);
                urlLoader.load(urlRequest);
            } catch (error:Error) {
                trace("Unable to load url path=" + url);
            }
            function onProgressHandle(event:ProgressEvent):void{
				
			}
			
			function ioErrorHandle(event:Event):void {
                trace("Unable to load url=" + url);
			}

		}
		private function onConfigLoadCompleteHandle(event:Event):void {
			var l:URLLoader = URLLoader(event.target);
			this.newString=l.data;
		}
	}
}