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
	
	public class MapFieldInfoResponse extends BaseResponse
	{
		public function MapFieldInfoResponse(type:String, data:Object,bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.setResponseData(data);
				if (data.mapFieldInfoBean!=null) {
					this.mapFieldInfoBean = new MapFieldInfoBean(data.mapFieldInfoBean);
				}
				if (data.success!=null) {
					this.success = data.success;
				}
		}

		public var mapFieldInfoBean:MapFieldInfoBean;
		public var success:Boolean;

		public function copyToBe(target:MapFieldInfoResponse):void {
			if (mapFieldInfoBean!=null) {
				this.mapFieldInfoBean.copyToBe(target.mapFieldInfoBean)
			} else {
				target.mapFieldInfoBean = null;
			}
			target.success = this.success 
		}
		
		public function toBeObject():Object {
			var obj:Object = new Object();
			obj.mapFieldInfoBean = this.mapFieldInfoBean.toBeObject();
			obj.success = this.success;
			return obj;
		}

		public override function toBeString(pre:String=""):String {
			var str:String = "---- MapFieldInfoResponse ----\n"  + this.toBeErrorString();
			if (mapFieldInfoBean!=null) {
				str += this.mapFieldInfoBean.toBeString(pre + "mapFieldInfoBean.") ;
			} else {
				str += pre + "mapFieldInfoBean = null\n" ;
			}
			str += pre + "success = " + this.success + "\n" ;

			return str;  
		}
	}
}