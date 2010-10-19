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
	
	public class HeroInfoUpdate extends BaseResponse
	{
		public function HeroInfoUpdate(type:String, data:Object,bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.setResponseData(data);
				if (data.cityId!=null) {
					this.cityId = data.cityId;
				}
				if (data.heroInfo!=null) {
					this.heroInfo = new HeroInfoBean(data.heroInfo);
				}
		}

		public var cityId:int;
		public var heroInfo:HeroInfoBean;

		public function copyToBe(target:HeroInfoUpdate):void {
			target.cityId = this.cityId 
			if (heroInfo!=null) {
				this.heroInfo.copyToBe(target.heroInfo)
			} else {
				target.heroInfo = null;
			}
		}
		
		public function toBeObject():Object {
			var obj:Object = new Object();
			obj.cityId = this.cityId;
			obj.heroInfo = this.heroInfo.toBeObject();
			return obj;
		}

		public override function toBeString(pre:String=""):String {
			var str:String = "---- HeroInfoUpdate ----\n"  + this.toBeErrorString();
			str += pre + "cityId = " + this.cityId + "\n" ;
			if (heroInfo!=null) {
				str += this.heroInfo.toBeString(pre + "heroInfo.") ;
			} else {
				str += pre + "heroInfo = null\n" ;
			}

			return str;  
		}
	}
}