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
	public class OtherArmyBean
	{
		public function OtherArmyBean(data:Object=null)
		{
			if (data!=null){
				if (data.arriveTime!=null) {
					this.arriveTime = data.arriveTime;
				}
				if (data.castleFieldId!=null) {
					this.castleFieldId = data.castleFieldId;
				}
				if (data.castleName!=null) {
					this.castleName = data.castleName;
				}
				if (data.cityId!=null) {
					this.cityId = data.cityId;
				}
				if (data.heroInfo!=null) {
					this.heroInfo = new HeroInfoBean(data.heroInfo);
				}
				if (data.king!=null) {
					this.king = data.king;
				}
				if (data.leagueName!=null) {
					this.leagueName = data.leagueName;
				}
				if (data.mission!=null) {
					this.mission = data.mission;
				}
				if (data.status!=null) {
					this.status = data.status;
				}
				if (data.targetFieldId!=null) {
					this.targetFieldId = data.targetFieldId;
				}
				if (data.targetFieldName!=null) {
					this.targetFieldName = data.targetFieldName;
				}
				if (data.targetFieldType!=null) {
					this.targetFieldType = data.targetFieldType;
				}
				if (data.attacker!=null) {
					this.attacker = data.attacker;
				}
				if (data.hostCastleArmy!=null) {
					this.hostCastleArmy = data.hostCastleArmy;
				}
			
				var n:int;
				if (data.troops) {
					for (n=0; n<data.troops.length; n++) {
						var _troops:HeroTroopBean = new HeroTroopBean(data.troops[n]);
						this.troopsArray.addItem(_troops);
					}
				}
			
			}
		}
		

		public var arriveTime:Number;
		public var castleFieldId:int;
		public var castleName:String;
		public var cityId:int;
		public var heroInfo:HeroInfoBean;
		public var king:String;
		public var leagueName:String;
		public var mission:int;
		public var status:int;
		public var targetFieldId:int;
		public var targetFieldName:String;
		public var targetFieldType:int;
		public var attacker:Boolean;
		public var hostCastleArmy:Boolean;

		public var troopsArray:ArrayCollection = new ArrayCollection();
			
		public function getTroops(index:int):HeroTroopBean {
			var res:HeroTroopBean = HeroTroopBean(this.troopsArray[index]);
			return res; 
		}
		public function setTroops(bean:HeroTroopBean, index:int):void {
			this.troopsArray[index] = bean;
		}

		public function copyToBe(target:OtherArmyBean):void {
			target.arriveTime = this.arriveTime 
			target.castleFieldId = this.castleFieldId 
			target.castleName = this.castleName 
			target.cityId = this.cityId 
			if (heroInfo!=null) {
				this.heroInfo.copyToBe(target.heroInfo)
			} else {
				target.heroInfo = null;
			}
			target.king = this.king 
			target.leagueName = this.leagueName 
			target.mission = this.mission 
			target.status = this.status 
			target.targetFieldId = this.targetFieldId 
			target.targetFieldName = this.targetFieldName 
			target.targetFieldType = this.targetFieldType 
			target.attacker = this.attacker 
			target.hostCastleArmy = this.hostCastleArmy 
		}
		
		public function toBeObject():Object {
			var obj:Object = new Object();
			obj.arriveTime = this.arriveTime;
			obj.castleFieldId = this.castleFieldId;
			obj.castleName = this.castleName;
			obj.cityId = this.cityId;
			obj.heroInfo = this.heroInfo.toBeObject();
			obj.king = this.king;
			obj.leagueName = this.leagueName;
			obj.mission = this.mission;
			obj.status = this.status;
			obj.targetFieldId = this.targetFieldId;
			obj.targetFieldName = this.targetFieldName;
			obj.targetFieldType = this.targetFieldType;
			obj.attacker = this.attacker;
			obj.hostCastleArmy = this.hostCastleArmy;
			return obj;
		}

		public function toBeString(pre:String=""):String {
			var str:String = "";
			str += pre + "arriveTime = " + this.arriveTime + "\n" ;
			str += pre + "castleFieldId = " + this.castleFieldId + "\n" ;
			str += pre + "castleName = " + this.castleName + "\n" ;
			str += pre + "cityId = " + this.cityId + "\n" ;
			if (heroInfo!=null) {
				str += this.heroInfo.toBeString(pre + "heroInfo.") ;
			} else {
				str += pre + "heroInfo = null\n" ;
			}
			str += pre + "king = " + this.king + "\n" ;
			str += pre + "leagueName = " + this.leagueName + "\n" ;
			str += pre + "mission = " + this.mission + "\n" ;
			str += pre + "status = " + this.status + "\n" ;
			str += pre + "targetFieldId = " + this.targetFieldId + "\n" ;
			str += pre + "targetFieldName = " + this.targetFieldName + "\n" ;
			str += pre + "targetFieldType = " + this.targetFieldType + "\n" ;
			str += pre + "attacker = " + this.attacker + "\n" ;
			str += pre + "hostCastleArmy = " + this.hostCastleArmy + "\n" ;

			var i:int;
			for (i=0; i<this.troopsArray.length; i++) {
				str += this.getTroops(i).toBeString(pre + "troops[" + i + "].") ;
			}
			

			return str;  
		}
	}
}