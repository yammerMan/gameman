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
	public class RoletteAppearItemBean
	{
		public function RoletteAppearItemBean(data:Object=null)
		{
			if (data!=null){
				if (data.coinValue!=null) {
					this.coinValue = data.coinValue;
				}
				if (data.count!=null) {
					this.count = data.count;
				}
				if (data.itemId!=null) {
					this.itemId = data.itemId;
				}
				if (data.level!=null) {
					this.level = data.level;
				}
			}
		}
		

		public var coinValue:int;
		public var count:int;
		public var itemId:String;
		public var level:int;

		public function copyToBe(target:RoletteAppearItemBean):void {
			target.coinValue = this.coinValue 
			target.count = this.count 
			target.itemId = this.itemId 
			target.level = this.level 
		}
		
		public function toBeObject():Object {
			var obj:Object = new Object();
			obj.coinValue = this.coinValue;
			obj.count = this.count;
			obj.itemId = this.itemId;
			obj.level = this.level;
			return obj;
		}

		public function toBeString(pre:String=""):String {
			var str:String = "";
			str += pre + "coinValue = " + this.coinValue + "\n" ;
			str += pre + "count = " + this.count + "\n" ;
			str += pre + "itemId = " + this.itemId + "\n" ;
			str += pre + "level = " + this.level + "\n" ;

			return str;  
		}
	}
}