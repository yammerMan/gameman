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
	public class TaskTargetBean
	{
		public function TaskTargetBean(data:Object=null)
		{
			if (data!=null){
				if (data.name!=null) {
					this.name = data.name;
				}
				if (data.finished!=null) {
					this.finished = data.finished;
				}
			}
		}
		

		public var name:String;
		public var finished:Boolean;

		public function copyToBe(target:TaskTargetBean):void {
			target.name = this.name 
			target.finished = this.finished 
		}
		
		public function toBeObject():Object {
			var obj:Object = new Object();
			obj.name = this.name;
			obj.finished = this.finished;
			return obj;
		}

		public function toBeString(pre:String=""):String {
			var str:String = "";
			str += pre + "name = " + this.name + "\n" ;
			str += pre + "finished = " + this.finished + "\n" ;

			return str;  
		}
	}
}