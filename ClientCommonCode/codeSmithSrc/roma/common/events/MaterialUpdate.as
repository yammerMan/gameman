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
	
	public class MaterialUpdate extends BaseResponse
	{
		public function MaterialUpdate(type:String, data:Object,bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.setResponseData(data);
				if (data.item!=null) {
					this.item = new MaterialBean(data.item);
				}
		}

		public var item:MaterialBean;

		public function copyToBe(target:MaterialUpdate):void {
			if (item!=null) {
				this.item.copyToBe(target.item)
			} else {
				target.item = null;
			}
		}
		
		public function toBeObject():Object {
			var obj:Object = new Object();
			obj.item = this.item.toBeObject();
			return obj;
		}

		public override function toBeString(pre:String=""):String {
			var str:String = "---- MaterialUpdate ----\n"  + this.toBeErrorString();
			if (item!=null) {
				str += this.item.toBeString(pre + "item.") ;
			} else {
				str += pre + "item = null\n" ;
			}

			return str;  
		}
	}
}