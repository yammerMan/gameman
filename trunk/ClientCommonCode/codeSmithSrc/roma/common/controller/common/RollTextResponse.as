/**
* 生成时间 1 
*/
package roma.common.controller.common
{
	import framework.game.BaseResponse;
	import roma.common.valueObject.*;
	import mx.collections.ArrayCollection;
	import framework.util.CopyAryUtil;
	import flash.utils.ByteArray;
	
	public class RollTextResponse extends BaseResponse
	{
		public function RollTextResponse(type:String, data:Object,bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.setResponseData(data);
				if (data.rollText!=null) {
					this.rollText = data.rollText;
				}
				if (data.success!=null) {
					this.success = data.success;
				}
		}

		public var rollText:String;
		public var success:Boolean;

		public function copyToBe(target:RollTextResponse):void {
			target.rollText = this.rollText 
			target.success = this.success 
		}
		
		public function toBeObject():Object {
			var obj:Object = new Object();
			obj.rollText = this.rollText;
			obj.success = this.success;
			return obj;
		}

		public override function toBeString(pre:String=""):String {
			var str:String = "---- RollTextResponse ----\n"  + this.toBeErrorString();
			str += pre + "rollText = " + this.rollText + "\n" ;
			str += pre + "success = " + this.success + "\n" ;

			return str;  
		}
	}
}