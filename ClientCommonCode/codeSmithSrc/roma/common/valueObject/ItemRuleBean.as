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
	public class ItemRuleBean
	{
		public function ItemRuleBean(data:Object=null)
		{
			if (data!=null){
				if (data.changeType!=null) {
					this.changeType = data.changeType;
				}
				if (data.funcDesc!=null) {
					this.funcDesc = data.funcDesc;
				}
				if (data.iconUrl!=null) {
					this.iconUrl = data.iconUrl;
				}
				if (data.id!=null) {
					this.id = data.id;
				}
				if (data.itemDesc!=null) {
					this.itemDesc = data.itemDesc;
				}
				if (data.name!=null) {
					this.name = data.name;
				}
				if (data.price!=null) {
					this.price = data.price;
				}
				if (data.sort!=null) {
					this.sort = data.sort;
				}
				if (data.type!=null) {
					this.type = data.type;
				}
			}
		}
		

		public var changeType:int;
		public var funcDesc:String;
		public var iconUrl:String;
		public var id:String;
		public var itemDesc:String;
		public var name:String;
		public var price:int;
		public var sort:int;
		public var type:int;

		public function copyToBe(target:ItemRuleBean):void {
			target.changeType = this.changeType 
			target.funcDesc = this.funcDesc 
			target.iconUrl = this.iconUrl 
			target.id = this.id 
			target.itemDesc = this.itemDesc 
			target.name = this.name 
			target.price = this.price 
			target.sort = this.sort 
			target.type = this.type 
		}
		
		public function toBeObject():Object {
			var obj:Object = new Object();
			obj.changeType = this.changeType;
			obj.funcDesc = this.funcDesc;
			obj.iconUrl = this.iconUrl;
			obj.id = this.id;
			obj.itemDesc = this.itemDesc;
			obj.name = this.name;
			obj.price = this.price;
			obj.sort = this.sort;
			obj.type = this.type;
			return obj;
		}

		public function toBeString(pre:String=""):String {
			var str:String = "";
			str += pre + "changeType = " + this.changeType + "\n" ;
			str += pre + "funcDesc = " + this.funcDesc + "\n" ;
			str += pre + "iconUrl = " + this.iconUrl + "\n" ;
			str += pre + "id = " + this.id + "\n" ;
			str += pre + "itemDesc = " + this.itemDesc + "\n" ;
			str += pre + "name = " + this.name + "\n" ;
			str += pre + "price = " + this.price + "\n" ;
			str += pre + "sort = " + this.sort + "\n" ;
			str += pre + "type = " + this.type + "\n" ;

			return str;  
		}
	}
}