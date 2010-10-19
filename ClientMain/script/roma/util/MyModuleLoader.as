package roma.util
{
	import flash.events.EventDispatcher;
	
	import mx.events.ModuleEvent;
	import mx.modules.IModuleInfo;
	import mx.modules.ModuleManager;
	
	public class MyModuleLoader extends EventDispatcher{

		private var module:IModuleInfo;
		
		public var child:Object;
		
		public function MyModuleLoader(url:String){
			module = ModuleManager.getModule(url);
		}
		
	    private function moduleReadyHandler(event:ModuleEvent):void {
			this.child = module.factory.create();
			dispatchEvent(event);
		}
		
		private function reDispatch(event:ModuleEvent):void {
			this.dispatchEvent(event);
		}
		
		public function load():void {
			
			module.addEventListener(ModuleEvent.PROGRESS, reDispatch);
			module.addEventListener(ModuleEvent.SETUP, reDispatch);
			module.addEventListener(ModuleEvent.READY, moduleReadyHandler);
			module.addEventListener(ModuleEvent.ERROR, reDispatch);
			module.addEventListener(ModuleEvent.UNLOAD, reDispatch);
			module.load();
		}
		
		public function release():void {
			this.module.release();
		}
	}
}