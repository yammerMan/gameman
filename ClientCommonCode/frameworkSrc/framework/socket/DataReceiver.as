package framework.socket
{
	import flash.events.Event;
	import flash.net.Socket;
	import flash.utils.ByteArray;
	
	import mx.logging.ILogger;
	import mx.logging.Log;
	
	public class DataReceiver
	{
		private static const PACKAGE_MAX_LEN:int = 1048576;

		private var _client:CaesaryClient;
		private var _readed:int = 0;
		private var _lock:Boolean = false;
		private var _dataLen:int = 0;
		
		private var _processedCount:int;
		private var _mainBuffer:ByteArray;
		private var _amfObj:Object;

		private static var log:ILogger = Log.getLogger("framework.socket.DataReceiver");

		public function DataReceiver(gameClient:CaesaryClient)
		{
			_client = gameClient;
		}
		
		internal function receiveData(socket:Socket):void {
			
			if (_lock) {
				log.error("receive DataError. socket.bytesAvailable=" + socket.bytesAvailable 
					+ "\tprocessedCount=" + _processedCount 
					+ "\treaded=" + _readed 
					+ " dataLength:" + _dataLen);
				return;
			} else {
				_lock = true;
			}
			
			while (socket.connected && socket.bytesAvailable >0  ) {
				log.debug("incomingDataHandler(): incoming data length:" + socket.bytesAvailable);
				
				var tempLen:int = socket.bytesAvailable;
				
				if (_dataLen == 0) {
					if (tempLen<4) {
						//前4个字节应该是数据长度的，但实际运行时，可能会出现发这个包被分成了两次过了，而且第一次不足一个整形
						break;
					}
					_dataLen = socket.readInt();
					_readed = 0;
					if (_dataLen > PACKAGE_MAX_LEN || _dataLen <0) {
						throw new Error("receive DataError . len=" + _dataLen );
					} 
					_mainBuffer = new ByteArray();
					_processedCount = 0;
					log.debug("incomingDataHandler(): New package.incomingLen:" + socket.bytesAvailable + " dataLength:" + _dataLen );
				}
				
				var needToRead:int = _dataLen - _readed; //剩余要读的 
				if (needToRead > socket.bytesAvailable) {
					needToRead = socket.bytesAvailable;
				}
				
				if (needToRead < 0) {
					throw new Error("receive DataError .lenNeedToRead=" + needToRead + "\tremain=" + socket.bytesAvailable + "\tprocessedCount=" + _processedCount + "\treaded=" + _readed);
				}
				
				try {
					_readed += needToRead;
					var tempBufferByte:ByteArray = new ByteArray();
					socket.readBytes(tempBufferByte, 0, needToRead);
					_mainBuffer.writeBytes(tempBufferByte);
					_processedCount++;
				} catch (e:Error){
					_client.dispatchEvent(new Event(CaesaryClient.ON_ERROR));
				}
				log.debug("incomingDataHandler(): reading data. lenNeedToRead=" + needToRead + "\tremain=" + socket.bytesAvailable + "\tprocessedCount=" + _processedCount + "\treaded=" + _readed);
				
				if (_readed == _dataLen) {
					log.debug("incomingDataHandler(): object length: " + _readed);
//					mainBuffer.uncompress();//解压
					_mainBuffer.position = 0;
					_amfObj = _mainBuffer.readObject();
					_mainBuffer = null;
					_dataLen = 0;
					_processedCount = 0;
					_readed = 0;
					_lock = false;//估计可能是下面的dispatchEvent慢，所以导致该方法被重复进入，所以这里尝试改为，一但读取了一个完整包就，就允许重入了
					if (!_amfObj) // can not parse the remote object.
					{
						_client.dispatchEvent(new Event(CaesaryClient.ON_ERROR));
						_client.disConnect();
						return;
					}
					
					// check the response, if it is a special cmd. do somthing.
					_client.processPackage(_amfObj);
				}
			}
			_lock = false;
		}

	}
}