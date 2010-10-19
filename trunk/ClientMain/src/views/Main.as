package views
{
	import flash.events.Event;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	
	import framework.socket.CaesaryClient;
	
	import mx.containers.Canvas;
	import mx.logging.ILogger;
	import mx.logging.Log;
	
	import roma.RomaMain;
	import roma.common.ResponseEvtDispatcher;
	import roma.common.controller.user.EnterResponse;
	import roma.common.events.ConnectLostEvent;
	import roma.logic.CaesaryConfig;
	import roma.message.EvtDispacther;
	import roma.util.JavaScriptHelper;
	import roma.util.MultiLang;
	
	import views.spreadUI.MyAlert;

	public class Main extends Canvas
	{
		private static var log:ILogger = Log.getLogger("view.Main");
		
		public static var instance:Main = new Main();
		
		private var loginFrame:Logform = new Logform();
		private var msgDispatcher:EvtDispacther = EvtDispacther.instance;
		
		private var loginFrameAdded:Boolean = false;
		
		private var connectLostCode:int = 9999; 
		
		public function Main() {
			super();
		}

		public function init():void {
			log.debug("init()"); 
			JavaScriptHelper.instance.onEnterGame();
			
			ResponseEvtDispatcher.getInstance().onConnectLostEvent = onConnectLostResultEventHandle;
			
			this.initConnectEventListener();
			
			if (CaesaryConfig.instance.isAutoLogin) {
				PleaseWaitUC.instance.show();
				RomaMain.instance.doAutoLogin();
			} else {
				if (CaesaryConfig.instance.isShowLogin ) {
					this.loginFrameAdded = true;
					this.addChild(this.loginFrame);
				} else {
					MyAlert.show(MultiLang.msg("msg.loginFromPortal"), onLoginFromPortalClick , "default" , null);
				}
			}
		}
		
		private function onLoginFromPortalClick(ok:Boolean):void {
			navigateToURL(new URLRequest(CaesaryConfig.instance.loginUrl),"_top");
		}
	
		private function onConnectLostResultEventHandle(event:ConnectLostEvent):void {
			this.connectLostCode = event.code;
		}
	
		public	function onLoginFail(loginEvent:EnterResponse):void {
			PleaseWaitUC.instance.hide();

			if (CaesaryConfig.instance.isShowLogin ) {
				//如果需要显示登录界面
				if (!loginFrameAdded) {
					addChild(loginFrame);
				}
				MyAlert.showError(loginEvent);
				JavaScriptHelper.instance.trackEvent("connect","Login",loginEvent.errorMsg,0);
			}else if(loginEvent.errorMsg=="LoginRefusedException"){
					MyAlert.show(MultiLang.msg("msg.beFreezed"), onLoginFromPortalClick , "default" , null);
			} else {
				MyAlert.show(MultiLang.msg("msg.loginFromPortal"), onLoginFromPortalClick , "default" , null);
			}
		}
		
		public function removeLoginFrame():void {
			if (this.loginFrameAdded) {
				this.loginFrame.visible = false;
				this.loginFrame.destroy();
				this.removeChild(this.loginFrame);
			}
		}

		public function switchMainFrame():void {
			var mainFrame:MainContainer = new MainContainer();
			mainFrame.refresh();
			this.addChild(mainFrame);
		}

		/**
		 * 处理 断线,可能是系统重启、系统维护、被踢
		 */
		private function onConnectLostHandler(event:Event):void {
			var msg:String;
			switch (this.connectLostCode) {
				case ConnectLostEvent.KICK_OUT_BY_OTHER_LOGIN:
					msg = MultiLang.msg("msg.connect.kickout");
					JavaScriptHelper.instance.trackEvent("connect","Connect","Kickout",0);
					break;
				case ConnectLostEvent.SERVER_MAINTAIN:
				case ConnectLostEvent.SERVER_SHUTDOWN:
					msg = MultiLang.msg("msg.connect.serverMaintain");
					break;
				default:
					msg = MultiLang.msg("msg.connect.disconnect");
					break;
			}
			MyAlert.show(msg, refreshBrowser , "default" , null);
		}

		/**
		 * 初始化网络连接监听器
		 */
		private function initConnectEventListener():void {
			//处理 断线
			this.msgDispatcher.addEventListener(CaesaryClient.ON_CONNECTION_LOST,onConnectLostHandler);

			//处理连接不上
			var onConnectFailHandler:Function = function(event:Event):void {
				MyAlert.show(MultiLang.msg("msg.connect.fail"));
				JavaScriptHelper.instance.trackEvent("connect","Connect","ConntecFail",0);
			}
			this.msgDispatcher.addEventListener(CaesaryClient.ON_ERROR,onConnectFailHandler);

			//处理版本错误
			var onErrorVersionHandler:Function = function(event:Event):void {
				MyAlert.show(MultiLang.msg("msg.connect.errorVersion"),refreshBrowser , "default" , null);
				JavaScriptHelper.instance.trackEvent("connect","Connect","ErrorVersion",0);
			}
			this.msgDispatcher.addEventListener(CaesaryClient.ON_ERROR_VERSION,onErrorVersionHandler);
			
			//处理系统繁忙
			var onSystemBusyHandler:Function = function(event:Event):void {
				MyAlert.show(MultiLang.msg("msg.connect.systemBusy"));
				JavaScriptHelper.instance.trackEvent("connect","Connect","SystemBusy",0);
			}
			this.msgDispatcher.addEventListener(CaesaryClient.ON_SYSTEM_BUSY,onSystemBusyHandler);
			
		}
		
		private function refreshBrowser(ok:Boolean):void {
			if (CaesaryConfig.instance.isShowLogin) {
				JavaScriptHelper.instance.refreshBrowser();
			} else {
				onLoginFromPortalClick(true);
			}
		}
	}
}