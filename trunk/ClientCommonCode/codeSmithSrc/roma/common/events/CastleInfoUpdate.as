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
	
	public class CastleInfoUpdate extends BaseResponse
	{
		public function CastleInfoUpdate(type:String, data:Object,bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.setResponseData(data);
				if (data.castleInfo!=null) {
					this.castleInfo = new CastleInfoBean(data.castleInfo);
				}
		}

		public var castleInfo:CastleInfoBean;

		public function copyToBe(target:CastleInfoUpdate):void {
			if (castleInfo!=null) {
				this.castleInfo.copyToBe(target.castleInfo)
			} else {
				target.castleInfo = null;
			}
		}
		
		public function toBeObject():Object {
			var obj:Object = new Object();
			obj.castleInfo = this.castleInfo.toBeObject();
			return obj;
		}

		public override function toBeString(pre:String=""):String {
			var str:String = "---- CastleInfoUpdate ----\n"  + this.toBeErrorString();
			if (castleInfo!=null) {
				str += this.castleInfo.toBeString(pre + "castleInfo.") ;
			} else {
				str += pre + "castleInfo = null\n" ;
			}

			return str;  
		}
	}
}