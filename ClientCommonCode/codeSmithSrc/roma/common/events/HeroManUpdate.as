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
	
	public class HeroManUpdate extends BaseResponse
	{
		public function HeroManUpdate(type:String, data:Object,bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.setResponseData(data);
				if (data.bean!=null) {
					this.bean = new HeroManBean(data.bean);
				}
				if (data.cityId!=null) {
					this.cityId = data.cityId;
				}
				if (data.heroManId!=null) {
					this.heroManId = data.heroManId;
				}
				if (data.updateType!=null) {
					this.updateType = data.updateType;
				}
		}

		public var bean:HeroManBean;
		public var cityId:int;
		public var heroManId:int;
		public var updateType:int;

		public function copyToBe(target:HeroManUpdate):void {
			if (bean!=null) {
				this.bean.copyToBe(target.bean)
			} else {
				target.bean = null;
			}
			target.cityId = this.cityId 
			target.heroManId = this.heroManId 
			target.updateType = this.updateType 
		}
		
		public function toBeObject():Object {
			var obj:Object = new Object();
			obj.bean = this.bean.toBeObject();
			obj.cityId = this.cityId;
			obj.heroManId = this.heroManId;
			obj.updateType = this.updateType;
			return obj;
		}

		public override function toBeString(pre:String=""):String {
			var str:String = "---- HeroManUpdate ----\n"  + this.toBeErrorString();
			if (bean!=null) {
				str += this.bean.toBeString(pre + "bean.") ;
			} else {
				str += pre + "bean = null\n" ;
			}
			str += pre + "cityId = " + this.cityId + "\n" ;
			str += pre + "heroManId = " + this.heroManId + "\n" ;
			str += pre + "updateType = " + this.updateType + "\n" ;

			return str;  
		}
	}
}