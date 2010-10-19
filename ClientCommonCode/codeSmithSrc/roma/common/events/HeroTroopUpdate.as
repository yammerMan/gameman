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
	
	public class HeroTroopUpdate extends BaseResponse
	{
		public function HeroTroopUpdate(type:String, data:Object,bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.setResponseData(data);
				if (data.cityId!=null) {
					this.cityId = data.cityId;
				}
				if (data.heroManId!=null) {
					this.heroManId = data.heroManId;
				}
				if (data.troop!=null) {
					this.troop = new HeroTroopBean(data.troop);
				}
		}

		public var cityId:int;
		public var heroManId:int;
		public var troop:HeroTroopBean;

		public function copyToBe(target:HeroTroopUpdate):void {
			target.cityId = this.cityId 
			target.heroManId = this.heroManId 
			if (troop!=null) {
				this.troop.copyToBe(target.troop)
			} else {
				target.troop = null;
			}
		}
		
		public function toBeObject():Object {
			var obj:Object = new Object();
			obj.cityId = this.cityId;
			obj.heroManId = this.heroManId;
			obj.troop = this.troop.toBeObject();
			return obj;
		}

		public override function toBeString(pre:String=""):String {
			var str:String = "---- HeroTroopUpdate ----\n"  + this.toBeErrorString();
			str += pre + "cityId = " + this.cityId + "\n" ;
			str += pre + "heroManId = " + this.heroManId + "\n" ;
			if (troop!=null) {
				str += this.troop.toBeString(pre + "troop.") ;
			} else {
				str += pre + "troop = null\n" ;
			}

			return str;  
		}
	}
}