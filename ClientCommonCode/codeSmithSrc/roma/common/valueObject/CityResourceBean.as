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
	public class CityResourceBean
	{
		public function CityResourceBean(data:Object=null)
		{
			if (data!=null){
				if (data.conquestFood!=null) {
					this.conquestFood = data.conquestFood;
				}
				if (data.conquestIron!=null) {
					this.conquestIron = data.conquestIron;
				}
				if (data.conquestStone!=null) {
					this.conquestStone = data.conquestStone;
				}
				if (data.conquestWood!=null) {
					this.conquestWood = data.conquestWood;
				}
				if (data.foodIncRate!=null) {
					this.foodIncRate = data.foodIncRate;
				}
				if (data.foodStorePer!=null) {
					this.foodStorePer = data.foodStorePer;
				}
				if (data.foods!=null) {
					this.foods = data.foods;
				}
				if (data.goldIncRate!=null) {
					this.goldIncRate = data.goldIncRate;
				}
				if (data.golds!=null) {
					this.golds = data.golds;
				}
				if (data.heroSalary!=null) {
					this.heroSalary = data.heroSalary;
				}
				if (data.ironIncRate!=null) {
					this.ironIncRate = data.ironIncRate;
				}
				if (data.ironStorePer!=null) {
					this.ironStorePer = data.ironStorePer;
				}
				if (data.irons!=null) {
					this.irons = data.irons;
				}
				if (data.stoneIncRate!=null) {
					this.stoneIncRate = data.stoneIncRate;
				}
				if (data.stoneStorePer!=null) {
					this.stoneStorePer = data.stoneStorePer;
				}
				if (data.stones!=null) {
					this.stones = data.stones;
				}
				if (data.troopConsumeFood!=null) {
					this.troopConsumeFood = data.troopConsumeFood;
				}
				if (data.warehouseCap!=null) {
					this.warehouseCap = data.warehouseCap;
				}
				if (data.woodIncRate!=null) {
					this.woodIncRate = data.woodIncRate;
				}
				if (data.woodStorePer!=null) {
					this.woodStorePer = data.woodStorePer;
				}
				if (data.woods!=null) {
					this.woods = data.woods;
				}
			}
		}
		

		public var conquestFood:Number;
		public var conquestIron:Number;
		public var conquestStone:Number;
		public var conquestWood:Number;
		public var foodIncRate:Number;
		public var foodStorePer:int;
		public var foods:Number;
		public var goldIncRate:Number;
		public var golds:Number;
		public var heroSalary:int;
		public var ironIncRate:Number;
		public var ironStorePer:int;
		public var irons:Number;
		public var stoneIncRate:Number;
		public var stoneStorePer:int;
		public var stones:Number;
		public var troopConsumeFood:int;
		public var warehouseCap:Number;
		public var woodIncRate:Number;
		public var woodStorePer:int;
		public var woods:Number;

		public function copyToBe(target:CityResourceBean):void {
			target.conquestFood = this.conquestFood 
			target.conquestIron = this.conquestIron 
			target.conquestStone = this.conquestStone 
			target.conquestWood = this.conquestWood 
			target.foodIncRate = this.foodIncRate 
			target.foodStorePer = this.foodStorePer 
			target.foods = this.foods 
			target.goldIncRate = this.goldIncRate 
			target.golds = this.golds 
			target.heroSalary = this.heroSalary 
			target.ironIncRate = this.ironIncRate 
			target.ironStorePer = this.ironStorePer 
			target.irons = this.irons 
			target.stoneIncRate = this.stoneIncRate 
			target.stoneStorePer = this.stoneStorePer 
			target.stones = this.stones 
			target.troopConsumeFood = this.troopConsumeFood 
			target.warehouseCap = this.warehouseCap 
			target.woodIncRate = this.woodIncRate 
			target.woodStorePer = this.woodStorePer 
			target.woods = this.woods 
		}
		
		public function toBeObject():Object {
			var obj:Object = new Object();
			obj.conquestFood = this.conquestFood;
			obj.conquestIron = this.conquestIron;
			obj.conquestStone = this.conquestStone;
			obj.conquestWood = this.conquestWood;
			obj.foodIncRate = this.foodIncRate;
			obj.foodStorePer = this.foodStorePer;
			obj.foods = this.foods;
			obj.goldIncRate = this.goldIncRate;
			obj.golds = this.golds;
			obj.heroSalary = this.heroSalary;
			obj.ironIncRate = this.ironIncRate;
			obj.ironStorePer = this.ironStorePer;
			obj.irons = this.irons;
			obj.stoneIncRate = this.stoneIncRate;
			obj.stoneStorePer = this.stoneStorePer;
			obj.stones = this.stones;
			obj.troopConsumeFood = this.troopConsumeFood;
			obj.warehouseCap = this.warehouseCap;
			obj.woodIncRate = this.woodIncRate;
			obj.woodStorePer = this.woodStorePer;
			obj.woods = this.woods;
			return obj;
		}

		public function toBeString(pre:String=""):String {
			var str:String = "";
			str += pre + "conquestFood = " + this.conquestFood + "\n" ;
			str += pre + "conquestIron = " + this.conquestIron + "\n" ;
			str += pre + "conquestStone = " + this.conquestStone + "\n" ;
			str += pre + "conquestWood = " + this.conquestWood + "\n" ;
			str += pre + "foodIncRate = " + this.foodIncRate + "\n" ;
			str += pre + "foodStorePer = " + this.foodStorePer + "\n" ;
			str += pre + "foods = " + this.foods + "\n" ;
			str += pre + "goldIncRate = " + this.goldIncRate + "\n" ;
			str += pre + "golds = " + this.golds + "\n" ;
			str += pre + "heroSalary = " + this.heroSalary + "\n" ;
			str += pre + "ironIncRate = " + this.ironIncRate + "\n" ;
			str += pre + "ironStorePer = " + this.ironStorePer + "\n" ;
			str += pre + "irons = " + this.irons + "\n" ;
			str += pre + "stoneIncRate = " + this.stoneIncRate + "\n" ;
			str += pre + "stoneStorePer = " + this.stoneStorePer + "\n" ;
			str += pre + "stones = " + this.stones + "\n" ;
			str += pre + "troopConsumeFood = " + this.troopConsumeFood + "\n" ;
			str += pre + "warehouseCap = " + this.warehouseCap + "\n" ;
			str += pre + "woodIncRate = " + this.woodIncRate + "\n" ;
			str += pre + "woodStorePer = " + this.woodStorePer + "\n" ;
			str += pre + "woods = " + this.woods + "\n" ;

			return str;  
		}
	}
}