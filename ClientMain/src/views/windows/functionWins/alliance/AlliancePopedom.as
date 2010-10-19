package views.windows.functionWins.alliance
{
	import mx.controls.Image;
	
	import roma.resource.ImgManager;
	
	public class AlliancePopedom extends Image
	{
		public function AlliancePopedom()
		{
			this.height=11;
			this.width=16
		}
		
		public function set popedom(canDo:Boolean):void{
			if(canDo){
//				this.source=ImgManager.appointedClazz("imgRes","alliance.popedomLogo");
				this.source=ImgManager.clazz('alliance.popedomLogo');
			}else{
				this.source=null;
			}
		}

	}
}