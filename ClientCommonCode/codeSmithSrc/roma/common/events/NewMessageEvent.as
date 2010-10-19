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
	
	public class NewMessageEvent extends BaseResponse
	{
		public function NewMessageEvent(type:String, data:Object,bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.setResponseData(data);
				if (data.reportType!=null) {
					this.reportType = data.reportType;
				}
		}

		public var reportType:int;

		public function copyToBe(target:NewMessageEvent):void {
			target.reportType = this.reportType 
		}
		
		public function toBeObject():Object {
			var obj:Object = new Object();
			obj.reportType = this.reportType;
			return obj;
		}

		public override function toBeString(pre:String=""):String {
			var str:String = "---- NewMessageEvent ----\n"  + this.toBeErrorString();
			str += pre + "reportType = " + this.reportType + "\n" ;

			return str;  
		}
	}
}