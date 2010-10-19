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
	public class WorkerTrainningBean
	{
		public function WorkerTrainningBean(data:Object=null)
		{
			if (data!=null){
				if (data.count!=null) {
					this.count = data.count;
				}
				if (data.endTime!=null) {
					this.endTime = data.endTime;
				}
				if (data.needTime!=null) {
					this.needTime = data.needTime;
				}
				if (data.type!=null) {
					this.type = data.type;
				}
			}
		}
		

		public var count:int;
		public var endTime:Number;
		public var needTime:int;
		public var type:int;

		public function copyToBe(target:WorkerTrainningBean):void {
			target.count = this.count 
			target.endTime = this.endTime 
			target.needTime = this.needTime 
			target.type = this.type 
		}
		
		public function toBeObject():Object {
			var obj:Object = new Object();
			obj.count = this.count;
			obj.endTime = this.endTime;
			obj.needTime = this.needTime;
			obj.type = this.type;
			return obj;
		}

		public function toBeString(pre:String=""):String {
			var str:String = "";
			str += pre + "count = " + this.count + "\n" ;
			str += pre + "endTime = " + this.endTime + "\n" ;
			str += pre + "needTime = " + this.needTime + "\n" ;
			str += pre + "type = " + this.type + "\n" ;

			return str;  
		}
	}
}