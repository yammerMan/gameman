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
	
	public class HeroArmyUpdate extends BaseResponse
	{
		public function HeroArmyUpdate(type:String, data:Object,bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.setResponseData(data);
				if (data.cityId!=null) {
					this.cityId = data.cityId;
				}
				if (data.heroManId!=null) {
					this.heroManId = data.heroManId;
				}
				if (data.retreatCondition!=null) {
					this.retreatCondition = new HeroRetreatConditionBean(data.retreatCondition);
				}
			
				var n:int;
				if (data.troops) {
					for (n=0; n<data.troops.length; n++) {
						var _troops:HeroTroopBean = new HeroTroopBean(data.troops[n]);
						this.troopsArray.addItem(_troops);
					}
				}
			
		}

		public var cityId:int;
		public var heroManId:int;
		public var retreatCondition:HeroRetreatConditionBean;

		public var troopsArray:ArrayCollection = new ArrayCollection();
			
		public function getTroops(index:int):HeroTroopBean {
			var res:HeroTroopBean = HeroTroopBean(this.troopsArray[index]);
			return res; 
		}
		public function setTroops(bean:HeroTroopBean, index:int):void {
			this.troopsArray[index] = bean;
		}

		public function copyToBe(target:HeroArmyUpdate):void {
			target.cityId = this.cityId 
			target.heroManId = this.heroManId 
			if (retreatCondition!=null) {
				this.retreatCondition.copyToBe(target.retreatCondition)
			} else {
				target.retreatCondition = null;
			}
		}
		
		public function toBeObject():Object {
			var obj:Object = new Object();
			obj.cityId = this.cityId;
			obj.heroManId = this.heroManId;
			obj.retreatCondition = this.retreatCondition.toBeObject();
			return obj;
		}

		public override function toBeString(pre:String=""):String {
			var str:String = "---- HeroArmyUpdate ----\n"  + this.toBeErrorString();
			str += pre + "cityId = " + this.cityId + "\n" ;
			str += pre + "heroManId = " + this.heroManId + "\n" ;
			if (retreatCondition!=null) {
				str += this.retreatCondition.toBeString(pre + "retreatCondition.") ;
			} else {
				str += pre + "retreatCondition = null\n" ;
			}

			var i:int;
			for (i=0; i<this.troopsArray.length; i++) {
				str += this.getTroops(i).toBeString(pre + "troops[" + i + "].") ;
			}
			

			return str;  
		}
	}
}