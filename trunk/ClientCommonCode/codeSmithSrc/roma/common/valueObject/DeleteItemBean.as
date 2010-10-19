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
	public class DeleteItemBean
	{
		public function DeleteItemBean(data:Object=null)
		{
			if (data!=null){
				if (data.itemId!=null) {
					this.itemId = data.itemId;
				}
				if (data.deletePlayerItem!=null) {
					this.deletePlayerItem = data.deletePlayerItem;
				}
			}
		}
		

		public var itemId:String;
		public var deletePlayerItem:Boolean;

		public function copyToBe(target:DeleteItemBean):void {
			target.itemId = this.itemId 
			target.deletePlayerItem = this.deletePlayerItem 
		}
		
		public function toBeObject():Object {
			var obj:Object = new Object();
			obj.itemId = this.itemId;
			obj.deletePlayerItem = this.deletePlayerItem;
			return obj;
		}

		public function toBeString(pre:String=""):String {
			var str:String = "";
			str += pre + "itemId = " + this.itemId + "\n" ;
			str += pre + "deletePlayerItem = " + this.deletePlayerItem + "\n" ;

			return str;  
		}
	}
}