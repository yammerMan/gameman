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
	
	public class ChatMsg extends BaseResponse
	{
		public function ChatMsg(type:String, data:Object,bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.setResponseData(data);
				if (data.channel!=null) {
					this.channel = data.channel;
				}
				if (data.fromPlayer!=null) {
					this.fromPlayer = data.fromPlayer;
				}
				if (data.massage!=null) {
					this.massage = data.massage;
				}
				if (data.toPlayer!=null) {
					this.toPlayer = data.toPlayer;
				}
				if (data.gm!=null) {
					this.gm = data.gm;
				}
				if (data.selfWords!=null) {
					this.selfWords = data.selfWords;
				}
		}

		public var channel:int;
		public var fromPlayer:String;
		public var massage:String;
		public var toPlayer:String;
		public var gm:Boolean;
		public var selfWords:Boolean;

		public function copyToBe(target:ChatMsg):void {
			target.channel = this.channel 
			target.fromPlayer = this.fromPlayer 
			target.massage = this.massage 
			target.toPlayer = this.toPlayer 
			target.gm = this.gm 
			target.selfWords = this.selfWords 
		}
		
		public function toBeObject():Object {
			var obj:Object = new Object();
			obj.channel = this.channel;
			obj.fromPlayer = this.fromPlayer;
			obj.massage = this.massage;
			obj.toPlayer = this.toPlayer;
			obj.gm = this.gm;
			obj.selfWords = this.selfWords;
			return obj;
		}

		public override function toBeString(pre:String=""):String {
			var str:String = "---- ChatMsg ----\n"  + this.toBeErrorString();
			str += pre + "channel = " + this.channel + "\n" ;
			str += pre + "fromPlayer = " + this.fromPlayer + "\n" ;
			str += pre + "massage = " + this.massage + "\n" ;
			str += pre + "toPlayer = " + this.toPlayer + "\n" ;
			str += pre + "gm = " + this.gm + "\n" ;
			str += pre + "selfWords = " + this.selfWords + "\n" ;

			return str;  
		}
	}
}