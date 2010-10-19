/**
* 生成时间 1 
*/

package roma.common.valueObject
{
	import mx.collections.ArrayCollection;
	import framework.util.CopyAryUtil;
	import roma.common.valueObject.*;
	import flash.utils.ByteArray;

	[Bindable]
	public class DakBean
	{
		public function DakBean(data:Object=null)
		{
			if (data!=null){
				if (data.cityId!=null) {
					this.cityId = data.cityId;
				}
				if (data.foods!=null) {
					this.foods = data.foods;
				}
				if (data.irons!=null) {
					this.irons = data.irons;
				}
				if (data.stones!=null) {
					this.stones = data.stones;
				}
				if (data.targetCastleId!=null) {
					this.targetCastleId = data.targetCastleId;
				}
				if (data.woods!=null) {
					this.woods = data.woods;
				}
				if (data.effect!=null) {
					this.effect = data.effect;
				}
				if (data.income!=null) {
					this.income = data.income;
				}
			}
		}
		

		public var cityId:int;
		public var foods:int;
		public var irons:int;
		public var stones:int;
		public var targetCastleId:int;
		public var woods:int;
		public var effect:Boolean;
		public var income:Boolean;

		public function copyToBe(target:DakBean):void {
			target.cityId = this.cityId 
			target.foods = this.foods 
			target.irons = this.irons 
			target.stones = this.stones 
			target.targetCastleId = this.targetCastleId 
			target.woods = this.woods 
			target.effect = this.effect 
			target.income = this.income 
		}
		
		public function toBeObject():Object {
			var obj:Object = new Object();
			obj.cityId = this.cityId;
			obj.foods = this.foods;
			obj.irons = this.irons;
			obj.stones = this.stones;
			obj.targetCastleId = this.targetCastleId;
			obj.woods = this.woods;
			obj.effect = this.effect;
			obj.income = this.income;
			return obj;
		}

		public function toBeString(pre:String=""):String {
			var str:String = "";
			str += pre + "cityId = " + this.cityId + "\n" ;
			str += pre + "foods = " + this.foods + "\n" ;
			str += pre + "irons = " + this.irons + "\n" ;
			str += pre + "stones = " + this.stones + "\n" ;
			str += pre + "targetCastleId = " + this.targetCastleId + "\n" ;
			str += pre + "woods = " + this.woods + "\n" ;
			str += pre + "effect = " + this.effect + "\n" ;
			str += pre + "income = " + this.income + "\n" ;

			return str;  
		}
	}
}