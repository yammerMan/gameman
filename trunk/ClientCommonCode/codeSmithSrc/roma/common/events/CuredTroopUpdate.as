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
	
	public class CuredTroopUpdate extends BaseResponse
	{
		public function CuredTroopUpdate(type:String, data:Object,bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.setResponseData(data);
				if (data.cityId!=null) {
					this.cityId = data.cityId;
				}
			
				var n:int;
				if (data.goldForCureInjuredTroop) {
					for (n=0; n<data.goldForCureInjuredTroop.length; n++) {
						var _goldForCureInjuredTroop:PairValueBean = new PairValueBean(data.goldForCureInjuredTroop[n]);
						this.goldForCureInjuredTroopArray.addItem(_goldForCureInjuredTroop);
					}
				}
			
				if (data.injuredTroops) {
					for (n=0; n<data.injuredTroops.length; n++) {
						var _injuredTroops:PairValueBean = new PairValueBean(data.injuredTroops[n]);
						this.injuredTroopsArray.addItem(_injuredTroops);
					}
				}
			
		}

		public var cityId:int;

		public var goldForCureInjuredTroopArray:ArrayCollection = new ArrayCollection();
		public var injuredTroopsArray:ArrayCollection = new ArrayCollection();
			
		public function getGoldForCureInjuredTroop(index:int):PairValueBean {
			var res:PairValueBean = PairValueBean(this.goldForCureInjuredTroopArray[index]);
			return res; 
		}
		public function setGoldForCureInjuredTroop(bean:PairValueBean, index:int):void {
			this.goldForCureInjuredTroopArray[index] = bean;
		}
		public function getInjuredTroops(index:int):PairValueBean {
			var res:PairValueBean = PairValueBean(this.injuredTroopsArray[index]);
			return res; 
		}
		public function setInjuredTroops(bean:PairValueBean, index:int):void {
			this.injuredTroopsArray[index] = bean;
		}

		public function copyToBe(target:CuredTroopUpdate):void {
			target.cityId = this.cityId 
		}
		
		public function toBeObject():Object {
			var obj:Object = new Object();
			obj.cityId = this.cityId;
			return obj;
		}

		public override function toBeString(pre:String=""):String {
			var str:String = "---- CuredTroopUpdate ----\n"  + this.toBeErrorString();
			str += pre + "cityId = " + this.cityId + "\n" ;

			var i:int;
			for (i=0; i<this.goldForCureInjuredTroopArray.length; i++) {
				str += this.getGoldForCureInjuredTroop(i).toBeString(pre + "goldForCureInjuredTroop[" + i + "].") ;
			}
			
			for (i=0; i<this.injuredTroopsArray.length; i++) {
				str += this.getInjuredTroops(i).toBeString(pre + "injuredTroops[" + i + "].") ;
			}
			

			return str;  
		}
	}
}