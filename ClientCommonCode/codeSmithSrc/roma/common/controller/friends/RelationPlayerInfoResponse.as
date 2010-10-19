/**
* 生成时间 1 
*/
package roma.common.controller.friends
{
	import framework.game.BaseResponse;
	import roma.common.valueObject.*;
	import mx.collections.ArrayCollection;
	import framework.util.CopyAryUtil;
	import flash.utils.ByteArray;
	
	public class RelationPlayerInfoResponse extends BaseResponse
	{
		public function RelationPlayerInfoResponse(type:String, data:Object,bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.setResponseData(data);
				if (data.bean!=null) {
					this.bean = new PlayerInfoDataBean(data.bean);
				}
				if (data.success!=null) {
					this.success = data.success;
				}
		}

		public var bean:PlayerInfoDataBean;
		public var success:Boolean;

		public function copyToBe(target:RelationPlayerInfoResponse):void {
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
			var str:String = "---- RelationPlayerInfoResponse ----\n"  + this.toBeErrorString();
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