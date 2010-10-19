package views
{
	import flash.display.MovieClip;
	
	import gs.plugins.VolumePlugin;
	
	import mx.core.UIComponent;
	
	import roma.resource.ImgManager;

	public class PleaseWaitUC extends UIComponent
	{
		public static var instance:PleaseWaitUC = new PleaseWaitUC();
		
		private var loadingMc:MovieClip;
		
		public function PleaseWaitUC(){
			super();
			this.width = 1000;
			this.height = 600;
			
//			var loadingMcClass:Class = ImgManager.clazz("login.pleaseWait");
//			var loadingMc:Bitmap = new loadingMcClass;
			
			var loadingMcClass:Class = ImgManager.clazz("login.loading");
			loadingMc = new loadingMcClass;
			
			loadingMc.x = (this.width - 185)/2;
			loadingMc.y = (this.height - 103)/2;
			loadingMc.gotoAndStop(0);
			
			this.addChild(loadingMc);
			this.visible = false;
		}
		
		public function show():void {
			this.visible = true
			this.loadingMc.gotoAndPlay(1);
		}
		
		public function hide():void {
			this.visible = false
			this.loadingMc.gotoAndStop(1);
		}
	}
}