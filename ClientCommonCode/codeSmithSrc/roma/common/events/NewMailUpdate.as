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
	
	public class NewMailUpdate extends BaseResponse
	{
		public function NewMailUpdate(type:String, data:Object,bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.setResponseData(data);
				if (data.newMailCount!=null) {
					this.newMailCount = data.newMailCount;
				}
		}

		public var newMailCount:int;

		public function copyToBe(target:NewMailUpdate):void {
			target.newMailCount = this.newMailCount 
		}
		
		public function toBeObject():Object {
			var obj:Object = new Object();
			obj.newMailCount = this.newMailCount;
			return obj;
		}

		public override function toBeString(pre:String=""):String {
			var str:String = "---- NewMailUpdate ----\n"  + this.toBeErrorString();
			str += pre + "newMailCount = " + this.newMailCount + "\n" ;

			return str;  
		}
	}
}