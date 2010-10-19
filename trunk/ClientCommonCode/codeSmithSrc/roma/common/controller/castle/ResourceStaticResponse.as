/**
* 生成时间 1 
*/
package roma.common.controller.castle
{
	import framework.game.BaseResponse;
	import roma.common.valueObject.*;
	import mx.collections.ArrayCollection;
	import framework.util.CopyAryUtil;
	import flash.utils.ByteArray;
	
	public class ResourceStaticResponse extends BaseResponse
	{
		public function ResourceStaticResponse(type:String, data:Object,bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.setResponseData(data);
				if (data.foodBean!=null) {
					this.foodBean = new ResourceStaticBean(data.foodBean);
				}
				if (data.ironBean!=null) {
					this.ironBean = new ResourceStaticBean(data.ironBean);
				}
				if (data.stoneBean!=null) {
					this.stoneBean = new ResourceStaticBean(data.stoneBean);
				}
				if (data.woodBean!=null) {
					this.woodBean = new ResourceStaticBean(data.woodBean);
				}
				if (data.success!=null) {
					this.success = data.success;
				}
		}

		public var foodBean:ResourceStaticBean;
		public var ironBean:ResourceStaticBean;
		public var stoneBean:ResourceStaticBean;
		public var woodBean:ResourceStaticBean;
		public var success:Boolean;

		public function copyToBe(target:ResourceStaticResponse):void {
			if (foodBean!=null) {
				this.foodBean.copyToBe(target.foodBean)
			} else {
				target.foodBean = null;
			}
			if (ironBean!=null) {
				this.ironBean.copyToBe(target.ironBean)
			} else {
				target.ironBean = null;
			}
			if (stoneBean!=null) {
				this.stoneBean.copyToBe(target.stoneBean)
			} else {
				target.stoneBean = null;
			}
			if (woodBean!=null) {
				this.woodBean.copyToBe(target.woodBean)
			} else {
				target.woodBean = null;
			}
			target.success = this.success 
		}
		
		public function toBeObject():Object {
			var obj:Object = new Object();
			obj.foodBean = this.foodBean.toBeObject();
			obj.ironBean = this.ironBean.toBeObject();
			obj.stoneBean = this.stoneBean.toBeObject();
			obj.woodBean = this.woodBean.toBeObject();
			obj.success = this.success;
			return obj;
		}

		public override function toBeString(pre:String=""):String {
			var str:String = "---- ResourceStaticResponse ----\n"  + this.toBeErrorString();
			if (foodBean!=null) {
				str += this.foodBean.toBeString(pre + "foodBean.") ;
			} else {
				str += pre + "foodBean = null\n" ;
			}
			if (ironBean!=null) {
				str += this.ironBean.toBeString(pre + "ironBean.") ;
			} else {
				str += pre + "ironBean = null\n" ;
			}
			if (stoneBean!=null) {
				str += this.stoneBean.toBeString(pre + "stoneBean.") ;
			} else {
				str += pre + "stoneBean = null\n" ;
			}
			if (woodBean!=null) {
				str += this.woodBean.toBeString(pre + "woodBean.") ;
			} else {
				str += pre + "woodBean = null\n" ;
			}
			str += pre + "success = " + this.success + "\n" ;

			return str;  
		}
	}
}