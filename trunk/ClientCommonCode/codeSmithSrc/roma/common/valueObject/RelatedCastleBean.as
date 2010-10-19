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
	public class RelatedCastleBean
	{
		public function RelatedCastleBean(data:Object=null)
		{
			if (data!=null){
				if (data.beConquestedTimes!=null) {
					this.beConquestedTimes = data.beConquestedTimes;
				}
				if (data.castleLevel!=null) {
					this.castleLevel = data.castleLevel;
				}
				if (data.castleName!=null) {
					this.castleName = data.castleName;
				}
				if (data.cityId!=null) {
					this.cityId = data.cityId;
				}
				if (data.fieldId!=null) {
					this.fieldId = data.fieldId;
				}
				if (data.leagueName!=null) {
					this.leagueName = data.leagueName;
				}
				if (data.playerLogo!=null) {
					this.playerLogo = data.playerLogo;
				}
				if (data.playerName!=null) {
					this.playerName = data.playerName;
				}
				if (data.playerSignature!=null) {
					this.playerSignature = data.playerSignature;
				}
				if (data.population!=null) {
					this.population = data.population;
				}
				if (data.conquestByWar!=null) {
					this.conquestByWar = data.conquestByWar;
				}
			}
		}
		

		public var beConquestedTimes:int;
		public var castleLevel:int;
		public var castleName:String;
		public var cityId:int;
		public var fieldId:int;
		public var leagueName:String;
		public var playerLogo:String;
		public var playerName:String;
		public var playerSignature:String;
		public var population:int;
		public var conquestByWar:Boolean;

		public function copyToBe(target:RelatedCastleBean):void {
			target.beConquestedTimes = this.beConquestedTimes 
			target.castleLevel = this.castleLevel 
			target.castleName = this.castleName 
			target.cityId = this.cityId 
			target.fieldId = this.fieldId 
			target.leagueName = this.leagueName 
			target.playerLogo = this.playerLogo 
			target.playerName = this.playerName 
			target.playerSignature = this.playerSignature 
			target.population = this.population 
			target.conquestByWar = this.conquestByWar 
		}
		
		public function toBeObject():Object {
			var obj:Object = new Object();
			obj.beConquestedTimes = this.beConquestedTimes;
			obj.castleLevel = this.castleLevel;
			obj.castleName = this.castleName;
			obj.cityId = this.cityId;
			obj.fieldId = this.fieldId;
			obj.leagueName = this.leagueName;
			obj.playerLogo = this.playerLogo;
			obj.playerName = this.playerName;
			obj.playerSignature = this.playerSignature;
			obj.population = this.population;
			obj.conquestByWar = this.conquestByWar;
			return obj;
		}

		public function toBeString(pre:String=""):String {
			var str:String = "";
			str += pre + "beConquestedTimes = " + this.beConquestedTimes + "\n" ;
			str += pre + "castleLevel = " + this.castleLevel + "\n" ;
			str += pre + "castleName = " + this.castleName + "\n" ;
			str += pre + "cityId = " + this.cityId + "\n" ;
			str += pre + "fieldId = " + this.fieldId + "\n" ;
			str += pre + "leagueName = " + this.leagueName + "\n" ;
			str += pre + "playerLogo = " + this.playerLogo + "\n" ;
			str += pre + "playerName = " + this.playerName + "\n" ;
			str += pre + "playerSignature = " + this.playerSignature + "\n" ;
			str += pre + "population = " + this.population + "\n" ;
			str += pre + "conquestByWar = " + this.conquestByWar + "\n" ;

			return str;  
		}
	}
}