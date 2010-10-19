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
	public class MarketBusinessBean
	{
		public function MarketBusinessBean(data:Object=null)
		{
			if (data!=null){
				if (data.amounts!=null) {
					this.amounts = data.amounts;
				}
				if (data.price!=null) {
					this.price = data.price;
				}
			}
		}
		

		public var amounts:int;
		public var price:Number;

		public function copyToBe(target:MarketBusinessBean):void {
			target.amounts = this.amounts 
			target.price = this.price 
		}
		
		public function toBeObject():Object {
			var obj:Object = new Object();
			obj.amounts = this.amounts;
			obj.price = this.price;
			return obj;
		}

		public function toBeString(pre:String=""):String {
			var str:String = "";
			str += pre + "amounts = " + this.amounts + "\n" ;
			str += pre + "price = " + this.price + "\n" ;

			return str;  
		}
	}
}