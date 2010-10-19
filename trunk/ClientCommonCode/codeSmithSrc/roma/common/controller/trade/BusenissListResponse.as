/**
* 生成时间 1 
*/
package roma.common.controller.trade
{
	import framework.game.BaseResponse;
	import roma.common.valueObject.*;
	import mx.collections.ArrayCollection;
	import framework.util.CopyAryUtil;
	import flash.utils.ByteArray;
	
	public class BusenissListResponse extends BaseResponse
	{
		public function BusenissListResponse(type:String, data:Object,bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.setResponseData(data);
				if (data.success!=null) {
					this.success = data.success;
				}
			
				var n:int;
				if (data.businesses) {
					for (n=0; n<data.businesses.length; n++) {
						var _businesses:BusinessBean = new BusinessBean(data.businesses[n]);
						this.businessesArray.addItem(_businesses);
					}
				}
			
		}

		public var success:Boolean;

		public var businessesArray:ArrayCollection = new ArrayCollection();
			
		public function getBusinesses(index:int):BusinessBean {
			var res:BusinessBean = BusinessBean(this.businessesArray[index]);
			return res; 
		}
		public function setBusinesses(bean:BusinessBean, index:int):void {
			this.businessesArray[index] = bean;
		}

		public function copyToBe(target:BusenissListResponse):void {
			target.success = this.success 
		}
		
		public function toBeObject():Object {
			var obj:Object = new Object();
			obj.success = this.success;
			return obj;
		}

		public override function toBeString(pre:String=""):String {
			var str:String = "---- BusenissListResponse ----\n"  + this.toBeErrorString();
			str += pre + "success = " + this.success + "\n" ;

			var i:int;
			for (i=0; i<this.businessesArray.length; i++) {
				str += this.getBusinesses(i).toBeString(pre + "businesses[" + i + "].") ;
			}
			

			return str;  
		}
	}
}