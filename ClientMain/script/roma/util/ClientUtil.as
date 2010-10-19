package roma.util
{
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	
	import mx.logging.Log;
	import mx.logging.targets.TraceTarget;
	import mx.utils.StringUtil;
	
	public class ClientUtil
	{

		/**
		 * 读取一个文件, callback的为一个参数的function，参数类型可以是Object或者* ，作为读取的内容
		 */
		public static function loadFile(url:String, callback:Function ,fault:Function=null,progress:Function =null):void {
            try {
				var l:URLLoader = new URLLoader();
				l.addEventListener(Event.COMPLETE , onLoadComplete);
				l.addEventListener(ProgressEvent.PROGRESS,onProgressHandler);
				l.addEventListener(IOErrorEvent.IO_ERROR , ioErrorHandler);
				var r:URLRequest = new URLRequest(url);
                l.load(r);
            } catch (error:Error) {
            	if (fault!=null) {
            		fault.apply();
            	}
                trace("load url error for " + url);
            }

			function onProgressHandler(event:ProgressEvent):void{
				if(progress !=null){
					progress.apply(null,[event]);					
				}
			}
			
			function ioErrorHandler(event:Event):void {
            	if (fault!=null) {
            		fault.apply(null , [url]);
            	}
                trace("load url error for " + url);
			}

			function onLoadComplete(event:Event):void {
				var l:URLLoader = URLLoader(event.target);
				callback.apply(null , [l.data]);
			}
		}

		public static function initLogger(pkg:String , level:int):void {
			var logTarget:TraceTarget = new TraceTarget();
			logTarget.includeLevel = true;
			logTarget.includeCategory = true;
			logTarget.includeDate = false;
			logTarget.includeTime = false;
			logTarget.filters = [pkg];
			logTarget.level = level;
			Log.addTarget(logTarget);
		}
	}
}