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
	public class EquipBean
	{
		public function EquipBean(data:Object=null)
		{
			if (data!=null){
				if (data.attack!=null) {
					this.attack = data.attack;
				}
				if (data.attackTimes!=null) {
					this.attackTimes = data.attackTimes;
				}
				if (data.damage!=null) {
					this.damage = data.damage;
				}
				if (data.defence!=null) {
					this.defence = data.defence;
				}
				if (data.funcDesc!=null) {
					this.funcDesc = data.funcDesc;
				}
				if (data.iconUrl!=null) {
					this.iconUrl = data.iconUrl;
				}
				if (data.itemDesc!=null) {
					this.itemDesc = data.itemDesc;
				}
				if (data.level!=null) {
					this.level = data.level;
				}
				if (data.life!=null) {
					this.life = data.life;
				}
				if (data.name!=null) {
					this.name = data.name;
				}
				if (data.part!=null) {
					this.part = data.part;
				}
				if (data.price!=null) {
					this.price = data.price;
				}
				if (data.sort!=null) {
					this.sort = data.sort;
				}
				if (data.title!=null) {
					this.title = data.title;
				}
				if (data.type!=null) {
					this.type = data.type;
				}
				if (data.arrowRain!=null) {
					this.arrowRain = data.arrowRain;
				}
				if (data.blockCavalry!=null) {
					this.blockCavalry = data.blockCavalry;
				}
				if (data.canBuy!=null) {
					this.canBuy = data.canBuy;
				}
				if (data.heavyArmor!=null) {
					this.heavyArmor = data.heavyArmor;
				}
			}
		}
		

		public var attack:int;
		public var attackTimes:int;
		public var damage:int;
		public var defence:int;
		public var funcDesc:String;
		public var iconUrl:String;
		public var itemDesc:String;
		public var level:int;
		public var life:int;
		public var name:String;
		public var part:int;
		public var price:int;
		public var sort:int;
		public var title:int;
		public var type:String;
		public var arrowRain:Boolean;
		public var blockCavalry:Boolean;
		public var canBuy:Boolean;
		public var heavyArmor:Boolean;

		public function copyToBe(target:EquipBean):void {
			target.attack = this.attack 
			target.attackTimes = this.attackTimes 
			target.damage = this.damage 
			target.defence = this.defence 
			target.funcDesc = this.funcDesc 
			target.iconUrl = this.iconUrl 
			target.itemDesc = this.itemDesc 
			target.level = this.level 
			target.life = this.life 
			target.name = this.name 
			target.part = this.part 
			target.price = this.price 
			target.sort = this.sort 
			target.title = this.title 
			target.type = this.type 
			target.arrowRain = this.arrowRain 
			target.blockCavalry = this.blockCavalry 
			target.canBuy = this.canBuy 
			target.heavyArmor = this.heavyArmor 
		}
		
		public function toBeObject():Object {
			var obj:Object = new Object();
			obj.attack = this.attack;
			obj.attackTimes = this.attackTimes;
			obj.damage = this.damage;
			obj.defence = this.defence;
			obj.funcDesc = this.funcDesc;
			obj.iconUrl = this.iconUrl;
			obj.itemDesc = this.itemDesc;
			obj.level = this.level;
			obj.life = this.life;
			obj.name = this.name;
			obj.part = this.part;
			obj.price = this.price;
			obj.sort = this.sort;
			obj.title = this.title;
			obj.type = this.type;
			obj.arrowRain = this.arrowRain;
			obj.blockCavalry = this.blockCavalry;
			obj.canBuy = this.canBuy;
			obj.heavyArmor = this.heavyArmor;
			return obj;
		}

		public function toBeString(pre:String=""):String {
			var str:String = "";
			str += pre + "attack = " + this.attack + "\n" ;
			str += pre + "attackTimes = " + this.attackTimes + "\n" ;
			str += pre + "damage = " + this.damage + "\n" ;
			str += pre + "defence = " + this.defence + "\n" ;
			str += pre + "funcDesc = " + this.funcDesc + "\n" ;
			str += pre + "iconUrl = " + this.iconUrl + "\n" ;
			str += pre + "itemDesc = " + this.itemDesc + "\n" ;
			str += pre + "level = " + this.level + "\n" ;
			str += pre + "life = " + this.life + "\n" ;
			str += pre + "name = " + this.name + "\n" ;
			str += pre + "part = " + this.part + "\n" ;
			str += pre + "price = " + this.price + "\n" ;
			str += pre + "sort = " + this.sort + "\n" ;
			str += pre + "title = " + this.title + "\n" ;
			str += pre + "type = " + this.type + "\n" ;
			str += pre + "arrowRain = " + this.arrowRain + "\n" ;
			str += pre + "blockCavalry = " + this.blockCavalry + "\n" ;
			str += pre + "canBuy = " + this.canBuy + "\n" ;
			str += pre + "heavyArmor = " + this.heavyArmor + "\n" ;

			return str;  
		}
	}
}