package views.windows
{
	import framework.game.MouseCursorManager;
	
	import mx.containers.Canvas;
	import mx.events.FlexEvent;
	
	import roma.interfaces.IModuleInterface;

	public class BaseWin extends Canvas implements IModuleInterface
	{
		public var winData:Object = null; 
		public var winId:String =null;

		private var showing:Boolean = false; 
		//是否显示返回按钮
		private var b:Boolean;

		public function BaseWin()
		{
			super();
			
			this.cacheAsBitmap = true;//使用此代码会使界面模糊
			this.beforeInit();
			this.addEventListener(FlexEvent.CREATION_COMPLETE, onCreationComplete,false,-1);
			this.mouseEnabled = false;
		}
		
		protected function beforeInit():void {
		}
		
		protected function onCreationComplete(event:FlexEvent):void {
			MouseCursorManager.setNormal();
			if (this.showing) {
				this.refresh();
			}
		}
		
		public function gotoWin(data:Object):void {
			
		}

		public function onShowUpdate():void {
			trace(this.className + " isShowing");
			
			this.showing = true;
			if (this.initialized) {
				this.refresh();
			} else {
				MouseCursorManager.setBusy()
			}
		}
		
		public function destroy():void {
			this.showing = false;
			trace(this.className + " IModuleInterface.destroy()");
		}

		public function refresh():void {
			trace(this.className + " IModuleInterface.refresh()");
		}

		public function update():void{
		}
		
		public function isShow():Boolean{
			return this.showing;
		}
		
		public function set bShow(b:Boolean):void{
			this.b = b;
		}
	}
}