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
	public class RankLeagueBean
	{
		public function RankLeagueBean(data:Object=null)
		{
			if (data!=null){
				if (data.allianceId!=null) {
					this.allianceId = data.allianceId;
				}
				if (data.city!=null) {
					this.city = data.city;
				}
				if (data.creator!=null) {
					this.creator = data.creator;
				}
				if (data.desc!=null) {
					this.desc = data.desc;
				}
				if (data.honor!=null) {
					this.honor = data.honor;
				}
				if (data.leader!=null) {
					this.leader = data.leader;
				}
				if (data.level!=null) {
					this.level = data.level;
				}
				if (data.logo!=null) {
					this.logo = data.logo;
				}
				if (data.member!=null) {
					this.member = data.member;
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
			}
		}
		

		public var allianceId:int;
		public var city:int;
		public var creator:String;
		public var desc:String;
		public var honor:Number;
		public var leader:String;
		public var level:int;
		public var logo:int;
		public var member:int;
		public var name:String;
		public var prestiges:Number;
		public var rank:int;

		public function copyToBe(target:RankLeagueBean):void {
			target.allianceId = this.allianceId 
			target.city = this.city 
			target.creator = this.creator 
			target.desc = this.desc 
			target.honor = this.honor 
			target.leader = this.leader 
			target.level = this.level 
			target.logo = this.logo 
			target.member = this.member 
			target.name = this.name 
			target.prestiges = this.prestiges 
			target.rank = this.rank 
		}
		
		public function toBeObject():Object {
			var obj:Object = new Object();
			obj.allianceId = this.allianceId;
			obj.city = this.city;
			obj.creator = this.creator;
			obj.desc = this.desc;
			obj.honor = this.honor;
			obj.leader = this.leader;
			obj.level = this.level;
			obj.logo = this.logo;
			obj.member = this.member;
			obj.name = this.name;
			obj.prestiges = this.prestiges;
			obj.rank = this.rank;
			return obj;
		}

		public function toBeString(pre:String=""):String {
			var str:String = "";
			str += pre + "allianceId = " + this.allianceId + "\n" ;
			str += pre + "city = " + this.city + "\n" ;
			str += pre + "creator = " + this.creator + "\n" ;
			str += pre + "desc = " + this.desc + "\n" ;
			str += pre + "honor = " + this.honor + "\n" ;
			str += pre + "leader = " + this.leader + "\n" ;
			str += pre + "level = " + this.level + "\n" ;
			str += pre + "logo = " + this.logo + "\n" ;
			str += pre + "member = " + this.member + "\n" ;
			str += pre + "name = " + this.name + "\n" ;
			str += pre + "prestiges = " + this.prestiges + "\n" ;
			str += pre + "rank = " + this.rank + "\n" ;

			return str;  
		}
	}
}