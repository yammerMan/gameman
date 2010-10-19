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
	public class QuestAwardBean
	{
		public function QuestAwardBean(data:Object=null)
		{
			if (data!=null){
				if (data.value!=null) {
					this.value = data.value;
				}
			}
		}
		

		public var value:String;

		public function copyToBe(target:QuestAwardBean):void {
			target.value = this.value 
		}
		
		public function toBeObject():Object {
			var obj:Object = new Object();
			obj.value = this.value;
			return obj;
		}

		public function toBeString(pre:String=""):String {
			var str:String = "";
			str += pre + "value = " + this.value + "\n" ;

			return str;  
		}
	}
}