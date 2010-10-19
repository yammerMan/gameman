/**
* 生成时间 1 
*/
package roma.common.controller
{
	import framework.game.BaseResponse;
	import roma.common.valueObject.*;
	import mx.collections.ArrayCollection;
	import framework.util.CopyAryUtil;
	import flash.utils.ByteArray;
	
	public class CommonResponse extends BaseResponse
	{
		public function CommonResponse(type:String, data:Object,bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.setResponseData(data);
				if (data.success!=null) {
					this.success = data.success;
				}
		}

		public static const OK_INVALID_REQUEST:int = -99999;
		public static const OK_DEFAULT:int = 1;

		public var success:Boolean;

		public function copyToBe(target:CommonResponse):void {
			target.success = this.success 
		}
		
		public function toBeObject():Object {
			var obj:Object = new Object();
			obj.success = this.success;
			return obj;
		}

		public override function toBeString(pre:String=""):String {
			var str:String = "---- CommonResponse ----\n"  + this.toBeErrorString();
			str += pre + "success = " + this.success + "\n" ;

			return str;  
		}
	}
}