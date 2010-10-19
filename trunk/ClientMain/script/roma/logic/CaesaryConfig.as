package roma.logic
{
	import flash.display.LoaderInfo;
	
	import mx.collections.ArrayCollection;
	
	[Bindable]
	public class CaesaryConfig 
	{
		public static var instance:CaesaryConfig = new CaesaryConfig();
		
		public var isDebug:Boolean = false; 
		public var serverIp:String = "192.168.1.4";
		public var serverPort:int = 443;
		public var version:String = "1.0";
		public var clientVer:String = "1.002";
		
		public var firstTimeLogin:Boolean = false;
		
		/** 游戏需要加载的swf文件 */
		public var styleFileSwfName:String;
		public var resManagerSwfName:String;
		public var langSwfName:String;
		public var imageResSwfName:String;
		public var loginBgSwfName:String;
		
		/** 游戏设置 */
		public var isShowBuildingLevel:Boolean = true;
		public var showBuffStatus:Boolean = true;
		public var showBuildingStatus:Boolean = true;
		public var showArmyAction:Boolean = false;
		public var showSetStatus:Boolean = false;
		public var showArmyTip:Boolean = false;
		public var isCreatingSeat:Boolean=false;
		public var isFullScreen:Boolean=false;
		public var isPlaySound:Boolean=true;
		
		public var nameLimit:int=12;

		/** 自动登录  参数来时flashvars*/
		public var accountName:String = null;
		public var authToken:String = null;
		public var isAutoLogin:Boolean = false;//是否自动登录,根据上面几个参数，如果不为空就表示可以 
		public var defaultPlayerName:String = null;
		
		/** 各类URL 在config.xml中配置*/
		private var reChargeUrl:String;//充值
		public var registerUrl:String;//注册
		public var noteUrl:String;//公告
		public var forumUrl:String ="";//论坛
		
		public var isEnVersion:Boolean=true;//是否是英文版本
		
		/** 战斗回放  在config.xml中配置*/
		public var battleUrl:String;
		public var battleDataUrl:String;
		public var bugReportUrl:String;

		/** 自动登录基础配置  在config.xml中配置*/
		public var isShowLogin:Boolean = true;//是否显示登录界面
		public var loginUrl:String = null;//登录页url
		
		/** 游戏的特定设置 */ 
		public var isGuide:Boolean = false;
		public var isRoll:Boolean = false;
		public var levelBtnShow:Boolean = false;
		public var isClickToBuy:Boolean = false;
		public var isClickToTurn:Boolean = false;
		public var bugBtnShow:Boolean = true;
		
		/** 我的物品是否有新增物品 */ 
		public var haveNewTreasure:Boolean = false;
		public var haveNewSpeedup:Boolean = false;
		public var haveNewProduce:Boolean = false;
		public var haveNewChest:Boolean = false;
		public var haveNewLuxury:Boolean = false;
		
		//是否有自定义的npc城
		public var havePersonNpc:Boolean=false;
		public var personNpcCastleArr:ArrayCollection=new ArrayCollection();
		
		//额外的论坛链接
		public var showLeGuBtn:Boolean=false;
		public var showBaHaBtn:Boolean=false;
		public var leGuUrl:String;
		public var baHaUrl:String;
		public var failForumUrl:String;
		
		public var userJsFuncRecharge:Boolean = false;
		
		public var bugMailId:String;//bug邮件报告方的ID
		
		public function config(xml:XML):void {
			trace("CaesaryConfig.config() xml=" + xml)
			this.isDebug = ("true" == xml.debugMode);
			this.serverPort = xml.port;
			this.version = xml.version;
			if (xml.clientVer) {
				this.clientVer = xml.clientVer;
			}
			
			//loading
			this.styleFileSwfName = xml.loading.styleFile;
			this.resManagerSwfName = xml.loading.resManager;
			this.langSwfName=xml.loading.lang;
			this.imageResSwfName = xml.loading.imageRes;
			this.loginBgSwfName = xml.loading.loginBg;
			
			//url
			this.reChargeUrl = xml.url.reChargeUrl;
			this.registerUrl=xml.url.registerUrl;
			this.noteUrl = xml.url.noteUrl;
			this.forumUrl = xml.url.forumUrl;
			this.bugReportUrl = xml.url.bugReportUrl;

			//battleReplay
			this.battleUrl = xml.battleReplay.battleUrl;
			this.battleDataUrl = xml.battleReplay.battleDataUrl;
			
			//额外的论坛地址
			this.showLeGuBtn=(xml.forum.showLeGuForum==true);
			this.showBaHaBtn=(xml.forum.showBaHaForum==true);
			this.leGuUrl=xml.forum.leGuForumUrl;
			this.baHaUrl=xml.forum.baHaForumUrl;
			this.failForumUrl=xml.forum.failForumUrl;
			
			
			//autoLogin
			this.loginUrl = xml.autoLogin.loginUrl;
			this.isShowLogin = ("true" == xml.autoLogin.showLogin) || this.loginUrl==null || this.loginUrl.length==0;
			
			this.isGuide = (xml.specificSet.isGuide != "false");
			this.isRoll = (xml.specificSet.isRoll != "false");
			this.levelBtnShow = (xml.specificSet.levelBtnShow==true);
			this.bugBtnShow = (xml.specificSet.bugBtnShow==true);
			this.isEnVersion=(xml.specificSet.isEnVersion==true);

			this.userJsFuncRecharge = (xml.specificSet.userJsFuncRecharge == true); 
			
			this.bugMailId = xml.bugMailId;
			
			if(xml.hasOwnProperty("ncpCastle")){
				if(xml.ncpCastle.hasOwnProperty("ncpAdd")){
					 var npcAdd:XML;
					this.havePersonNpc=true;
					for each(npcAdd in xml.ncpCastle.child("ncpAdd")){
						personNpcCastleArr.addItem(npcAdd.toString());
					}	
				}
			}
		}
		
		public function getRechargeUrl(accountName:String):String {
			if (this.reChargeUrl==null) {
				this.reChargeUrl = "";
			} 
			var res:String = this.reChargeUrl;
			if (this.reChargeUrl.indexOf("?")>0) {
				res += "&";
			} else {
				res += "?";
			}
			res += "accountName=" + escape(accountName);
			return res;
		}
		
		public function configFromFlashvars(loaderInfo:LoaderInfo):void {
			//自动登录部分
			this.accountName = loaderInfo.parameters["accountName"];
			this.authToken = loaderInfo.parameters["authToken"];
			this.isAutoLogin = (this.authToken!=null && this.authToken.length>0);
			if (this.isAutoLogin) {
				trace("autoLogin accountName=" + this.accountName + "\t=authToken" + this.authToken);
			}
			
			if (loaderInfo.parameters["ip"]) {
				this.serverIp = loaderInfo.parameters["ip"];
			}
			if (loaderInfo.parameters["reChargeUrl"]) {
				this.reChargeUrl = loaderInfo.parameters["reChargeUrl"]
			} 			
			if (loaderInfo.parameters["registerUrl"]) {
				this.registerUrl = loaderInfo.parameters["registerUrl"]
			} 			
			if (loaderInfo.parameters["noteUrl"]) {
				this.noteUrl = loaderInfo.parameters["noteUrl"]
			} 			
			if (loaderInfo.parameters["forumUrl"]) {
				this.forumUrl = loaderInfo.parameters["forumUrl"]
			} 			
			if (loaderInfo.parameters["bugReportUrl"]) {
				this.bugReportUrl = loaderInfo.parameters["bugReportUrl"]
			} 			
			if (loaderInfo.parameters["serverPort"]) {
				this.serverPort = loaderInfo.parameters["serverPort"]
			}
			if (loaderInfo.parameters["defaultPlayerName"]) {
				this.defaultPlayerName = loaderInfo.parameters["defaultPlayerName"]
			}
		}
		
	}
}