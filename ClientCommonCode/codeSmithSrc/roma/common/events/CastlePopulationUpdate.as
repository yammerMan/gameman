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
	
	public class CastlePopulationUpdate extends BaseResponse
	{
		public function CastlePopulationUpdate(type:String, data:Object,bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.setResponseData(data);
				if (data.cityId!=null) {
					this.cityId = data.cityId;
				}
				if (data.cityPopu!=null) {
					this.cityPopu = new CastlePopulationBean(data.cityPopu);
				}
		}

		public var cityId:int;
		public var cityPopu:CastlePopulationBean;

		public function copyToBe(target:CastlePopulationUpdate):void {
			target.cityId = this.cityId 
			if (cityPopu!=null) {
				this.cityPopu.copyToBe(target.cityPopu)
			} else {
				target.cityPopu = null;
			}
		}
		
		public function toBeObject():Object {
			var obj:Object = new Object();
			obj.cityId = this.cityId;
			obj.cityPopu = this.cityPopu.toBeObject();
			return obj;
		}

		public override function toBeString(pre:String=""):String {
			var str:String = "---- CastlePopulationUpdate ----\n"  + this.toBeErrorString();
			str += pre + "cityId = " + this.cityId + "\n" ;
			if (cityPopu!=null) {
				str += this.cityPopu.toBeString(pre + "cityPopu.") ;
			} else {
				str += pre + "cityPopu = null\n" ;
			}

			return str;  
		}
	}
}