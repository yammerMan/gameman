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
	public class BufferBean
	{
		public function BufferBean(data:Object=null)
		{
			if (data!=null){
				if (data.endTime!=null) {
					this.endTime = data.endTime;
				}
				if (data.totalTime!=null) {
					this.totalTime = data.totalTime;
				}
				if (data.typeId!=null) {
					this.typeId = data.typeId;
				}
			}
		}
		

		public var endTime:Number;
		public var totalTime:Number;
		public var typeId:int;

		public function copyToBe(target:BufferBean):void {
			target.endTime = this.endTime 
			target.totalTime = this.totalTime 
			target.typeId = this.typeId 
		}
		
		public function toBeObject():Object {
			var obj:Object = new Object();
			obj.endTime = this.endTime;
			obj.totalTime = this.totalTime;
			obj.typeId = this.typeId;
			return obj;
		}

		public function toBeString(pre:String=""):String {
			var str:String = "";
			str += pre + "endTime = " + this.endTime + "\n" ;
			str += pre + "totalTime = " + this.totalTime + "\n" ;
			str += pre + "typeId = " + this.typeId + "\n" ;

			return str;  
		}
	}
}