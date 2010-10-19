/**
* 生成时间 1 
*/
package roma.common.events
{
	import framework.game.BaseResponse;
	import roma.common.valueObject.*;
	import mx.collections.ArrayCollection;
	import framework.util.CopyAryUtil;
	import flash.utils.ByteArray;
	
	public class ConnectLostEvent extends BaseResponse
	{
		public function ConnectLostEvent(type:String, data:Object,bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.setResponseData(data);
				if (data.code!=null) {
					this.code = data.code;
				}
		}

		public static const SERVER_SHUTDOWN:int = 0;
		public static const SERVER_MAINTAIN:int = 1;
		public static const KICK_OUT_BY_SERVER:int = 2;
		public static const KICK_OUT_BY_OTHER_LOGIN:int = 3;

		public var code:int;

		public function copyToBe(target:ConnectLostEvent):void {
			target.code = this.code 
		}
		
		public function toBeObject():Object {
			var obj:Object = new Object();
			obj.code = this.code;
			return obj;
		}

		public override function toBeString(pre:String=""):String {
			var str:String = "---- ConnectLostEvent ----\n"  + this.toBeErrorString();
			str += pre + "code = " + this.code + "\n" ;

			return str;  
		}
	}
}