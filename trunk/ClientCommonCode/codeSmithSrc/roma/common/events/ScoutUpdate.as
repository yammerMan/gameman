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
	
	public class ScoutUpdate extends BaseResponse
	{
		public function ScoutUpdate(type:String, data:Object,bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.setResponseData(data);
				if (data.cityId!=null) {
					this.cityId = data.cityId;
				}
				if (data.scoutBean!=null) {
					this.scoutBean = new ScoutBean(data.scoutBean);
				}
				if (data.updateType!=null) {
					this.updateType = data.updateType;
				}
		}

		public var cityId:int;
		public var scoutBean:ScoutBean;
		public var updateType:int;

		public function copyToBe(target:ScoutUpdate):void {
			target.cityId = this.cityId 
			if (scoutBean!=null) {
				this.scoutBean.copyToBe(target.scoutBean)
			} else {
				target.scoutBean = null;
			}
			target.updateType = this.updateType 
		}
		
		public function toBeObject():Object {
			var obj:Object = new Object();
			obj.cityId = this.cityId;
			obj.scoutBean = this.scoutBean.toBeObject();
			obj.updateType = this.updateType;
			return obj;
		}

		public override function toBeString(pre:String=""):String {
			var str:String = "---- ScoutUpdate ----\n"  + this.toBeErrorString();
			str += pre + "cityId = " + this.cityId + "\n" ;
			if (scoutBean!=null) {
				str += this.scoutBean.toBeString(pre + "scoutBean.") ;
			} else {
				str += pre + "scoutBean = null\n" ;
			}
			str += pre + "updateType = " + this.updateType + "\n" ;

			return str;  
		}
	}
}