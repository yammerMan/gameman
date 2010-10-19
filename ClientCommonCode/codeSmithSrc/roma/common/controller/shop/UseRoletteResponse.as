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
	
	public class UseRoletteResponse extends BaseResponse
	{
		public function UseRoletteResponse(type:String, data:Object,bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.setResponseData(data);
				if (data.resultBean!=null) {
					this.resultBean = new RoletteResultBean(data.resultBean);
				}
				if (data.success!=null) {
					this.success = data.success;
				}
		}

		public var resultBean:RoletteResultBean;
		public var success:Boolean;

		public function copyToBe(target:UseRoletteResponse):void {
			if (resultBean!=null) {
				this.resultBean.copyToBe(target.resultBean)
			} else {
				target.resultBean = null;
			}
			target.success = this.success 
		}
		
		public function toBeObject():Object {
			var obj:Object = new Object();
			obj.resultBean = this.resultBean.toBeObject();
			obj.success = this.success;
			return obj;
		}

		public override function toBeString(pre:String=""):String {
			var str:String = "---- UseRoletteResponse ----\n"  + this.toBeErrorString();
			if (resultBean!=null) {
				str += this.resultBean.toBeString(pre + "resultBean.") ;
			} else {
				str += pre + "resultBean = null\n" ;
			}
			str += pre + "success = " + this.success + "\n" ;

			return str;  
		}
	}
}