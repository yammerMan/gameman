package animation.aniSet
{
	import animation.AniPlayer;
	import animation.BaseAnimationData;
	import animation.IAniPlayer;
	
	import flash.display.BitmapData;
	import flash.geom.Point;
	
	public class BaseAniSetPlayer implements IAniPlayer
	{
		private var aniArray:Array = new Array()

		public function addAni(ani:BaseAnimationData , x:int=0 , y:int=0, randomStart:Boolean = false):void {
			var player:AniPlayer = new AniPlayer(ani ,x ,y , (randomStart)?-1:0); 
			this.aniArray.push(player);			
		}

		public function gotoAndStop(frame:int, scene:BitmapData, screenX:int=0, screenY:int=0,  
			alphaBitmapData:BitmapData = null, alphaPoint:Point = null, mergeAlpha:Boolean = true ):void {
		 	for(var i:int = 0; i<this.aniArray.length; i++){
		 		var player:AniPlayer = AniPlayer(this.aniArray[i]);
		 		player.gotoAndStop(frame,scene,screenX,screenY,alphaBitmapData,alphaPoint,mergeAlpha);
		 	}
		}
		
		public function gotoAndPlay(scene:BitmapData, screenX:int=0, screenY:int=0, 
			alphaBitmapData:BitmapData = null, alphaPoint:Point = null, mergeAlpha:Boolean = true ):void {

		 	for(var i:int = 0; i<this.aniArray.length; i++){
		 		var player:AniPlayer = AniPlayer(this.aniArray[i]);
		 		player.gotoAndPlay(scene,screenX,screenY,alphaBitmapData,alphaPoint,mergeAlpha);
		 	}
		}
		
		public function gotoAndPlay1(scene:BitmapData, screenX:int=0, screenY:int=0, 
			alphaBitmapData:BitmapData = null, alphaPoint:Point = null, mergeAlpha:Boolean = true ):void {
				
	 		var player:AniPlayer = AniPlayer(this.aniArray[0]);
	 		player.gotoAndPlay(scene,screenX,screenY,alphaBitmapData,alphaPoint,mergeAlpha);
		}
	}
}