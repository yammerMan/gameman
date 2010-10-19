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
	
	public class ZoneInfoDataResponse extends BaseResponse
	{
		public function ZoneInfoDataResponse(type:String, data:Object,bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.setResponseData(data);
				if (data.success!=null) {
					this.success = data.success;
				}
			
				var n:int;
				if (data.array) {
					for (n=0; n<data.array.length; n++) {
						var _array:ZoneInfoDataBean = new ZoneInfoDataBean(data.array[n]);
						this.arrayArray.addItem(_array);
					}
				}
			
		}

		public var success:Boolean;

		public var arrayArray:ArrayCollection = new ArrayCollection();
			
		public function getArray(index:int):ZoneInfoDataBean {
			var res:ZoneInfoDataBean = ZoneInfoDataBean(this.arrayArray[index]);
			return res; 
		}
		public function setArray(bean:ZoneInfoDataBean, index:int):void {
			this.arrayArray[index] = bean;
		}

		public function copyToBe(target:ZoneInfoDataResponse):void {
			target.success = this.success 
		}
		
		public function toBeObject():Object {
			var obj:Object = new Object();
			obj.success = this.success;
			return obj;
		}

		public override function toBeString(pre:String=""):String {
			var str:String = "---- ZoneInfoDataResponse ----\n"  + this.toBeErrorString();
			str += pre + "success = " + this.success + "\n" ;

			var i:int;
			for (i=0; i<this.arrayArray.length; i++) {
				str += this.getArray(i).toBeString(pre + "array[" + i + "].") ;
			}
			

			return str;  
		}
	}
}