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
	public class TransingBusinessBean
	{
		public function TransingBusinessBean(data:Object=null)
		{
			if (data!=null){
				if (data.amounts!=null) {
					this.amounts = data.amounts;
				}
				if (data.endTime!=null) {
					this.endTime = data.endTime;
				}
				if (data.id!=null) {
					this.id = data.id;
				}
				if (data.price!=null) {
					this.price = data.price;
				}
				if (data.resource!=null) {
					this.resource = data.resource;
				}
			}
		}
		

		public var amounts:int;
		public var endTime:Number;
		public var id:int;
		public var price:Number;
		public var resource:int;

		public function copyToBe(target:TransingBusinessBean):void {
			target.amounts = this.amounts 
			target.endTime = this.endTime 
			target.id = this.id 
			target.price = this.price 
			target.resource = this.resource 
		}
		
		public function toBeObject():Object {
			var obj:Object = new Object();
			obj.amounts = this.amounts;
			obj.endTime = this.endTime;
			obj.id = this.id;
			obj.price = this.price;
			obj.resource = this.resource;
			return obj;
		}

		public function toBeString(pre:String=""):String {
			var str:String = "";
			str += pre + "amounts = " + this.amounts + "\n" ;
			str += pre + "endTime = " + this.endTime + "\n" ;
			str += pre + "id = " + this.id + "\n" ;
			str += pre + "price = " + this.price + "\n" ;
			str += pre + "resource = " + this.resource + "\n" ;

			return str;  
		}
	}
}