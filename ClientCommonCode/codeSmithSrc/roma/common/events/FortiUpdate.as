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
	
	public class FortiUpdate extends BaseResponse
	{
		public function FortiUpdate(type:String, data:Object,bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.setResponseData(data);
				if (data.cityId!=null) {
					this.cityId = data.cityId;
				}
				if (data.fortifi!=null) {
					this.fortifi = new PairValueBean(data.fortifi);
				}
		}

		public var cityId:int;
		public var fortifi:PairValueBean;

		public function copyToBe(target:FortiUpdate):void {
			target.cityId = this.cityId 
			if (fortifi!=null) {
				this.fortifi.copyToBe(target.fortifi)
			} else {
				target.fortifi = null;
			}
		}
		
		public function toBeObject():Object {
			var obj:Object = new Object();
			obj.cityId = this.cityId;
			obj.fortifi = this.fortifi.toBeObject();
			return obj;
		}

		public override function toBeString(pre:String=""):String {
			var str:String = "---- FortiUpdate ----\n"  + this.toBeErrorString();
			str += pre + "cityId = " + this.cityId + "\n" ;
			if (fortifi!=null) {
				str += this.fortifi.toBeString(pre + "fortifi.") ;
			} else {
				str += pre + "fortifi = null\n" ;
			}

			return str;  
		}
	}
}