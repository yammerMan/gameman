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
	
	public class ApplyHostCastleUdpate extends BaseResponse
	{
		public function ApplyHostCastleUdpate(type:String, data:Object,bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.setResponseData(data);
				if (data.applyHostCastle!=null) {
					this.applyHostCastle = new RelatedCastleTimeBean(data.applyHostCastle);
				}
				if (data.cityId!=null) {
					this.cityId = data.cityId;
				}
				if (data.updateType!=null) {
					this.updateType = data.updateType;
				}
		}

		public var applyHostCastle:RelatedCastleTimeBean;
		public var cityId:int;
		public var updateType:int;

		public function copyToBe(target:ApplyHostCastleUdpate):void {
			if (applyHostCastle!=null) {
				this.applyHostCastle.copyToBe(target.applyHostCastle)
			} else {
				target.applyHostCastle = null;
			}
			target.cityId = this.cityId 
			target.updateType = this.updateType 
		}
		
		public function toBeObject():Object {
			var obj:Object = new Object();
			obj.applyHostCastle = this.applyHostCastle.toBeObject();
			obj.cityId = this.cityId;
			obj.updateType = this.updateType;
			return obj;
		}

		public override function toBeString(pre:String=""):String {
			var str:String = "---- ApplyHostCastleUdpate ----\n"  + this.toBeErrorString();
			if (applyHostCastle!=null) {
				str += this.applyHostCastle.toBeString(pre + "applyHostCastle.") ;
			} else {
				str += pre + "applyHostCastle = null\n" ;
			}
			str += pre + "cityId = " + this.cityId + "\n" ;
			str += pre + "updateType = " + this.updateType + "\n" ;

			return str;  
		}
	}
}