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
	
	public class HeroBuffUpdate extends BaseResponse
	{
		public function HeroBuffUpdate(type:String, data:Object,bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.setResponseData(data);
				if (data.buff!=null) {
					this.buff = new BufferBean(data.buff);
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

		public var buff:BufferBean;
		public var cityId:int;
		public var heroManId:int;
		public var updateType:int;

		public function copyToBe(target:HeroBuffUpdate):void {
			if (buff!=null) {
				this.buff.copyToBe(target.buff)
			} else {
				target.buff = null;
			}
			target.cityId = this.cityId 
			target.heroManId = this.heroManId 
			target.updateType = this.updateType 
		}
		
		public function toBeObject():Object {
			var obj:Object = new Object();
			obj.buff = this.buff.toBeObject();
			obj.cityId = this.cityId;
			obj.heroManId = this.heroManId;
			obj.updateType = this.updateType;
			return obj;
		}

		public override function toBeString(pre:String=""):String {
			var str:String = "---- HeroBuffUpdate ----\n"  + this.toBeErrorString();
			if (buff!=null) {
				str += this.buff.toBeString(pre + "buff.") ;
			} else {
				str += pre + "buff = null\n" ;
			}
			str += pre + "cityId = " + this.cityId + "\n" ;
			str += pre + "heroManId = " + this.heroManId + "\n" ;
			str += pre + "updateType = " + this.updateType + "\n" ;

			return str;  
		}
	}
}