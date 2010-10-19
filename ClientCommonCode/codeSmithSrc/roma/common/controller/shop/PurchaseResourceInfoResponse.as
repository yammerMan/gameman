/**
* 生成时间 1 
*/
package roma.common.controller.shop
{
	import framework.game.BaseResponse;
	import roma.common.valueObject.*;
	import mx.collections.ArrayCollection;
	import framework.util.CopyAryUtil;
	import flash.utils.ByteArray;
	
	public class PurchaseResourceInfoResponse extends BaseResponse
	{
		public function PurchaseResourceInfoResponse(type:String, data:Object,bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.setResponseData(data);
				if (data.bean!=null) {
					this.bean = new PurchaseResourceBean(data.bean);
				}
				if (data.success!=null) {
					this.success = data.success;
				}
		}

		public var bean:PurchaseResourceBean;
		public var success:Boolean;

		public function copyToBe(target:PurchaseResourceInfoResponse):void {
			if (bean!=null) {
				this.bean.copyToBe(target.bean)
			} else {
				target.bean = null;
			}
			target.success = this.success 
		}
		
		public function toBeObject():Object {
			var obj:Object = new Object();
			obj.bean = this.bean.toBeObject();
			obj.success = this.success;
			return obj;
		}

		public override function toBeString(pre:String=""):String {
			var str:String = "---- PurchaseResourceInfoResponse ----\n"  + this.toBeErrorString();
			if (bean!=null) {
				str += this.bean.toBeString(pre + "bean.") ;
			} else {
				str += pre + "bean = null\n" ;
			}
			str += pre + "success = " + this.success + "\n" ;

			return str;  
		}
	}
}