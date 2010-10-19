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
	public class PurchaseResourceBean
	{
		public function PurchaseResourceBean(data:Object=null)
		{
			if (data!=null){
				if (data.foodRemains!=null) {
					this.foodRemains = data.foodRemains;
				}
				if (data.ironRemains!=null) {
					this.ironRemains = data.ironRemains;
				}
				if (data.stoneRemains!=null) {
					this.stoneRemains = data.stoneRemains;
				}
				if (data.unitFood!=null) {
					this.unitFood = data.unitFood;
				}
				if (data.unitIron!=null) {
					this.unitIron = data.unitIron;
				}
				if (data.unitStone!=null) {
					this.unitStone = data.unitStone;
				}
				if (data.unitWood!=null) {
					this.unitWood = data.unitWood;
				}
				if (data.woodRemains!=null) {
					this.woodRemains = data.woodRemains;
				}
			}
		}
		

		public var foodRemains:int;
		public var ironRemains:int;
		public var stoneRemains:int;
		public var unitFood:int;
		public var unitIron:int;
		public var unitStone:int;
		public var unitWood:int;
		public var woodRemains:int;

		public function copyToBe(target:PurchaseResourceBean):void {
			target.foodRemains = this.foodRemains 
			target.ironRemains = this.ironRemains 
			target.stoneRemains = this.stoneRemains 
			target.unitFood = this.unitFood 
			target.unitIron = this.unitIron 
			target.unitStone = this.unitStone 
			target.unitWood = this.unitWood 
			target.woodRemains = this.woodRemains 
		}
		
		public function toBeObject():Object {
			var obj:Object = new Object();
			obj.foodRemains = this.foodRemains;
			obj.ironRemains = this.ironRemains;
			obj.stoneRemains = this.stoneRemains;
			obj.unitFood = this.unitFood;
			obj.unitIron = this.unitIron;
			obj.unitStone = this.unitStone;
			obj.unitWood = this.unitWood;
			obj.woodRemains = this.woodRemains;
			return obj;
		}

		public function toBeString(pre:String=""):String {
			var str:String = "";
			str += pre + "foodRemains = " + this.foodRemains + "\n" ;
			str += pre + "ironRemains = " + this.ironRemains + "\n" ;
			str += pre + "stoneRemains = " + this.stoneRemains + "\n" ;
			str += pre + "unitFood = " + this.unitFood + "\n" ;
			str += pre + "unitIron = " + this.unitIron + "\n" ;
			str += pre + "unitStone = " + this.unitStone + "\n" ;
			str += pre + "unitWood = " + this.unitWood + "\n" ;
			str += pre + "woodRemains = " + this.woodRemains + "\n" ;

			return str;  
		}
	}
}