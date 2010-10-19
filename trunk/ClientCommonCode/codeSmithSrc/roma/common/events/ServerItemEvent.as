/**
* 生成时间 1 
*/
package roma.common.events
{
	import framework.game.BaseResponse;
	import roma.common.valueObject.*;
	import mx.collections.ArrayCollection;
	import framework.util.CopyAryUtil;
	import flash.utils.ByteArray;
	
	public class ServerItemEvent extends BaseResponse
	{
		public function ServerItemEvent(type:String, data:Object,bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.setResponseData(data);
			
				var n:int;
				if (data.removeItems) {
					for (n=0; n<data.removeItems.length; n++) {
						var _removeItems:DeleteItemBean = new DeleteItemBean(data.removeItems[n]);
						this.removeItemsArray.addItem(_removeItems);
					}
				}
			
				if (data.updateItems) {
					for (n=0; n<data.updateItems.length; n++) {
						var _updateItems:ItemRuleBean = new ItemRuleBean(data.updateItems[n]);
						this.updateItemsArray.addItem(_updateItems);
					}
				}
			
		}

		public var removeItemsArray:ArrayCollection = new ArrayCollection();
		public var updateItemsArray:ArrayCollection = new ArrayCollection();
			
		public function getRemoveItems(index:int):DeleteItemBean {
			var res:DeleteItemBean = DeleteItemBean(this.removeItemsArray[index]);
			return res; 
		}
		public function setRemoveItems(bean:DeleteItemBean, index:int):void {
			this.removeItemsArray[index] = bean;
		}
		public function getUpdateItems(index:int):ItemRuleBean {
			var res:ItemRuleBean = ItemRuleBean(this.updateItemsArray[index]);
			return res; 
		}
		public function setUpdateItems(bean:ItemRuleBean, index:int):void {
			this.updateItemsArray[index] = bean;
		}

		public function copyToBe(target:ServerItemEvent):void {
		}
		
		public function toBeObject():Object {
			var obj:Object = new Object();
			return obj;
		}

		public override function toBeString(pre:String=""):String {
			var str:String = "---- ServerItemEvent ----\n"  + this.toBeErrorString();

			var i:int;
			for (i=0; i<this.removeItemsArray.length; i++) {
				str += this.getRemoveItems(i).toBeString(pre + "removeItems[" + i + "].") ;
			}
			
			for (i=0; i<this.updateItemsArray.length; i++) {
				str += this.getUpdateItems(i).toBeString(pre + "updateItems[" + i + "].") ;
			}
			

			return str;  
		}
	}
}