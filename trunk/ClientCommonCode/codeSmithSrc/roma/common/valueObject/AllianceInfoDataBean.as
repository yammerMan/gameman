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
	public class AllianceInfoDataBean
	{
		public function AllianceInfoDataBean(data:Object=null)
		{
			if (data!=null){
				if (data.allianceDesc!=null) {
					this.allianceDesc = data.allianceDesc;
				}
				if (data.allianceLev!=null) {
					this.allianceLev = data.allianceLev;
				}
				if (data.allianceUrl!=null) {
					this.allianceUrl = data.allianceUrl;
				}
				if (data.createTime!=null) {
					this.createTime = data.createTime;
				}
				if (data.creator!=null) {
					this.creator = data.creator;
				}
				if (data.foods!=null) {
					this.foods = data.foods;
				}
				if (data.golds!=null) {
					this.golds = data.golds;
				}
				if (data.introduce!=null) {
					this.introduce = data.introduce;
				}
				if (data.irons!=null) {
					this.irons = data.irons;
				}
				if (data.leader!=null) {
					this.leader = data.leader;
				}
				if (data.leagueNote!=null) {
					this.leagueNote = data.leagueNote;
				}
				if (data.limit!=null) {
					this.limit = data.limit;
				}
				if (data.limitPrestige!=null) {
					this.limitPrestige = data.limitPrestige;
				}
				if (data.logoCode!=null) {
					this.logoCode = data.logoCode;
				}
				if (data.members!=null) {
					this.members = data.members;
				}
				if (data.name!=null) {
					this.name = data.name;
				}
				if (data.prestiges!=null) {
					this.prestiges = data.prestiges;
				}
				if (data.rank!=null) {
					this.rank = data.rank;
				}
				if (data.spend!=null) {
					this.spend = data.spend;
				}
				if (data.stones!=null) {
					this.stones = data.stones;
				}
				if (data.totalHonor!=null) {
					this.totalHonor = data.totalHonor;
				}
				if (data.woods!=null) {
					this.woods = data.woods;
				}
			}
		}
		

		public var allianceDesc:String;
		public var allianceLev:int;
		public var allianceUrl:String;
		public var createTime:Number;
		public var creator:String;
		public var foods:int;
		public var golds:int;
		public var introduce:String;
		public var irons:int;
		public var leader:String;
		public var leagueNote:String;
		public var limit:int;
		public var limitPrestige:int;
		public var logoCode:int;
		public var members:int;
		public var name:String;
		public var prestiges:int;
		public var rank:int;
		public var spend:int;
		public var stones:int;
		public var totalHonor:Number;
		public var woods:int;

		public function copyToBe(target:AllianceInfoDataBean):void {
			target.allianceDesc = this.allianceDesc 
			target.allianceLev = this.allianceLev 
			target.allianceUrl = this.allianceUrl 
			target.createTime = this.createTime 
			target.creator = this.creator 
			target.foods = this.foods 
			target.golds = this.golds 
			target.introduce = this.introduce 
			target.irons = this.irons 
			target.leader = this.leader 
			target.leagueNote = this.leagueNote 
			target.limit = this.limit 
			target.limitPrestige = this.limitPrestige 
			target.logoCode = this.logoCode 
			target.members = this.members 
			target.name = this.name 
			target.prestiges = this.prestiges 
			target.rank = this.rank 
			target.spend = this.spend 
			target.stones = this.stones 
			target.totalHonor = this.totalHonor 
			target.woods = this.woods 
		}
		
		public function toBeObject():Object {
			var obj:Object = new Object();
			obj.allianceDesc = this.allianceDesc;
			obj.allianceLev = this.allianceLev;
			obj.allianceUrl = this.allianceUrl;
			obj.createTime = this.createTime;
			obj.creator = this.creator;
			obj.foods = this.foods;
			obj.golds = this.golds;
			obj.introduce = this.introduce;
			obj.irons = this.irons;
			obj.leader = this.leader;
			obj.leagueNote = this.leagueNote;
			obj.limit = this.limit;
			obj.limitPrestige = this.limitPrestige;
			obj.logoCode = this.logoCode;
			obj.members = this.members;
			obj.name = this.name;
			obj.prestiges = this.prestiges;
			obj.rank = this.rank;
			obj.spend = this.spend;
			obj.stones = this.stones;
			obj.totalHonor = this.totalHonor;
			obj.woods = this.woods;
			return obj;
		}

		public function toBeString(pre:String=""):String {
			var str:String = "";
			str += pre + "allianceDesc = " + this.allianceDesc + "\n" ;
			str += pre + "allianceLev = " + this.allianceLev + "\n" ;
			str += pre + "allianceUrl = " + this.allianceUrl + "\n" ;
			str += pre + "createTime = " + this.createTime + "\n" ;
			str += pre + "creator = " + this.creator + "\n" ;
			str += pre + "foods = " + this.foods + "\n" ;
			str += pre + "golds = " + this.golds + "\n" ;
			str += pre + "introduce = " + this.introduce + "\n" ;
			str += pre + "irons = " + this.irons + "\n" ;
			str += pre + "leader = " + this.leader + "\n" ;
			str += pre + "leagueNote = " + this.leagueNote + "\n" ;
			str += pre + "limit = " + this.limit + "\n" ;
			str += pre + "limitPrestige = " + this.limitPrestige + "\n" ;
			str += pre + "logoCode = " + this.logoCode + "\n" ;
			str += pre + "members = " + this.members + "\n" ;
			str += pre + "name = " + this.name + "\n" ;
			str += pre + "prestiges = " + this.prestiges + "\n" ;
			str += pre + "rank = " + this.rank + "\n" ;
			str += pre + "spend = " + this.spend + "\n" ;
			str += pre + "stones = " + this.stones + "\n" ;
			str += pre + "totalHonor = " + this.totalHonor + "\n" ;
			str += pre + "woods = " + this.woods + "\n" ;

			return str;  
		}
	}
}