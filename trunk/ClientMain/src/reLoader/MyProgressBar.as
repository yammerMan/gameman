package reLoader
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import flash.events.ProgressEvent;
	
	import mx.events.FlexEvent;
	import mx.events.ResourceEvent;
	import mx.events.StyleEvent;
	import mx.preloaders.DownloadProgressBar;
	import mx.resources.ResourceManager;
	import mx.styles.StyleManager;
	
	import reLoader.ui.LoadingSkin;
	
	import roma.logic.CaesaryConfig;
	import roma.message.EvtDispacther;
	import roma.util.ClientUtil;
	import roma.util.MultiLang;
	
	public class MyProgressBar extends DownloadProgressBar
	{
		private var config:CaesaryConfig = CaesaryConfig.instance;

		private var loadingSprite:LoadingSkin = new reLoadMain() as LoadingSkin;

		private var ver:String = "1";
		
		public function MyProgressBar()
		{
			super();
			this.addChild(this.loadingSprite);
			this.loadingSprite.beginLoad("Main file");
		}

		override public function set preloader(sprite:Sprite):void{
	  		sprite.addEventListener(ProgressEvent.PROGRESS,loadingProgressBar);
	 		sprite.addEventListener(FlexEvent.INIT_COMPLETE,initEventComHandler);

	 		sprite.addEventListener(Event.COMPLETE,completeEventHandler);
	 		if (this.loaderInfo!=null) {
	 			var size:Number = Number(this.loaderInfo.parameters["totalSize"]);
	 			if (!isNaN(size) && size >0) {
	 				this.loadingSprite.setTotalSize(size);
	 			}
	 		}
	 		trace(this.loaderInfo);
	  	}
		
		/**
		 * 下载进度
		 */
		private function loadingProgressBar(e:ProgressEvent):void{
			this.loadingSprite.setProgressEvent(e);
		}
		
		private function completeEventHandler(e:Event):void{
			trace("完成了");
		}

		/**
		 * 初始化完成
		 */
		private function initEventComHandler(e:FlexEvent):void{
			trace("初始化完成");
			this.loadConfig();
		}


	 	private function loadConfig():void {
	 		var loadFildError:Function = function(url:String):void {
				throw new Error("unable load " + url);
			}
	 		
	 		var cfgValue:String = "";
	 		if (this.loaderInfo.parameters["config"]) {
	 			cfgValue = escape(this.loaderInfo.parameters["config"]);
	 		}
	 		
	 		//config的名字可修改
	 		var configName:String = "config" + cfgValue + ".xml?ver=" + new Date().valueOf();
			ClientUtil.loadFile(configName , setupConfig , loadFildError);
	 	}
	 	
	 	private function setupConfig(object:Object):void {
 			trace("LoadConfig() config.xml loaded!");
			config.config(XML(object));
	 		config.configFromFlashvars(this.loaderInfo);
	 		
	 		if (this.loaderInfo.parameters["ver"]) {
	 			this.ver = this.loaderInfo.parameters["ver"];
	 		}
	 		
			LoadingHandle.loadNote();
			loadLang();
	 	}
	
		private function loadBarHide():void{
		}			
		
	 	private function loadStyle():void {
			trace("Load Style:" + config.styleFileSwfName);
			this.loadingSprite.beginLoad("Style file");

	 		var cssLoadcompleteHandler:Function = function(event:StyleEvent):void {
				trace("loadStyle() Style File loaded! ");
				loadBarHide();
				loadResManager();
	 		}
	 		
			var eventDispatcher:IEventDispatcher = StyleManager.loadStyleDeclarations(this.config.styleFileSwfName + "?r=" + ver);
			eventDispatcher.addEventListener(StyleEvent.COMPLETE, cssLoadcompleteHandler);
			eventDispatcher.addEventListener(StyleEvent.PROGRESS , loadingProgressBar);
	 	}
	 	
		private function loadResManager():void {
			trace("Load ResManager:" +" "+config.resManagerSwfName);
			this.loadingSprite.beginLoad("ResManager file");
	
			function readyHandler(event:ResourceEvent):void {
				trace("loadResManager() ResManager loaded! ");
				loadBarHide();
				allDone();
			}
			
			var eventDispatcher:IEventDispatcher = ResourceManager.getInstance().loadResourceModule(config.resManagerSwfName + "?r=" + ver);
			eventDispatcher.addEventListener(ResourceEvent.COMPLETE, readyHandler);
			eventDispatcher.addEventListener(ResourceEvent.PROGRESS , loadingProgressBar);
		}
		
		private function loadLang():void {
			trace("Load lang:" + config.langSwfName);
			this.loadingSprite.beginLoad("Lang file");
			
			function readyHandler(event:ResourceEvent):void {
				trace("Lang loaded! ");
				loadBarHide();
//				allDone();
				loadStyle();
			}
			
			var swfName:String = config.langSwfName + "?r=" + ver;

			var eventDispatcher:IEventDispatcher = ResourceManager.getInstance().loadResourceModule(swfName);
			eventDispatcher.addEventListener(ResourceEvent.COMPLETE, readyHandler);
			eventDispatcher.addEventListener(ResourceEvent.PROGRESS , loadingProgressBar);
		}
	
		private function allDone():void {
			trace("all Done");
			this.loadingSprite.setProgressEvent(null);
			ResourceManager.getInstance().update();
			dispatchEvent(new Event(Event.COMPLETE));
			EvtDispacther.sendEvent(EvtDispacther.ALL_MODULE_LOADED ); 
		}
	}		
}