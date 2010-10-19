package framework.socket
{
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.Socket;
	import flash.utils.ByteArray;
	
	import framework.game.MouseCursorManager;
	
	import mx.logging.ILogger;
	import mx.logging.Log;
	
	import roma.common.action.ControllerFactory;

	public class CaesaryClient extends EventDispatcher
	{
		
		public static const ON_CONNECTION:String = "gameClient.连通";
		public static const ON_CONNECTION_LOST:String = "gameClient.断线";
		public static const ON_EXTENSION_RESPONSE:String ="gameClient.收到数据";
		public static const ON_ERROR:String = "gameClient.网络错误";
		public static const ON_ERROR_VERSION:String = "gameClient.版本错误";
		public static const ON_SYSTEM_BUSY:String = "gameClient.系统繁忙"

		private static var log:ILogger = Log.getLogger("framework.socket.GameClient");

		private var _socket:Socket = null;
		
		private var _serverIp:String;
		private var _serverPort:int;
		private var _version:String = null;
		
		private var _dataReceiver:DataReceiver;
		
		private var _versionChecked:Boolean = false;
		
		public function CaesaryClient()
		{
			_socket = new Socket();
			_socket.addEventListener(Event.CONNECT, onConnectHandler);
			_socket.addEventListener(Event.CLOSE, onDisconnectHandler);
			_socket.addEventListener(ProgressEvent.SOCKET_DATA, inReceiveDataHandler);
			_socket.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
			_socket.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);

			_dataReceiver = new DataReceiver(this);
		}
		
		public function isConnected():Boolean
		{
			return _socket.connected;
		}

		public function setVersion(v:String):void
		{
			_version = v;
		}
		
		public function sendMessage(cmdCode:int, data:Object):void
		{
			if (!isConnected()) {
				this.dispatchEvent(new Event(ON_CONNECTION_LOST));
				return;
			}
			
			var obj:Object = new Object();
			obj.cmd = cmdCode;
			obj.data = data;
			

			var byte:ByteArray = new ByteArray();
			byte.writeObject(obj);
			_socket.writeInt(byte.length);
			_socket.writeBytes(byte);
			_socket.flush();

			MouseCursorManager.setBusy();
			trace("GameClient sendMesage cmdCode=" + cmdCode + " param=" + data);
		}
		
		public function disConnect():void
		{
			log.debug("disConnection()");
			try {
				_socket.close();
			} catch (e:Error) {
				log.debug(e.message);
			}
		}
		
		/**
		 * 建立连接，连接后交给connectionHandler处理
		 */
		public function connect(ip:String, port:int):void
		{
			if (!_version) {
				throw new VersionError(
					"CaesaryClient required a version.");
			}

			log.debug("connection() connect to server(" + ip + ":" + port);
			
			if (!isConnected()) {
				_socket.connect(ip,port);
			}
		}

		private function onConnectHandler(evt:Event):void
		{
			log.debug("onConnectHandler()")
			var v:String = _version + "_" + ControllerFactory.getInstance().getTotalEvents();
			trace("客户端版本:" + v);
			sendMessage(FWConstants.CMD_VERSION, v);
		}

		
		/**
		 * 当socket服务器有数据到来的时候将会触发该事件处理器
		 * @param e ProgressEvent
		 */
		private function inReceiveDataHandler(evt:ProgressEvent):void {
			trace("GameClient incomingDataHandler socket.bytesAvailable=" + _socket.bytesAvailable);
			_dataReceiver.receiveData(_socket);
		}
		
		internal function processPackage(obj:Object):void {
			var cmdCode:int = obj.cmd;
			if (cmdCode<0) {
				switch (cmdCode)
				{
					case FWConstants.CMD_VERSION: //版本校验完成, 抛连接成功事件
						log.debug("processPackage(): version checked,connect success");
						dispatchEvent(new Event(ON_CONNECTION));
						break;
					case FWConstants.CMD_ERR_VERSION: // is error verion
						log.debug("processPackage(): error version");
						dispatchEvent(new Event(ON_ERROR_VERSION));
						disConnect(); // disconnection the socket.
						break;
				}
			} else {
				log.debug("dispatch Event:" + cmdCode);
				dispatchEvent(new CaesaryClientEvent(obj));
			}
		}
		
		private function onDisconnectHandler(evt:Event):void
		{
			log.debug("onDisconnectHandler(): socket connection was disconnect");
			dispatchEvent(new Event(ON_CONNECTION_LOST));
		}
		
		private function ioErrorHandler(evt:IOErrorEvent):void
		{
			log.debug("ioErrorHandler(): the network connection has IOError : " + evt.text);
			dispatchEvent(new Event(ON_ERROR));
		}
		
		private function securityErrorHandler(evt:SecurityErrorEvent):void
		{
			dispatchEvent(new Event(ON_ERROR));
		}
	}
}