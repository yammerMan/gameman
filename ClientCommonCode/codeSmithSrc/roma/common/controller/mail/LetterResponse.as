/**
* 生成时间 1 
*/
package roma.common.controller.mail
{
	import framework.game.BaseResponse;
	import roma.common.valueObject.*;
	import mx.collections.ArrayCollection;
	import framework.util.CopyAryUtil;
	import flash.utils.ByteArray;
	
	public class LetterResponse extends BaseResponse
	{
		public function LetterResponse(type:String, data:Object,bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.setResponseData(data);
				if (data.mailBean!=null) {
					this.mailBean = new LetterBean(data.mailBean);
				}
				if (data.success!=null) {
					this.success = data.success;
				}
		}

		public var mailBean:LetterBean;
		public var success:Boolean;

		public function copyToBe(target:LetterResponse):void {
			if (mailBean!=null) {
				this.mailBean.copyToBe(target.mailBean)
			} else {
				target.mailBean = null;
			}
			target.success = this.success 
		}
		
		public function toBeObject():Object {
			var obj:Object = new Object();
			obj.mailBean = this.mailBean.toBeObject();
			obj.success = this.success;
			return obj;
		}

		public override function toBeString(pre:String=""):String {
			var str:String = "---- LetterResponse ----\n"  + this.toBeErrorString();
			if (mailBean!=null) {
				str += this.mailBean.toBeString(pre + "mailBean.") ;
			} else {
				str += pre + "mailBean = null\n" ;
			}
			str += pre + "success = " + this.success + "\n" ;

			return str;  
		}
	}
}