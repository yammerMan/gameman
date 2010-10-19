package views.mainModules.map
{
	import flash.events.Event;
	
	import mx.core.UIComponent;
	import mx.logging.ILogger;
	import mx.logging.Log;
	
	import roma.interfaces.IModuleInterface;
	import roma.message.EvtDispacther;
	
	import sound.MsgSound;
	
	import views.mainFrame.RollTextBar;
	import views.mainModules.map.diamond2.DiamondWorldMap2;

	public class MapMod extends UIComponent implements IModuleInterface
	{
		private static var log:ILogger = Log.getLogger("views.mainModules.map.MapMod");

		private var world:DiamondWorldMap2 = DiamondWorldMap2.instance; 

		public function MapMod()
		{
			super();
			this.width = 994;
			this.height = 400;
			this.addChild(this.world);
		}
		
		/**
		 * IModuleInterface 定义的析构方法
		 */
		public function refresh():void {
			log.debug("refresh()");
			this.world.setOnShow(true);
			this.world.setCenterToCurCastle();
			MsgSound.instance.playMapMusic();
			
			// 隐藏滚动文字
			EvtDispacther.instance.dispatchEvent(new Event(RollTextBar.ROOLTEXT_HIDE));
		}
		
		/**
		 * IModuleInterface定义的程序入口
		 */
		public function destroy():void {
			log.debug("destroy()");
			this.world.setOnShow(false);
		}
		
		public function update():void{
		
		}
	}
}