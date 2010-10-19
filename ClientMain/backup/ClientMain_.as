
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.events.IEventDispatcher;
	
	import mx.events.ModuleEvent;
	import mx.events.ResourceEvent;
	import mx.events.StyleEvent;
	import mx.logging.LogEventLevel;
	import mx.modules.ModuleLoader;
	import mx.resources.ResourceManager;
	import mx.styles.StyleManager;
	
	import roma.logic.CaesaryConfig;
	import roma.util.ClientUtil;
	import roma.util.MyModuleLoader;

	[Bindable]
	private var fileName:String = "";
	[Bindable]
	private var debugTxt:String ="";
	[Bindable]
	private var noteStr:String;
	[Bindable]
	private var decimalFraction:String;//下载进度小数点部分
	[Bindable]
	private var	wholeNumber:String;//下载进度整数部分
	[Bindable]
	private var white3Filter:GlowFilter =new GlowFilter(0xffffff, 1, 3, 3, 100, 1, false, false);

	private var config:CaesaryConfig = CaesaryConfig.instance;
	private var progressBar:MovieClip;			

	private function init():void {
		ClientUtil.initLogger("framework.*",LogEventLevel.ALL);
		ClientUtil.initLogger("roma.*",LogEventLevel.ALL);
		ClientUtil.initLogger("views.*",LogEventLevel.ALL);

		this.addMovieClip();
		this.loadConfig();
		this.loadNoticeTxt();
	}
	
	private function loadNoticeTxt():void{
		var r:Number = new Date().valueOf();
		ClientUtil.loadFile("Bulletin.txt?r="+r , noteLoaded);
		function noteLoaded(str:String):void {
			noteStr = str;
		}
	}

 	private function addMovieClip():void{
		[Embed(source="fla/LoadingProgress.swf",symbol = "preLoadingBg")]				
		var GameLogoC:Class;
		var mc:MovieClip = new GameLogoC() as MovieClip;
		mc.gotoAndStop(2);
		logoContainer.addChild(mc);

		[Embed(source="fla/LoadingProgress.swf",symbol = "SmallProgressBg")]
		var SmallProgressBgC:Class;
		var mc2:MovieClip = new  SmallProgressBgC() as MovieClip;
		mc2.x =0;
		mc2.y = 0;
		mc2.gotoAndStop(2);
		loadingProgressMc.addChild(mc2);
		
		[Embed(source="fla/LoadingProgress.swf",symbol = "ProgressBar")]
		var ProgressBarC:Class
		progressBar = new ProgressBarC as MovieClip;
		progressBar.x =8;
		progressBar.y = 3;
		progressBar.gotoAndStop(2);
		loadingProgressMc.addChild(progressBar);
 	}

 	private function loadConfig():void {
 		var setupConfig:Function = function (object:Object):void {
 			trace("LoadConfig() config.xml loaded!");
			config.config(XML(object));
			loadLang();
 		}
 		
 		var loadFildError:Function = function(url:String):void {
			throw new Error("unable load " + url);
		}
 		
		this.fileName = "Loading Config";
		ClientUtil.loadFile("config.xml?ver="+new Date().valueOf() , setupConfig , loadFildError);
 	}

	private function loadBarHide():void{
		progressBar.visible = false;
	}			

	private function loadingProgressBar(e:ProgressEvent):void{
		debugTxt = e.bytesLoaded + "/" + e.bytesTotal;
		var percent:Number=Math.round(e.bytesLoaded / e.bytesTotal * 260);
		progressBar.visible = true;
		progressBar.width = percent;
		this.loadingPercentHandle(e.bytesLoaded , e.bytesTotal);
	} 
	
	private function loadingPercentHandle(bytesLoaded:Number,bytesTotal:Number):void{
		var percent:Number=Math.round(bytesLoaded /bytesTotal * 10000);
		this.wholeNumber=String(percent).slice(0,2);
		if(int(String(percent).slice(2,4))>0){
			this.decimalFraction="."+String(percent).slice(2,4)+"%";
		}else{
			this.decimalFraction="%";
		}
	}

 	private function loadStyle():void {
		this.fileName = "Loading Style File";
 		var cssLoadcompleteHandler:Function = function(event:StyleEvent):void {
			trace("loadStyle() Style File loaded! ");
			loadBarHide();
			loadResManager();
 		}
 		
		var eventDispatcher:IEventDispatcher = StyleManager.loadStyleDeclarations(this.config.styleFileSwfName);
		eventDispatcher.addEventListener(StyleEvent.COMPLETE, cssLoadcompleteHandler);
		eventDispatcher.addEventListener(ModuleEvent.PROGRESS , loadingProgressBar);
 	}
 	
	private function loadResManager():void {
		this.fileName = "Loading Resource File";
		trace("Load ResManager:" + config.resManagerSwfName);

		function readyHandler(event:ResourceEvent):void {
			trace("loadResManager() ResManager loaded! ");
			loadBarHide();
			loadMainModule();
		}
		
		var eventDispatcher:IEventDispatcher = ResourceManager.getInstance().loadResourceModule(config.resManagerSwfName);
		eventDispatcher.addEventListener(ResourceEvent.COMPLETE, readyHandler);
		eventDispatcher.addEventListener(ResourceEvent.PROGRESS , loadingProgressBar);
	}
	
	private function loadLang():void {
		this.fileName = "Loading Language File";
		trace("Load lang:" + config.langSwfName);

		function readyHandler(event:ResourceEvent):void {
			trace("Lang loaded! ");
			loadBarHide();
			loadStyle();
		}
		
		var eventDispatcher:IEventDispatcher = ResourceManager.getInstance().loadResourceModule(config.langSwfName);
		eventDispatcher.addEventListener(ResourceEvent.COMPLETE, readyHandler);
		eventDispatcher.addEventListener(ResourceEvent.PROGRESS , loadingProgressBar);
	}

	private function loadMainModule():void {
		this.fileName = "Loading MainModule";
		trace("Load MainModule" + config.mainModuleSwfName);

		var myLoader:ModuleLoader = new ModuleLoader();
		this.addChild(myLoader);
		
		myLoader.addEventListener(ModuleEvent.READY, readyHandler,false,0,true);
		myLoader.addEventListener(ModuleEvent.PROGRESS , loadingProgressBar);
		myLoader.loadModule(config.mainModuleSwfName);
		
		function readyHandler(event:ModuleEvent):void {
			trace("MainModule loaded! ");
			loadBarHide();
			addDone();
		}
	}
	
	private function addDone():void {
		this.resourceManager.update();
		this.removeChild(loadingContainer);
	}
	