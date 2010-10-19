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
	public class ZoneInfoDataBean
	{
		public function ZoneInfoDataBean(data:Object=null)
		{
			if (data!=null){
				if (data.cityCount!=null) {
					this.cityCount = data.cityCount;
				}
				if (data.fieldCount!=null) {
					this.fieldCount = data.fieldCount;
				}
				if (data.id!=null) {
					this.id = data.id;
				}
				if (data.playerCount!=null) {
					this.playerCount = data.playerCount;
				}
				if (data.rate!=null) {
					this.rate = data.rate;
				}
				if (data.selfCastleCount!=null) {
					this.selfCastleCount = data.selfCastleCount;
				}
			}
		}
		

		public var cityCount:int;
		public var fieldCount:int;
		public var id:int;
		public var playerCount:int;
		public var rate:Number;
		public var selfCastleCount:int;

		public function copyToBe(target:ZoneInfoDataBean):void {
			target.cityCount = this.cityCount 
			target.fieldCount = this.fieldCount 
			target.id = this.id 
			target.playerCount = this.playerCount 
			target.rate = this.rate 
			target.selfCastleCount = this.selfCastleCount 
		}
		
		public function toBeObject():Object {
			var obj:Object = new Object();
			obj.cityCount = this.cityCount;
			obj.fieldCount = this.fieldCount;
			obj.id = this.id;
			obj.playerCount = this.playerCount;
			obj.rate = this.rate;
			obj.selfCastleCount = this.selfCastleCount;
			return obj;
		}

		public function toBeString(pre:String=""):String {
			var str:String = "";
			str += pre + "cityCount = " + this.cityCount + "\n" ;
			str += pre + "fieldCount = " + this.fieldCount + "\n" ;
			str += pre + "id = " + this.id + "\n" ;
			str += pre + "playerCount = " + this.playerCount + "\n" ;
			str += pre + "rate = " + this.rate + "\n" ;
			str += pre + "selfCastleCount = " + this.selfCastleCount + "\n" ;

			return str;  
		}
	}
}