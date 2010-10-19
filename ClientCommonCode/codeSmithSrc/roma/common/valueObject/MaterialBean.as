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
	public class MaterialBean
	{
		public function MaterialBean(data:Object=null)
		{
			if (data!=null){
				if (data.count!=null) {
					this.count = data.count;
				}
				if (data.id!=null) {
					this.id = data.id;
				}
			}
		}
		

		public var count:int;
		public var id:String;

		public function copyToBe(target:MaterialBean):void {
			target.count = this.count 
			target.id = this.id 
		}
		
		public function toBeObject():Object {
			var obj:Object = new Object();
			obj.count = this.count;
			obj.id = this.id;
			return obj;
		}

		public function toBeString(pre:String=""):String {
			var str:String = "";
			str += pre + "count = " + this.count + "\n" ;
			str += pre + "id = " + this.id + "\n" ;

			return str;  
		}
	}
}