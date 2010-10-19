/**
* 生成时间 1 
*/
package roma.common.controller.army
{
	import framework.game.BaseResponse;
	import roma.common.valueObject.*;
	import mx.collections.ArrayCollection;
	import framework.util.CopyAryUtil;
	import flash.utils.ByteArray;
	
	public class ArmyExecResponse extends BaseResponse
	{
		public function ArmyExecResponse(type:String, data:Object,bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.setResponseData(data);
				if (data.success!=null) {
					this.success = data.success;
				}
		}

		public var success:Boolean;

		public function copyToBe(target:ArmyExecResponse):void {
			target.success = this.success 
		}
		
		public function toBeObject():Object {
			var obj:Object = new Object();
			obj.success = this.success;
			return obj;
		}

		public override function toBeString(pre:String=""):String {
			var str:String = "---- ArmyExecResponse ----\n"  + this.toBeErrorString();
			str += pre + "success = " + this.success + "\n" ;

			return str;  
		}
	}
}