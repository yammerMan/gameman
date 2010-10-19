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
	public class GamblingItemBean
	{
		public function GamblingItemBean(data:Object=null)
		{
			if (data!=null){
				if (data.count!=null) {
					this.count = data.count;
				}
				if (data.id!=null) {
					this.id = data.id;
				}
				if (data.kind!=null) {
					this.kind = data.kind;
				}
			}
		}
		

		public var count:int;
		public var id:String;
		public var kind:int;

		public function copyToBe(target:GamblingItemBean):void {
			target.count = this.count 
			target.id = this.id 
			target.kind = this.kind 
		}
		
		public function toBeObject():Object {
			var obj:Object = new Object();
			obj.count = this.count;
			obj.id = this.id;
			obj.kind = this.kind;
			return obj;
		}

		public function toBeString(pre:String=""):String {
			var str:String = "";
			str += pre + "count = " + this.count + "\n" ;
			str += pre + "id = " + this.id + "\n" ;
			str += pre + "kind = " + this.kind + "\n" ;

			return str;  
		}
	}
}