package animation
{
	import flash.display.BitmapData;
	
	public class PenstockNullahAni
	{
		private var penstockAni:AniPlayer = new AniPlayer(AnimationManager.buildingsSet.penstockAni);
		
		private static var instance:PenstockNullahAni;

		public function PenstockNullahAni()
		{
		}
		
		public static function getInstance():PenstockNullahAni{
			if(instance == null){
				instance = new PenstockNullahAni(); 
			}
			
			return instance;		
		}
		
		public function aniPlay(screen:BitmapData,castleLevel:int):void{
			if(castleLevel>0){
				this.penstockAni.gotoAndPlay(screen,10,63);
			}
		}
	}
}