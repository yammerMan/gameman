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
	public class PairValueBean
	{
		public function PairValueBean(data:Object=null)
		{
			if (data!=null){
				if (data.typeId!=null) {
					this.typeId = data.typeId;
				}
				if (data.value!=null) {
					this.value = data.value;
				}
			}
		}
		

		public var typeId:int;
		public var value:int;

		public function copyToBe(target:PairValueBean):void {
			target.typeId = this.typeId 
			target.value = this.value 
		}
		
		public function toBeObject():Object {
			var obj:Object = new Object();
			obj.typeId = this.typeId;
			obj.value = this.value;
			return obj;
		}

		public function toBeString(pre:String=""):String {
			var str:String = "";
			str += pre + "typeId = " + this.typeId + "\n" ;
			str += pre + "value = " + this.value + "\n" ;

			return str;  
		}
	}
}