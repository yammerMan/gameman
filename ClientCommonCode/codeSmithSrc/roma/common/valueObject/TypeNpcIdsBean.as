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
	public class TypeNpcIdsBean
	{
		public function TypeNpcIdsBean(data:Object=null)
		{
			if (data!=null){
				if (data.type!=null) {
					this.type = data.type;
				}
			
				var n:int;
				if (data.npcFieldIds) {
					for (n=0; n<data.npcFieldIds.length; n++) {
						var _npcFieldIds:int = new int(data.npcFieldIds[n]);
						this.npcFieldIdsArray.addItem(_npcFieldIds);
					}
				}
			
			}
		}
		

		public var type:int;

		public var npcFieldIdsArray:ArrayCollection = new ArrayCollection();
			
		public function getNpcFieldIds(index:int):int {
			var res:int = int(this.npcFieldIdsArray[index]);
			return res; 
		}
		public function setNpcFieldIds(bean:int, index:int):void {
			this.npcFieldIdsArray[index] = bean;
		}

		public function copyToBe(target:TypeNpcIdsBean):void {
			target.type = this.type 
		}
		
		public function toBeObject():Object {
			var obj:Object = new Object();
			obj.type = this.type;
			return obj;
		}

		public function toBeString(pre:String=""):String {
			var str:String = "";
			str += pre + "type = " + this.type + "\n" ;

			var i:int;
			for (i=0; i<this.npcFieldIdsArray.length; i++) {
				str += pre + "npcFieldIds[" + i + "] = " + this.getNpcFieldIds(i) + "\n" ; 
			}
			

			return str;  
		}
	}
}