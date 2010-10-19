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
	public class BusinessBean
	{
		public function BusinessBean(data:Object=null)
		{
			if (data!=null){
				if (data.amounts!=null) {
					this.amounts = data.amounts;
				}
				if (data.businessType!=null) {
					this.businessType = data.businessType;
				}
				if (data.dealed!=null) {
					this.dealed = data.dealed;
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
				if (data.total!=null) {
					this.total = data.total;
				}
			}
		}
		

		public var amounts:int;
		public var businessType:int;
		public var dealed:int;
		public var id:int;
		public var price:Number;
		public var resource:int;
		public var total:Number;

		public function copyToBe(target:BusinessBean):void {
			target.amounts = this.amounts 
			target.businessType = this.businessType 
			target.dealed = this.dealed 
			target.id = this.id 
			target.price = this.price 
			target.resource = this.resource 
			target.total = this.total 
		}
		
		public function toBeObject():Object {
			var obj:Object = new Object();
			obj.amounts = this.amounts;
			obj.businessType = this.businessType;
			obj.dealed = this.dealed;
			obj.id = this.id;
			obj.price = this.price;
			obj.resource = this.resource;
			obj.total = this.total;
			return obj;
		}

		public function toBeString(pre:String=""):String {
			var str:String = "";
			str += pre + "amounts = " + this.amounts + "\n" ;
			str += pre + "businessType = " + this.businessType + "\n" ;
			str += pre + "dealed = " + this.dealed + "\n" ;
			str += pre + "id = " + this.id + "\n" ;
			str += pre + "price = " + this.price + "\n" ;
			str += pre + "resource = " + this.resource + "\n" ;
			str += pre + "total = " + this.total + "\n" ;

			return str;  
		}
	}
}