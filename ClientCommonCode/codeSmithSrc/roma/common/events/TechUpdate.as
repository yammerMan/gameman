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
	
	public class TechUpdate extends BaseResponse
	{
		public function TechUpdate(type:String, data:Object,bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.setResponseData(data);
				if (data.techBean!=null) {
					this.techBean = new TechBean(data.techBean);
				}
		}

		public var techBean:TechBean;

		public function copyToBe(target:TechUpdate):void {
			if (techBean!=null) {
				this.techBean.copyToBe(target.techBean)
			} else {
				target.techBean = null;
			}
		}
		
		public function toBeObject():Object {
			var obj:Object = new Object();
			obj.techBean = this.techBean.toBeObject();
			return obj;
		}

		public override function toBeString(pre:String=""):String {
			var str:String = "---- TechUpdate ----\n"  + this.toBeErrorString();
			if (techBean!=null) {
				str += this.techBean.toBeString(pre + "techBean.") ;
			} else {
				str += pre + "techBean = null\n" ;
			}

			return str;  
		}
	}
}