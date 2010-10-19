/**
* 生成时间 1 
*/

package roma.common.valueObject
{
	import mx.collections.ArrayCollection;
	import framework.util.CopyAryUtil;
	import roma.common.valueObject.*;
	import flash.utils.ByteArray;

	[Bindable]
	public class GmBean
	{
		public function GmBean(data:Object=null)
		{
			if (data!=null){
				if (data.gmInfo!=null) {
					this.gmInfo = new GmInfoBean(data.gmInfo);
				}
			}
		}
		

		public var gmInfo:GmInfoBean;

		public function copyToBe(target:GmBean):void {
			if (gmInfo!=null) {
				this.gmInfo.copyToBe(target.gmInfo)
			} else {
				target.gmInfo = null;
			}
		}
		
		public function toBeObject():Object {
			var obj:Object = new Object();
			obj.gmInfo = this.gmInfo.toBeObject();
			return obj;
		}

		public function toBeString(pre:String=""):String {
			var str:String = "";
			if (gmInfo!=null) {
				str += this.gmInfo.toBeString(pre + "gmInfo.") ;
			} else {
				str += pre + "gmInfo = null\n" ;
			}

			return str;  
		}
	}
}