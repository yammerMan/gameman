/**
* 生成时间 1 
*/
package roma.common.controller.user
{
	import framework.game.BaseResponse;
	import roma.common.valueObject.*;
	import mx.collections.ArrayCollection;
	import framework.util.CopyAryUtil;
	import flash.utils.ByteArray;
	
	public class GmLoginResponse extends BaseResponse
	{
		public function GmLoginResponse(type:String, data:Object,bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.setResponseData(data);
				if (data.gm!=null) {
					this.gm = new GmBean(data.gm);
				}
				if (data.success!=null) {
					this.success = data.success;
				}
		}

		public var gm:GmBean;
		public var success:Boolean;

		public function copyToBe(target:GmLoginResponse):void {
			if (gm!=null) {
				this.gm.copyToBe(target.gm)
			} else {
				target.gm = null;
			}
			target.success = this.success 
		}
		
		public function toBeObject():Object {
			var obj:Object = new Object();
			obj.gm = this.gm.toBeObject();
			obj.success = this.success;
			return obj;
		}

		public override function toBeString(pre:String=""):String {
			var str:String = "---- GmLoginResponse ----\n"  + this.toBeErrorString();
			if (gm!=null) {
				str += this.gm.toBeString(pre + "gm.") ;
			} else {
				str += pre + "gm = null\n" ;
			}
			str += pre + "success = " + this.success + "\n" ;

			return str;  
		}
	}
}