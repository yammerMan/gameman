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
	public class SimpleMapCastleBean
	{
		public function SimpleMapCastleBean(data:Object=null)
		{
			if (data!=null){
				if (data.allianceLogo!=null) {
					this.allianceLogo = data.allianceLogo;
				}
				if (data.castleName!=null) {
					this.castleName = data.castleName;
				}
				if (data.cityId!=null) {
					this.cityId = data.cityId;
				}
				if (data.expandLevel!=null) {
					this.expandLevel = data.expandLevel;
				}
				if (data.fieldId!=null) {
					this.fieldId = data.fieldId;
				}
				if (data.flag!=null) {
					this.flag = data.flag;
				}
				if (data.hostFlag!=null) {
					this.hostFlag = data.hostFlag;
				}
				if (data.hostRelation!=null) {
					this.hostRelation = data.hostRelation;
				}
				if (data.leagueName!=null) {
					this.leagueName = data.leagueName;
				}
				if (data.level!=null) {
					this.level = data.level;
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
			
				var n:int;
				if (data.uiBuffs) {
					for (n=0; n<data.uiBuffs.length; n++) {
						var _uiBuffs:int = new int(data.uiBuffs[n]);
						this.uiBuffsArray.addItem(_uiBuffs);
					}
				}
			
			}
		}
		

		public var allianceLogo:int;
		public var castleName:String;
		public var cityId:int;
		public var expandLevel:int;
		public var fieldId:int;
		public var flag:String;
		public var hostFlag:String;
		public var hostRelation:int;
		public var leagueName:String;
		public var level:int;
		public var playerName:String;
		public var prestiges:int;
		public var relation:int;

		public var uiBuffsArray:ArrayCollection = new ArrayCollection();
			
		public function getUiBuffs(index:int):int {
			var res:int = int(this.uiBuffsArray[index]);
			return res; 
		}
		public function setUiBuffs(bean:int, index:int):void {
			this.uiBuffsArray[index] = bean;
		}

		public function copyToBe(target:SimpleMapCastleBean):void {
			target.allianceLogo = this.allianceLogo 
			target.castleName = this.castleName 
			target.cityId = this.cityId 
			target.expandLevel = this.expandLevel 
			target.fieldId = this.fieldId 
			target.flag = this.flag 
			target.hostFlag = this.hostFlag 
			target.hostRelation = this.hostRelation 
			target.leagueName = this.leagueName 
			target.level = this.level 
			target.playerName = this.playerName 
			target.prestiges = this.prestiges 
			target.relation = this.relation 
		}
		
		public function toBeObject():Object {
			var obj:Object = new Object();
			obj.allianceLogo = this.allianceLogo;
			obj.castleName = this.castleName;
			obj.cityId = this.cityId;
			obj.expandLevel = this.expandLevel;
			obj.fieldId = this.fieldId;
			obj.flag = this.flag;
			obj.hostFlag = this.hostFlag;
			obj.hostRelation = this.hostRelation;
			obj.leagueName = this.leagueName;
			obj.level = this.level;
			obj.playerName = this.playerName;
			obj.prestiges = this.prestiges;
			obj.relation = this.relation;
			return obj;
		}

		public function toBeString(pre:String=""):String {
			var str:String = "";
			str += pre + "allianceLogo = " + this.allianceLogo + "\n" ;
			str += pre + "castleName = " + this.castleName + "\n" ;
			str += pre + "cityId = " + this.cityId + "\n" ;
			str += pre + "expandLevel = " + this.expandLevel + "\n" ;
			str += pre + "fieldId = " + this.fieldId + "\n" ;
			str += pre + "flag = " + this.flag + "\n" ;
			str += pre + "hostFlag = " + this.hostFlag + "\n" ;
			str += pre + "hostRelation = " + this.hostRelation + "\n" ;
			str += pre + "leagueName = " + this.leagueName + "\n" ;
			str += pre + "level = " + this.level + "\n" ;
			str += pre + "playerName = " + this.playerName + "\n" ;
			str += pre + "prestiges = " + this.prestiges + "\n" ;
			str += pre + "relation = " + this.relation + "\n" ;

			var i:int;
			for (i=0; i<this.uiBuffsArray.length; i++) {
				str += pre + "uiBuffs[" + i + "] = " + this.getUiBuffs(i) + "\n" ; 
			}
			

			return str;  
		}
	}
}