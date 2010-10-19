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
	
	public class FreeSentenceTimeUpdate extends BaseResponse
	{
		public function FreeSentenceTimeUpdate(type:String, data:Object,bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.setResponseData(data);
				if (data.lastFreeSentenceTime!=null) {
					this.lastFreeSentenceTime = data.lastFreeSentenceTime;
				}
		}

		public var lastFreeSentenceTime:Number;

		public function copyToBe(target:FreeSentenceTimeUpdate):void {
			target.lastFreeSentenceTime = this.lastFreeSentenceTime 
		}
		
		public function toBeObject():Object {
			var obj:Object = new Object();
			obj.lastFreeSentenceTime = this.lastFreeSentenceTime;
			return obj;
		}

		public override function toBeString(pre:String=""):String {
			var str:String = "---- FreeSentenceTimeUpdate ----\n"  + this.toBeErrorString();
			str += pre + "lastFreeSentenceTime = " + this.lastFreeSentenceTime + "\n" ;

			return str;  
		}
	}
}