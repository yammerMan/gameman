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
	public class RankCityBean
	{
		public function RankCityBean(data:Object=null)
		{
			if (data!=null){
				if (data.kind!=null) {
					this.kind = data.kind;
				}
				if (data.league!=null) {
					this.league = data.league;
				}
				if (data.level!=null) {
					this.level = data.level;
				}
				if (data.name!=null) {
					this.name = data.name;
				}
				if (data.population!=null) {
					this.population = data.population;
				}
				if (data.rank!=null) {
					this.rank = data.rank;
				}
				if (data.zoneId!=null) {
					this.zoneId = data.zoneId;
				}
			}
		}
		

		public var kind:String;
		public var league:String;
		public var level:int;
		public var name:String;
		public var population:int;
		public var rank:int;
		public var zoneId:int;

		public function copyToBe(target:RankCityBean):void {
			target.kind = this.kind 
			target.league = this.league 
			target.level = this.level 
			target.name = this.name 
			target.population = this.population 
			target.rank = this.rank 
			target.zoneId = this.zoneId 
		}
		
		public function toBeObject():Object {
			var obj:Object = new Object();
			obj.kind = this.kind;
			obj.league = this.league;
			obj.level = this.level;
			obj.name = this.name;
			obj.population = this.population;
			obj.rank = this.rank;
			obj.zoneId = this.zoneId;
			return obj;
		}

		public function toBeString(pre:String=""):String {
			var str:String = "";
			str += pre + "kind = " + this.kind + "\n" ;
			str += pre + "league = " + this.league + "\n" ;
			str += pre + "level = " + this.level + "\n" ;
			str += pre + "name = " + this.name + "\n" ;
			str += pre + "population = " + this.population + "\n" ;
			str += pre + "rank = " + this.rank + "\n" ;
			str += pre + "zoneId = " + this.zoneId + "\n" ;

			return str;  
		}
	}
}