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
	public class RankHeroManBean
	{
		public function RankHeroManBean(data:Object=null)
		{
			if (data!=null){
				if (data.level!=null) {
					this.level = data.level;
				}
				if (data.management!=null) {
					this.management = data.management;
				}
				if (data.name!=null) {
					this.name = data.name;
				}
				if (data.playerName!=null) {
					this.playerName = data.playerName;
				}
				if (data.power!=null) {
					this.power = data.power;
				}
				if (data.rank!=null) {
					this.rank = data.rank;
				}
				if (data.stratagem!=null) {
					this.stratagem = data.stratagem;
				}
			}
		}
		

		public var level:int;
		public var management:int;
		public var name:String;
		public var playerName:String;
		public var power:int;
		public var rank:int;
		public var stratagem:int;

		public function copyToBe(target:RankHeroManBean):void {
			target.level = this.level 
			target.management = this.management 
			target.name = this.name 
			target.playerName = this.playerName 
			target.power = this.power 
			target.rank = this.rank 
			target.stratagem = this.stratagem 
		}
		
		public function toBeObject():Object {
			var obj:Object = new Object();
			obj.level = this.level;
			obj.management = this.management;
			obj.name = this.name;
			obj.playerName = this.playerName;
			obj.power = this.power;
			obj.rank = this.rank;
			obj.stratagem = this.stratagem;
			return obj;
		}

		public function toBeString(pre:String=""):String {
			var str:String = "";
			str += pre + "level = " + this.level + "\n" ;
			str += pre + "management = " + this.management + "\n" ;
			str += pre + "name = " + this.name + "\n" ;
			str += pre + "playerName = " + this.playerName + "\n" ;
			str += pre + "power = " + this.power + "\n" ;
			str += pre + "rank = " + this.rank + "\n" ;
			str += pre + "stratagem = " + this.stratagem + "\n" ;

			return str;  
		}
	}
}