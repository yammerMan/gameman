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
	public class PlayerInfoDataBean
	{
		public function PlayerInfoDataBean(data:Object=null)
		{
			if (data!=null){
				if (data.accountName!=null) {
					this.accountName = data.accountName;
				}
				if (data.allianceContribute!=null) {
					this.allianceContribute = data.allianceContribute;
				}
				if (data.allianceLogo!=null) {
					this.allianceLogo = data.allianceLogo;
				}
				if (data.allianceRight!=null) {
					this.allianceRight = data.allianceRight;
				}
				if (data.attackScore!=null) {
					this.attackScore = data.attackScore;
				}
				if (data.attackUpgrade!=null) {
					this.attackUpgrade = data.attackUpgrade;
				}
				if (data.cityCount!=null) {
					this.cityCount = data.cityCount;
				}
				if (data.coin!=null) {
					this.coin = data.coin;
				}
				if (data.conquestCastleCount!=null) {
					this.conquestCastleCount = data.conquestCastleCount;
				}
				if (data.createTime!=null) {
					this.createTime = data.createTime;
				}
				if (data.credit!=null) {
					this.credit = data.credit;
				}
				if (data.defenceUpgrade!=null) {
					this.defenceUpgrade = data.defenceUpgrade;
				}
				if (data.defendScore!=null) {
					this.defendScore = data.defendScore;
				}
				if (data.flag!=null) {
					this.flag = data.flag;
				}
				if (data.honor!=null) {
					this.honor = data.honor;
				}
				if (data.id!=null) {
					this.id = data.id;
				}
				if (data.lastFreeSentenceTime!=null) {
					this.lastFreeSentenceTime = data.lastFreeSentenceTime;
				}
				if (data.lastLoginInTime!=null) {
					this.lastLoginInTime = data.lastLoginInTime;
				}
				if (data.lastLoginIp!=null) {
					this.lastLoginIp = data.lastLoginIp;
				}
				if (data.lastLogoutTime!=null) {
					this.lastLogoutTime = data.lastLogoutTime;
				}
				if (data.leagueName!=null) {
					this.leagueName = data.leagueName;
				}
				if (data.logoUrl!=null) {
					this.logoUrl = data.logoUrl;
				}
				if (data.maxPopu!=null) {
					this.maxPopu = data.maxPopu;
				}
				if (data.playerName!=null) {
					this.playerName = data.playerName;
				}
				if (data.playerStatus!=null) {
					this.playerStatus = data.playerStatus;
				}
				if (data.population!=null) {
					this.population = data.population;
				}
				if (data.prestiges!=null) {
					this.prestiges = data.prestiges;
				}
				if (data.rank!=null) {
					this.rank = data.rank;
				}
				if (data.sex!=null) {
					this.sex = data.sex;
				}
				if (data.signature!=null) {
					this.signature = data.signature;
				}
				if (data.title!=null) {
					this.title = data.title;
				}
				if (data.totalPay!=null) {
					this.totalPay = data.totalPay;
				}
				if (data.totalTroopCostFood!=null) {
					this.totalTroopCostFood = data.totalTroopCostFood;
				}
				if (data.everChangeLogo!=null) {
					this.everChangeLogo = data.everChangeLogo;
				}
				if (data.online!=null) {
					this.online = data.online;
				}
			}
		}
		

		public var accountName:String;
		public var allianceContribute:Number;
		public var allianceLogo:int;
		public var allianceRight:int;
		public var attackScore:int;
		public var attackUpgrade:int;
		public var cityCount:int;
		public var coin:int;
		public var conquestCastleCount:int;
		public var createTime:Number;
		public var credit:int;
		public var defenceUpgrade:int;
		public var defendScore:int;
		public var flag:String;
		public var honor:int;
		public var id:int;
		public var lastFreeSentenceTime:Number;
		public var lastLoginInTime:Number;
		public var lastLoginIp:String;
		public var lastLogoutTime:Number;
		public var leagueName:String;
		public var logoUrl:String;
		public var maxPopu:int;
		public var playerName:String;
		public var playerStatus:int;
		public var population:int;
		public var prestiges:int;
		public var rank:int;
		public var sex:int;
		public var signature:String;
		public var title:int;
		public var totalPay:int;
		public var totalTroopCostFood:int;
		public var everChangeLogo:Boolean;
		public var online:Boolean;

		public function copyToBe(target:PlayerInfoDataBean):void {
			target.accountName = this.accountName 
			target.allianceContribute = this.allianceContribute 
			target.allianceLogo = this.allianceLogo 
			target.allianceRight = this.allianceRight 
			target.attackScore = this.attackScore 
			target.attackUpgrade = this.attackUpgrade 
			target.cityCount = this.cityCount 
			target.coin = this.coin 
			target.conquestCastleCount = this.conquestCastleCount 
			target.createTime = this.createTime 
			target.credit = this.credit 
			target.defenceUpgrade = this.defenceUpgrade 
			target.defendScore = this.defendScore 
			target.flag = this.flag 
			target.honor = this.honor 
			target.id = this.id 
			target.lastFreeSentenceTime = this.lastFreeSentenceTime 
			target.lastLoginInTime = this.lastLoginInTime 
			target.lastLoginIp = this.lastLoginIp 
			target.lastLogoutTime = this.lastLogoutTime 
			target.leagueName = this.leagueName 
			target.logoUrl = this.logoUrl 
			target.maxPopu = this.maxPopu 
			target.playerName = this.playerName 
			target.playerStatus = this.playerStatus 
			target.population = this.population 
			target.prestiges = this.prestiges 
			target.rank = this.rank 
			target.sex = this.sex 
			target.signature = this.signature 
			target.title = this.title 
			target.totalPay = this.totalPay 
			target.totalTroopCostFood = this.totalTroopCostFood 
			target.everChangeLogo = this.everChangeLogo 
			target.online = this.online 
		}
		
		public function toBeObject():Object {
			var obj:Object = new Object();
			obj.accountName = this.accountName;
			obj.allianceContribute = this.allianceContribute;
			obj.allianceLogo = this.allianceLogo;
			obj.allianceRight = this.allianceRight;
			obj.attackScore = this.attackScore;
			obj.attackUpgrade = this.attackUpgrade;
			obj.cityCount = this.cityCount;
			obj.coin = this.coin;
			obj.conquestCastleCount = this.conquestCastleCount;
			obj.createTime = this.createTime;
			obj.credit = this.credit;
			obj.defenceUpgrade = this.defenceUpgrade;
			obj.defendScore = this.defendScore;
			obj.flag = this.flag;
			obj.honor = this.honor;
			obj.id = this.id;
			obj.lastFreeSentenceTime = this.lastFreeSentenceTime;
			obj.lastLoginInTime = this.lastLoginInTime;
			obj.lastLoginIp = this.lastLoginIp;
			obj.lastLogoutTime = this.lastLogoutTime;
			obj.leagueName = this.leagueName;
			obj.logoUrl = this.logoUrl;
			obj.maxPopu = this.maxPopu;
			obj.playerName = this.playerName;
			obj.playerStatus = this.playerStatus;
			obj.population = this.population;
			obj.prestiges = this.prestiges;
			obj.rank = this.rank;
			obj.sex = this.sex;
			obj.signature = this.signature;
			obj.title = this.title;
			obj.totalPay = this.totalPay;
			obj.totalTroopCostFood = this.totalTroopCostFood;
			obj.everChangeLogo = this.everChangeLogo;
			obj.online = this.online;
			return obj;
		}

		public function toBeString(pre:String=""):String {
			var str:String = "";
			str += pre + "accountName = " + this.accountName + "\n" ;
			str += pre + "allianceContribute = " + this.allianceContribute + "\n" ;
			str += pre + "allianceLogo = " + this.allianceLogo + "\n" ;
			str += pre + "allianceRight = " + this.allianceRight + "\n" ;
			str += pre + "attackScore = " + this.attackScore + "\n" ;
			str += pre + "attackUpgrade = " + this.attackUpgrade + "\n" ;
			str += pre + "cityCount = " + this.cityCount + "\n" ;
			str += pre + "coin = " + this.coin + "\n" ;
			str += pre + "conquestCastleCount = " + this.conquestCastleCount + "\n" ;
			str += pre + "createTime = " + this.createTime + "\n" ;
			str += pre + "credit = " + this.credit + "\n" ;
			str += pre + "defenceUpgrade = " + this.defenceUpgrade + "\n" ;
			str += pre + "defendScore = " + this.defendScore + "\n" ;
			str += pre + "flag = " + this.flag + "\n" ;
			str += pre + "honor = " + this.honor + "\n" ;
			str += pre + "id = " + this.id + "\n" ;
			str += pre + "lastFreeSentenceTime = " + this.lastFreeSentenceTime + "\n" ;
			str += pre + "lastLoginInTime = " + this.lastLoginInTime + "\n" ;
			str += pre + "lastLoginIp = " + this.lastLoginIp + "\n" ;
			str += pre + "lastLogoutTime = " + this.lastLogoutTime + "\n" ;
			str += pre + "leagueName = " + this.leagueName + "\n" ;
			str += pre + "logoUrl = " + this.logoUrl + "\n" ;
			str += pre + "maxPopu = " + this.maxPopu + "\n" ;
			str += pre + "playerName = " + this.playerName + "\n" ;
			str += pre + "playerStatus = " + this.playerStatus + "\n" ;
			str += pre + "population = " + this.population + "\n" ;
			str += pre + "prestiges = " + this.prestiges + "\n" ;
			str += pre + "rank = " + this.rank + "\n" ;
			str += pre + "sex = " + this.sex + "\n" ;
			str += pre + "signature = " + this.signature + "\n" ;
			str += pre + "title = " + this.title + "\n" ;
			str += pre + "totalPay = " + this.totalPay + "\n" ;
			str += pre + "totalTroopCostFood = " + this.totalTroopCostFood + "\n" ;
			str += pre + "everChangeLogo = " + this.everChangeLogo + "\n" ;
			str += pre + "online = " + this.online + "\n" ;

			return str;  
		}
	}
}