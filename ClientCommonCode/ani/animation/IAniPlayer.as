package animation
{
	import flash.display.BitmapData;
	import flash.geom.Point;
	
	public interface IAniPlayer
	{
		function gotoAndStop(frame:int, sceneContain:BitmapData, screenX:int=0, screenY:int=0,  
			alphaBitmapData:BitmapData = null, alphaPoint:Point = null, mergeAlpha:Boolean = true ):void;
		
		function gotoAndPlay(sceneContain:BitmapData, screenX:int=0, screenY:int=0, 
			alphaBitmapData:BitmapData = null, alphaPoint:Point = null, mergeAlpha:Boolean = true ):void;
	}
}