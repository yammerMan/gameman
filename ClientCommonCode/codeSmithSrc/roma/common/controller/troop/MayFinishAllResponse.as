/**
* 生成时间 1 
*/
package roma.common.controller.troop
{
	import framework.game.BaseResponse;
	import roma.common.valueObject.*;
	import mx.collections.ArrayCollection;
	import framework.util.CopyAryUtil;
	import flash.utils.ByteArray;
	
	public class MayFinishAllResponse extends BaseResponse
	{
		public function MayFinishAllResponse(type:String, data:Object,bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.setResponseData(data);
				if (data.finishAll!=null) {
					this.finishAll = data.finishAll;
				}
				if (data.success!=null) {
					this.success = data.success;
				}
		}

		public var finishAll:Boolean;
		public var success:Boolean;

		public function copyToBe(target:MayFinishAllResponse):void {
			target.finishAll = this.finishAll 
			target.success = this.success 
		}
		
		public function toBeObject():Object {
			var obj:Object = new Object();
			obj.finishAll = this.finishAll;
			obj.success = this.success;
			return obj;
		}

		public override function toBeString(pre:String=""):String {
			var str:String = "---- MayFinishAllResponse ----\n"  + this.toBeErrorString();
			str += pre + "finishAll = " + this.finishAll + "\n" ;
			str += pre + "success = " + this.success + "\n" ;

			return str;  
		}
	}
}