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
	
	public class CastleMilitaryUpdate extends BaseResponse
	{
		public function CastleMilitaryUpdate(type:String, data:Object,bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.setResponseData(data);
				if (data.cityId!=null) {
					this.cityId = data.cityId;
				}
				if (data.militaryBean!=null) {
					this.militaryBean = new CastleMilitaryBean(data.militaryBean);
				}
		}

		public var cityId:int;
		public var militaryBean:CastleMilitaryBean;

		public function copyToBe(target:CastleMilitaryUpdate):void {
			target.cityId = this.cityId 
			if (militaryBean!=null) {
				this.militaryBean.copyToBe(target.militaryBean)
			} else {
				target.militaryBean = null;
			}
		}
		
		public function toBeObject():Object {
			var obj:Object = new Object();
			obj.cityId = this.cityId;
			obj.militaryBean = this.militaryBean.toBeObject();
			return obj;
		}

		public override function toBeString(pre:String=""):String {
			var str:String = "---- CastleMilitaryUpdate ----\n"  + this.toBeErrorString();
			str += pre + "cityId = " + this.cityId + "\n" ;
			if (militaryBean!=null) {
				str += this.militaryBean.toBeString(pre + "militaryBean.") ;
			} else {
				str += pre + "militaryBean = null\n" ;
			}

			return str;  
		}
	}
}