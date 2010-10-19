package roma
{
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import framework.game.MouseCursorManager;
	import framework.socket.CaesaryClient;
	import framework.socket.CaesaryClientEvent;
	
	import mx.logging.ILogger;
	import mx.logging.Log;
	
	import roma.common.ResponseEvtDispatcher;
	import roma.common.action.ControllerFactory;
	import roma.common.controller.user.EnterResponse;
	import roma.logic.CaesaryConfig;
	import roma.logic.GameContext;
	import roma.message.EvtDispacther;
	
	import views.Main;
	import views.PleaseWaitUC;
	
	/**
	 * 游戏主程序
	 */
	public class RomaMain
	{
		private static var log:ILogger = Log.getLogger("roma.RomaMain");

		public static var instance:RomaMain = new RomaMain();
		

		private var client:CaesaryClient;

		public var ip:String = CaesaryConfig.instance.serverIp;
		public var username:String = "";
		public var password:String = "";
		
		private var config:CaesaryConfig = CaesaryConfig.instance;
		private var actionFactory:ControllerFactory = ControllerFactory.getInstance();
		private var context:GameContext = GameContext.instance;

		private var isAutoLogin:Boolean = false;//是否是自动登录

		public function RomaMain(){
			log.info("newInstance");
			client = new CaesaryClient();
			actionFactory.client = client;
	
			var onGameClientEventHandle:Function = function (event:Event):void {
				PleaseWaitUC.instance.hide();
				MouseCursorManager.setNormal();
				EvtDispacther.instance.dispatchEvent(event);
			}
	
			//监听版本错误
			client.addEventListener(CaesaryClient.ON_ERROR_VERSION, onGameClientEventHandle);
			//监听网络出错
			client.addEventListener(CaesaryClient.ON_ERROR , onGameClientEventHandle);
			//监听断线
			client.addEventListener(CaesaryClient.ON_CONNECTION_LOST, onGameClientEventHandle);
			//系统繁忙
			client.addEventListener(CaesaryClient.ON_SYSTEM_BUSY , onGameClientEventHandle);
			
			
			//监听socket收到数据
			client.addEventListener(CaesaryClient.ON_EXTENSION_RESPONSE , onSocketResponseHandle);
			function onSocketResponseHandle(evt:CaesaryClientEvent):void{
			    ResponseEvtDispatcher.getInstance().dispatch(evt.cmdCode,evt.data);
			}

			//监听连接成功, 成功是发送登录指令
			client.addEventListener(CaesaryClient.ON_CONNECTION , onConnection);
			function onConnection(evt:Event):void {
				sendLoginCmd();
			}
		}
		
		/**
		 * 发送登录指令
		 */
		private function sendLoginCmd():void {
			if (this.isAutoLogin) {
				this.actionFactory.getUserController().autoLogin(CaesaryConfig.instance.accountName,CaesaryConfig.instance.defaultPlayerName,
					CaesaryConfig.instance.authToken , onEnterResponseHandle);
			} else {
				this.actionFactory.getUserController().login(this.username, null, this.password,onEnterResponseHandle);
			}
		}

		private function onEnterResponseHandle(event:EnterResponse):void {
			if (event.isSuccess()) {
				//如果登录成功，根据服务器端的数据初始化内部对象
				
		        var timer:Timer = new Timer(50);
		        var timerHandler:Function = function(e:TimerEvent):void {
		            timer.removeEventListener(TimerEvent.TIMER, timerHandler);
		            timer.stop();
		            context.getPlayerObj().init(event.player);
		            CaesaryConfig.instance.firstTimeLogin = event.firstTimeLogin;
		            Main.instance.switchMainFrame();
		        };
		        
		        timer.addEventListener(TimerEvent.TIMER, timerHandler, false, 0, true);
		        timer.start();
			} else {
	            Main.instance.onLoginFail(event);
			}
		}

		public function doAutoLogin():void {
			log.debug("auto login");
			this.isAutoLogin = true;
			this.clientConnect();
		}
		
		/**
		 * 连接服务器，并登录
		 */
		private function clientConnect():void {
			client.setVersion(CaesaryConfig.instance.version);
			MouseCursorManager.setBusy();

			if (this.client.isConnected()) {
				this.sendLoginCmd();
			} else {
				log.info("doLogin(): ServerIP=" + this.ip);
				client.connect(this.ip , CaesaryConfig.instance.serverPort);
			}
		}
		
		/**
		 * 登录
		 */
		public function doLogin(u:String, p:String, i:String):void {
			log.debug("normal login");
			isAutoLogin = false;
			this.username = u;
			this.password = p;
			this.ip = i;
			CaesaryConfig.instance.serverIp = i;
			
			clientConnect();
			
		}
		
		public function createPlayer(playerName:String,logoUrl:String):void {
			var cityName:String = playerName;
			this.actionFactory.getUserController().createPlayer(playerName,cityName,logoUrl,onEnterResponseHandle);
		}
		
	}
}