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
	
	public class ServerInfoEvent extends BaseResponse
	{
		public function ServerInfoEvent(type:String, data:Object,bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.setResponseData(data);
				if (data.currentTime!=null) {
					this.currentTime = data.currentTime;
				}
				if (data.currentTimeStr!=null) {
					this.currentTimeStr = data.currentTimeStr;
				}
				if (data.resFood!=null) {
					this.resFood = data.resFood;
				}
				if (data.resGold!=null) {
					this.resGold = data.resGold;
				}
				if (data.resIron!=null) {
					this.resIron = data.resIron;
				}
				if (data.resItem!=null) {
					this.resItem = data.resItem;
				}
				if (data.resStone!=null) {
					this.resStone = data.resStone;
				}
				if (data.resWood!=null) {
					this.resWood = data.resWood;
				}
				if (data.serverName!=null) {
					this.serverName = data.serverName;
				}
				if (data.speed!=null) {
					this.speed = data.speed;
				}
				if (data.timezoneHour!=null) {
					this.timezoneHour = data.timezoneHour;
				}
			
				var n:int;
				if (data.equips) {
					for (n=0; n<data.equips.length; n++) {
						var _equips:EquipBean = new EquipBean(data.equips[n]);
						this.equipsArray.addItem(_equips);
					}
				}
			
				if (data.goldLimits) {
					for (n=0; n<data.goldLimits.length; n++) {
						var _goldLimits:int = new int(data.goldLimits[n]);
						this.goldLimitsArray.addItem(_goldLimits);
					}
				}
			
				if (data.goldProtectPers) {
					for (n=0; n<data.goldProtectPers.length; n++) {
						var _goldProtectPers:int = new int(data.goldProtectPers[n]);
						this.goldProtectPersArray.addItem(_goldProtectPers);
					}
				}
			
				if (data.typeNpcIds) {
					for (n=0; n<data.typeNpcIds.length; n++) {
						var _typeNpcIds:TypeNpcIdsBean = new TypeNpcIdsBean(data.typeNpcIds[n]);
						this.typeNpcIdsArray.addItem(_typeNpcIds);
					}
				}
			
		}

		public var currentTime:Number;
		public var currentTimeStr:String;
		public var resFood:int;
		public var resGold:int;
		public var resIron:int;
		public var resItem:int;
		public var resStone:int;
		public var resWood:int;
		public var serverName:String;
		public var speed:int;
		public var timezoneHour:int;

		public var equipsArray:ArrayCollection = new ArrayCollection();
		public var goldLimitsArray:ArrayCollection = new ArrayCollection();
		public var goldProtectPersArray:ArrayCollection = new ArrayCollection();
		public var typeNpcIdsArray:ArrayCollection = new ArrayCollection();
			
		public function getEquips(index:int):EquipBean {
			var res:EquipBean = EquipBean(this.equipsArray[index]);
			return res; 
		}
		public function setEquips(bean:EquipBean, index:int):void {
			this.equipsArray[index] = bean;
		}
		public function getGoldLimits(index:int):int {
			var res:int = int(this.goldLimitsArray[index]);
			return res; 
		}
		public function setGoldLimits(bean:int, index:int):void {
			this.goldLimitsArray[index] = bean;
		}
		public function getGoldProtectPers(index:int):int {
			var res:int = int(this.goldProtectPersArray[index]);
			return res; 
		}
		public function setGoldProtectPers(bean:int, index:int):void {
			this.goldProtectPersArray[index] = bean;
		}
		public function getTypeNpcIds(index:int):TypeNpcIdsBean {
			var res:TypeNpcIdsBean = TypeNpcIdsBean(this.typeNpcIdsArray[index]);
			return res; 
		}
		public function setTypeNpcIds(bean:TypeNpcIdsBean, index:int):void {
			this.typeNpcIdsArray[index] = bean;
		}

		public function copyToBe(target:ServerInfoEvent):void {
			target.currentTime = this.currentTime 
			target.currentTimeStr = this.currentTimeStr 
			target.resFood = this.resFood 
			target.resGold = this.resGold 
			target.resIron = this.resIron 
			target.resItem = this.resItem 
			target.resStone = this.resStone 
			target.resWood = this.resWood 
			target.serverName = this.serverName 
			target.speed = this.speed 
			target.timezoneHour = this.timezoneHour 
		}
		
		public function toBeObject():Object {
			var obj:Object = new Object();
			obj.currentTime = this.currentTime;
			obj.currentTimeStr = this.currentTimeStr;
			obj.resFood = this.resFood;
			obj.resGold = this.resGold;
			obj.resIron = this.resIron;
			obj.resItem = this.resItem;
			obj.resStone = this.resStone;
			obj.resWood = this.resWood;
			obj.serverName = this.serverName;
			obj.speed = this.speed;
			obj.timezoneHour = this.timezoneHour;
			return obj;
		}

		public override function toBeString(pre:String=""):String {
			var str:String = "---- ServerInfoEvent ----\n"  + this.toBeErrorString();
			str += pre + "currentTime = " + this.currentTime + "\n" ;
			str += pre + "currentTimeStr = " + this.currentTimeStr + "\n" ;
			str += pre + "resFood = " + this.resFood + "\n" ;
			str += pre + "resGold = " + this.resGold + "\n" ;
			str += pre + "resIron = " + this.resIron + "\n" ;
			str += pre + "resItem = " + this.resItem + "\n" ;
			str += pre + "resStone = " + this.resStone + "\n" ;
			str += pre + "resWood = " + this.resWood + "\n" ;
			str += pre + "serverName = " + this.serverName + "\n" ;
			str += pre + "speed = " + this.speed + "\n" ;
			str += pre + "timezoneHour = " + this.timezoneHour + "\n" ;

			var i:int;
			for (i=0; i<this.equipsArray.length; i++) {
				str += this.getEquips(i).toBeString(pre + "equips[" + i + "].") ;
			}
			
			for (i=0; i<this.goldLimitsArray.length; i++) {
				str += pre + "goldLimits[" + i + "] = " + this.getGoldLimits(i) + "\n" ; 
			}
			
			for (i=0; i<this.goldProtectPersArray.length; i++) {
				str += pre + "goldProtectPers[" + i + "] = " + this.getGoldProtectPers(i) + "\n" ; 
			}
			
			for (i=0; i<this.typeNpcIdsArray.length; i++) {
				str += this.getTypeNpcIds(i).toBeString(pre + "typeNpcIds[" + i + "].") ;
			}
			

			return str;  
		}
	}
}