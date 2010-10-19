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
	public class MapFieldInfoBean
	{
		public function MapFieldInfoBean(data:Object=null)
		{
			if (data!=null){
				if (data.allianceLogo!=null) {
					this.allianceLogo = data.allianceLogo;
				}
				if (data.castleName!=null) {
					this.castleName = data.castleName;
				}
				if (data.castlePostion!=null) {
					this.castlePostion = data.castlePostion;
				}
				if (data.flag!=null) {
					this.flag = data.flag;
				}
				if (data.hostCastle!=null) {
					this.hostCastle = data.hostCastle;
				}
				if (data.hostFieldId!=null) {
					this.hostFieldId = data.hostFieldId;
				}
				if (data.hostPlayer!=null) {
					this.hostPlayer = data.hostPlayer;
				}
				if (data.hostRelation!=null) {
					this.hostRelation = data.hostRelation;
				}
				if (data.leagueName!=null) {
					this.leagueName = data.leagueName;
				}
				if (data.playerLogoUrl!=null) {
					this.playerLogoUrl = data.playerLogoUrl;
				}
				if (data.playerName!=null) {
					this.playerName = data.playerName;
				}
				if (data.prestiges!=null) {
					this.prestiges = data.prestiges;
				}
				if (data.relation!=null) {
					this.relation = data.relation;
				}
				if (data.status!=null) {
					this.status = data.status;
				}
				if (data.canAttack!=null) {
					this.canAttack = data.canAttack;
				}
				if (data.canReinforce!=null) {
					this.canReinforce = data.canReinforce;
				}
				if (data.inBattle!=null) {
					this.inBattle = data.inBattle;
				}
			}
		}
		

		public var allianceLogo:int;
		public var castleName:String;
		public var castlePostion:int;
		public var flag:String;
		public var hostCastle:String;
		public var hostFieldId:int;
		public var hostPlayer:String;
		public var hostRelation:int;
		public var leagueName:String;
		public var playerLogoUrl:String;
		public var playerName:String;
		public var prestiges:int;
		public var relation:int;
		public var status:int;
		public var canAttack:Boolean;
		public var canReinforce:Boolean;
		public var inBattle:Boolean;

		public function copyToBe(target:MapFieldInfoBean):void {
			target.allianceLogo = this.allianceLogo 
			target.castleName = this.castleName 
			target.castlePostion = this.castlePostion 
			target.flag = this.flag 
			target.hostCastle = this.hostCastle 
			target.hostFieldId = this.hostFieldId 
			target.hostPlayer = this.hostPlayer 
			target.hostRelation = this.hostRelation 
			target.leagueName = this.leagueName 
			target.playerLogoUrl = this.playerLogoUrl 
			target.playerName = this.playerName 
			target.prestiges = this.prestiges 
			target.relation = this.relation 
			target.status = this.status 
			target.canAttack = this.canAttack 
			target.canReinforce = this.canReinforce 
			target.inBattle = this.inBattle 
		}
		
		public function toBeObject():Object {
			var obj:Object = new Object();
			obj.allianceLogo = this.allianceLogo;
			obj.castleName = this.castleName;
			obj.castlePostion = this.castlePostion;
			obj.flag = this.flag;
			obj.hostCastle = this.hostCastle;
			obj.hostFieldId = this.hostFieldId;
			obj.hostPlayer = this.hostPlayer;
			obj.hostRelation = this.hostRelation;
			obj.leagueName = this.leagueName;
			obj.playerLogoUrl = this.playerLogoUrl;
			obj.playerName = this.playerName;
			obj.prestiges = this.prestiges;
			obj.relation = this.relation;
			obj.status = this.status;
			obj.canAttack = this.canAttack;
			obj.canReinforce = this.canReinforce;
			obj.inBattle = this.inBattle;
			return obj;
		}

		public function toBeString(pre:String=""):String {
			var str:String = "";
			str += pre + "allianceLogo = " + this.allianceLogo + "\n" ;
			str += pre + "castleName = " + this.castleName + "\n" ;
			str += pre + "castlePostion = " + this.castlePostion + "\n" ;
			str += pre + "flag = " + this.flag + "\n" ;
			str += pre + "hostCastle = " + this.hostCastle + "\n" ;
			str += pre + "hostFieldId = " + this.hostFieldId + "\n" ;
			str += pre + "hostPlayer = " + this.hostPlayer + "\n" ;
			str += pre + "hostRelation = " + this.hostRelation + "\n" ;
			str += pre + "leagueName = " + this.leagueName + "\n" ;
			str += pre + "playerLogoUrl = " + this.playerLogoUrl + "\n" ;
			str += pre + "playerName = " + this.playerName + "\n" ;
			str += pre + "prestiges = " + this.prestiges + "\n" ;
			str += pre + "relation = " + this.relation + "\n" ;
			str += pre + "status = " + this.status + "\n" ;
			str += pre + "canAttack = " + this.canAttack + "\n" ;
			str += pre + "canReinforce = " + this.canReinforce + "\n" ;
			str += pre + "inBattle = " + this.inBattle + "\n" ;

			return str;  
		}
	}
}