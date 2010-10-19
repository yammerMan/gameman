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
	public class WildBean
	{
		public function WildBean(data:Object=null)
		{
			if (data!=null){
				if (data.fieldType!=null) {
					this.fieldType = data.fieldType;
				}
				if (data.id!=null) {
					this.id = data.id;
				}
				if (data.level!=null) {
					this.level = data.level;
				}
			}
		}
		

		public var fieldType:int;
		public var id:int;
		public var level:int;

		public function copyToBe(target:WildBean):void {
			target.fieldType = this.fieldType 
			target.id = this.id 
			target.level = this.level 
		}
		
		public function toBeObject():Object {
			var obj:Object = new Object();
			obj.fieldType = this.fieldType;
			obj.id = this.id;
			obj.level = this.level;
			return obj;
		}

		public function toBeString(pre:String=""):String {
			var str:String = "";
			str += pre + "fieldType = " + this.fieldType + "\n" ;
			str += pre + "id = " + this.id + "\n" ;
			str += pre + "level = " + this.level + "\n" ;

			return str;  
		}
	}
}