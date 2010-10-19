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
	public class HeroTroopBean
	{
		public function HeroTroopBean(data:Object=null)
		{
			if (data!=null){
				if (data.attackMode!=null) {
					this.attackMode = data.attackMode;
				}
				if (data.count!=null) {
					this.count = data.count;
				}
				if (data.position!=null) {
					this.position = data.position;
				}
				if (data.troopType!=null) {
					this.troopType = data.troopType;
				}
				if (data.areaAttack!=null) {
					this.areaAttack = data.areaAttack;
				}
			}
		}
		

		public var attackMode:int;
		public var count:int;
		public var position:int;
		public var troopType:int;
		public var areaAttack:Boolean;

		public function copyToBe(target:HeroTroopBean):void {
			target.attackMode = this.attackMode 
			target.count = this.count 
			target.position = this.position 
			target.troopType = this.troopType 
			target.areaAttack = this.areaAttack 
		}
		
		public function toBeObject():Object {
			var obj:Object = new Object();
			obj.attackMode = this.attackMode;
			obj.count = this.count;
			obj.position = this.position;
			obj.troopType = this.troopType;
			obj.areaAttack = this.areaAttack;
			return obj;
		}

		public function toBeString(pre:String=""):String {
			var str:String = "";
			str += pre + "attackMode = " + this.attackMode + "\n" ;
			str += pre + "count = " + this.count + "\n" ;
			str += pre + "position = " + this.position + "\n" ;
			str += pre + "troopType = " + this.troopType + "\n" ;
			str += pre + "areaAttack = " + this.areaAttack + "\n" ;

			return str;  
		}
	}
}