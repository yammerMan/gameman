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
	
	public class ManufactureQueueUpdate extends BaseResponse
	{
		public function ManufactureQueueUpdate(type:String, data:Object,bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.setResponseData(data);
				if (data.cityId!=null) {
					this.cityId = data.cityId;
				}
				if (data.produces!=null) {
					this.produces = new ManufactureQueue(data.produces);
				}
		}

		public var cityId:int;
		public var produces:ManufactureQueue;

		public function copyToBe(target:ManufactureQueueUpdate):void {
			target.cityId = this.cityId 
			if (produces!=null) {
				this.produces.copyToBe(target.produces)
			} else {
				target.produces = null;
			}
		}
		
		public function toBeObject():Object {
			var obj:Object = new Object();
			obj.cityId = this.cityId;
			obj.produces = this.produces.toBeObject();
			return obj;
		}

		public override function toBeString(pre:String=""):String {
			var str:String = "---- ManufactureQueueUpdate ----\n"  + this.toBeErrorString();
			str += pre + "cityId = " + this.cityId + "\n" ;
			if (produces!=null) {
				str += this.produces.toBeString(pre + "produces.") ;
			} else {
				str += pre + "produces = null\n" ;
			}

			return str;  
		}
	}
}