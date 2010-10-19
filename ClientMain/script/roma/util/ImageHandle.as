package roma.util
{
	import flash.display.Bitmap;
	import flash.events.Event;
	
	import mx.core.BitmapAsset;
	
	public class ImageHandle
	{
		public static function onLoadComplete(event:Event):void{
			
			if (event.currentTarget.content != null){
				if(event.currentTarget.content is BitmapAsset){
					BitmapAsset(event.currentTarget.content).smoothing = true;
				}else if(event.currentTarget.content is Bitmap){
					Bitmap(event.currentTarget.content).smoothing = true;
				}
			}
		}
	}
}