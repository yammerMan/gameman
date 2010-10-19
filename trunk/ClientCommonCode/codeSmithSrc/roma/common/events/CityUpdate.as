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
	
	public class CityUpdate extends BaseResponse
	{
		public function CityUpdate(type:String, data:Object,bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.setResponseData(data);
				if (data.castle!=null) {
					this.castle = new CityBean(data.castle);
				}
				if (data.cityId!=null) {
					this.cityId = data.cityId;
				}
				if (data.updateType!=null) {
					this.updateType = data.updateType;
				}
		}

		public var castle:CityBean;
		public var cityId:int;
		public var updateType:int;

		public function copyToBe(target:CityUpdate):void {
			if (castle!=null) {
				this.castle.copyToBe(target.castle)
			} else {
				target.castle = null;
			}
			target.cityId = this.cityId 
			target.updateType = this.updateType 
		}
		
		public function toBeObject():Object {
			var obj:Object = new Object();
			obj.castle = this.castle.toBeObject();
			obj.cityId = this.cityId;
			obj.updateType = this.updateType;
			return obj;
		}

		public override function toBeString(pre:String=""):String {
			var str:String = "---- CityUpdate ----\n"  + this.toBeErrorString();
			if (castle!=null) {
				str += this.castle.toBeString(pre + "castle.") ;
			} else {
				str += pre + "castle = null\n" ;
			}
			str += pre + "cityId = " + this.cityId + "\n" ;
			str += pre + "updateType = " + this.updateType + "\n" ;

			return str;  
		}
	}
}