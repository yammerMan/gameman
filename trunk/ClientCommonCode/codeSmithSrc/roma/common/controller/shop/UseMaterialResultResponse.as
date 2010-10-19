/**
* 生成时间 1 
*/
package roma.common.controller.shop
{
	import framework.game.BaseResponse;
	import roma.common.valueObject.*;
	import mx.collections.ArrayCollection;
	import framework.util.CopyAryUtil;
	import flash.utils.ByteArray;
	
	public class UseMaterialResultResponse extends BaseResponse
	{
		public function UseMaterialResultResponse(type:String, data:Object,bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.setResponseData(data);
				if (data.success!=null) {
					this.success = data.success;
				}
			
				var n:int;
				if (data.items) {
					for (n=0; n<data.items.length; n++) {
						var _items:MaterialBean = new MaterialBean(data.items[n]);
						this.itemsArray.addItem(_items);
					}
				}
			
		}

		public var success:Boolean;

		public var itemsArray:ArrayCollection = new ArrayCollection();
			
		public function getItems(index:int):MaterialBean {
			var res:MaterialBean = MaterialBean(this.itemsArray[index]);
			return res; 
		}
		public function setItems(bean:MaterialBean, index:int):void {
			this.itemsArray[index] = bean;
		}

		public function copyToBe(target:UseMaterialResultResponse):void {
			target.success = this.success 
		}
		
		public function toBeObject():Object {
			var obj:Object = new Object();
			obj.success = this.success;
			return obj;
		}

		public override function toBeString(pre:String=""):String {
			var str:String = "---- UseMaterialResultResponse ----\n"  + this.toBeErrorString();
			str += pre + "success = " + this.success + "\n" ;

			var i:int;
			for (i=0; i<this.itemsArray.length; i++) {
				str += this.getItems(i).toBeString(pre + "items[" + i + "].") ;
			}
			

			return str;  
		}
	}
}