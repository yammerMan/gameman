package {
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageQuality;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	
	import roma.war.WareplayerSettings;
	import roma.war.controler.WarPlayer;
	import roma.war.data.ReportManager;
	import roma.war.render.RenderOfWars;
	import roma.war.resource.MultiLang;
	import roma.war.resource.ResourceEvent;
	import roma.war.resource.ResourceLoader;
	import roma.war.ui.MainSkin;


	[Frame(factoryClass="roma.loader.MyLoader")]
	public class wareplay extends MovieClip
	{
		//paths
		public var report:String;
		public var langueStr:String;
		public var path:String;
		//resource loader
		public var rl:ResourceLoader;
		public var autoPlaySettings:String;//[""(normal),"false","true"]
		
		//prime
		public var render:RenderOfWars;
		public var player:WarPlayer;
		public var skin:MainSkin;
		
		public function wareplay()
		{
			super();
			
			if(this.stage){
				init();
			}else{
				addEventListener(Event.ADDED_TO_STAGE,init);
			}
		}
		
		private function init(event:Event = null):void{
            this.stage.scaleMode = StageScaleMode.SHOW_ALL;
            this.stage.quality = StageQuality.BEST;
            this.stage.align = StageAlign.TOP;
			removeEventListener(Event.ADDED_TO_STAGE,init);
			parseAndStart(this.loaderInfo.parameters);
		}
		
		public function dispose():void{
			 if(rl){
			 	rl.removeEventListener(ResourceEvent.SETTINGS_COMPLETE,settingsCompleteHandler);
				rl.removeEventListener(ResourceEvent.REPORT_COMPLETE,reportComplete);
				rl.removeEventListener(ResourceEvent.EMBED_COMPLETE,resourceComplete);
				rl.dispose();
				rl = null;
			 }
			 if(player){
			 	player.dispose();
			 	player = null;
			 }
			 if(skin&&skin.parent){
			 	Sprite(skin.parent).removeChild(skin);
			 	skin = null;
			 }
			 
			 //reset
			 autoPlaySettings = "";
			 path = "wareplay_setting.xml";
			 report = "2.xml";
		}
		
		/** 
		 * make player 创造播放器
		 **/
		protected function makePlayer():void{
			skin = new ui_mc() as MainSkin;
			addChild(skin);
			
			player = new WarPlayer(WareplayerSettings.instance.fps);
			player.skin = skin;
			player.roundTimes = WareplayerSettings.instance.roundTimes;
			player.rapid = WareplayerSettings.instance.rapid;
			player.initClass();
			
			//自动播放
			if(autoPlaySettings.length > 0){
				if(autoPlaySettings == "true") player.play();
			}else{
				if(WareplayerSettings.instance.autoPlay == true) player.play();
			}
			
		}
		
		public function parseAndStart(params:Object):void{
			dispose();
			trace("parseAndStart ---------------------- " );
			//creat settings object
//			report = "http://67.228.22.155/report//a4/71/a400f03fe041072b71b3e8c7580ee496.xml";
			if(params.u){
				report = "http://"+params.u;
			}
			if(params.l){
				langueStr = params.l;
			}
			trace("report : "+report+" , "+"path : "+path);
			//loading settings
			loadSettings();
		}
		
		private function loadSettings():void{
			rl = new ResourceLoader();
			rl.totalSize = this.loaderInfo.bytesTotal;
			rl.addEventListener(ResourceEvent.SETTINGS_COMPLETE,settingsCompleteHandler);
			rl.loadSettings(path);
		}
		private function settingsCompleteHandler(event:ResourceEvent):void{
			trace("wareplay.settingsCompleteHandler ------- ");
			rl.removeEventListener(ResourceEvent.SETTINGS_COMPLETE,settingsCompleteHandler);
			rl.dispose();
			WareplayerSettings.instance.parseXMLString(event.value);
			WareplayerSettings.instance.setLanguege(langueStr);
			loadLang();
		}
		
		/**
		 * 语言加载
		 */ 
		private function loadLang():void{
			if(langueStr == "en")
				MultiLang.instance.setCurLang(new LangEn());
			else if(langueStr == "cn")
				MultiLang.instance.setCurLang(new LangCn());
			else if(langueStr == "big5")
				MultiLang.instance.setCurLang(new LangBig5());
			else if(langueStr == "ko")
				MultiLang.instance.setCurLang(new LangKo());
			else if(langueStr == "de"){
				MultiLang.instance.setCurLang(new LangDe());
			}else if(langueStr == "pt"){
				MultiLang.instance.setCurLang(new LangPt());
			}else if(langueStr == "tr"){
				MultiLang.instance.setCurLang(new LangTr());
			}
			else
				MultiLang.instance.setCurLang(new LangEn());
			loadReport();
		}
		
		private function loadReport():void{
			rl.dispose();
			rl.addEventListener(ResourceEvent.REPORT_COMPLETE,reportComplete);
			rl.loadReportResource(report);
		}
		private function reportComplete(event:ResourceEvent):void{
			trace("wareplay.reportComplete --------- ");
			rl.removeEventListener(ResourceEvent.REPORT_COMPLETE,reportComplete);
			rl.dispose();
			if(event.value){
				trace("create warDate ");
				/**		由处理器生成一份战报的解析数据	**/
				//wd = ReportHandler.ReportCheckToWarAction(event.value.toString());
				ReportManager.instance.setBattleType(event.value.toString());
				loadResource();
				
			}else{
				trace(this,"resport null");
			}
		}

		
		private function loadResource():void{
			rl.dispose();
			rl.addEventListener(ResourceEvent.EMBED_COMPLETE,resourceComplete);
			rl.loadEmbedResource();
		}
		
		private function resourceComplete(event:ResourceEvent):void{
			trace('resourceComplete ---------- ');
			rl.removeEventListener(ResourceEvent.EMBED_COMPLETE,resourceComplete);
			rl.dispose();
			
			trace('now all resource complete ')
			makePlayer();
		} 
		
	}
}
