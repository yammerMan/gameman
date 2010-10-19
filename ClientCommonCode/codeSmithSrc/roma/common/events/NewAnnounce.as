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
	
	public class NewAnnounce extends BaseResponse
	{
		public function NewAnnounce(type:String, data:Object,bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.setResponseData(data);
				if (data.announceStr!=null) {
					this.announceStr = data.announceStr;
				}
				if (data.msgType!=null) {
					this.msgType = data.msgType;
				}
		}

		public var announceStr:String;
		public var msgType:int;

		public function copyToBe(target:NewAnnounce):void {
			target.announceStr = this.announceStr 
			target.msgType = this.msgType 
		}
		
		public function toBeObject():Object {
			var obj:Object = new Object();
			obj.announceStr = this.announceStr;
			obj.msgType = this.msgType;
			return obj;
		}

		public override function toBeString(pre:String=""):String {
			var str:String = "---- NewAnnounce ----\n"  + this.toBeErrorString();
			str += pre + "announceStr = " + this.announceStr + "\n" ;
			str += pre + "msgType = " + this.msgType + "\n" ;

			return str;  
		}
	}
}