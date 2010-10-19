/**
* 生成时间 1 
*/
package roma.common.controller.debug
{
	import framework.game.BaseResponse;
	import roma.common.valueObject.*;
	import mx.collections.ArrayCollection;
	import framework.util.CopyAryUtil;
	import flash.utils.ByteArray;
	
	public class EchoResponse extends BaseResponse
	{
		public function EchoResponse(type:String, data:Object,bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.setResponseData(data);
				if (data.content!=null) {
					this.content = data.content;
				}
				if (data.success!=null) {
					this.success = data.success;
				}
		}

		public var content:String;
		public var success:Boolean;

		public function copyToBe(target:EchoResponse):void {
			target.content = this.content 
			target.success = this.success 
		}
		
		public function toBeObject():Object {
			var obj:Object = new Object();
			obj.content = this.content;
			obj.success = this.success;
			return obj;
		}

		public override function toBeString(pre:String=""):String {
			var str:String = "---- EchoResponse ----\n"  + this.toBeErrorString();
			str += pre + "content = " + this.content + "\n" ;
			str += pre + "success = " + this.success + "\n" ;

			return str;  
		}
	}
}