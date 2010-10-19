package framework.game
{
	import flash.events.Event;
	
	public class BaseResponse extends Event
	{
		public function BaseResponse(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}

		public var ok:int;
		public var errorMsg:String;
		public var errorParam:Array;
		public var errorParamLen:int = 0;
		
		public function setResponseData(data:Object):void {
			if (data._ok) {
				this.ok = data._ok;
			}
			if (data._errorMsg) {
				this.errorMsg = data._errorMsg;		
			}
			if (data._errParams) {
				this.errorParam = data._errParams
				this.errorParamLen = data._errParams.length;
			}
		}
		
		public function getErrorParam(index:int):String {
			if (this.errorParam!=null && index<this.errorParam.length) {
				return String(this.errorParam[index]);
			} else {
				return null;
			}
		}
		
		public function isSuccess():Boolean {
			return (ok == 1);
		}
		
		public function isInvalidRequest():Boolean {
			return (ok == -99999)
		}

		public function toBeString(prefix:String=""):String {
			return "";
		}
		
		public function toBeErrorString():String {
			var res:String="";
			if (!this.isSuccess()) {
				res += "ok=" + this.ok + "\n";
				res += "errorMsg=" + this.errorMsg + "\n";
				if (this.errorParam!=null) {
					for (var i:int=0; i<this.errorParam.length; i++) {
						res += "errorParam[" + i + "]=" + this.errorParam[i] + "\n";
					}
				}
			}
			return res;
		}
	}
}