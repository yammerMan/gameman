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
	public class FieldCollectBean
	{
		public function FieldCollectBean(data:Object=null)
		{
			if (data!=null){
				if (data.fieldId!=null) {
					this.fieldId = data.fieldId;
				}
				if (data.remark!=null) {
					this.remark = data.remark;
				}
			}
		}
		

		public var fieldId:int;
		public var remark:String;

		public function copyToBe(target:FieldCollectBean):void {
			target.fieldId = this.fieldId 
			target.remark = this.remark 
		}
		
		public function toBeObject():Object {
			var obj:Object = new Object();
			obj.fieldId = this.fieldId;
			obj.remark = this.remark;
			return obj;
		}

		public function toBeString(pre:String=""):String {
			var str:String = "";
			str += pre + "fieldId = " + this.fieldId + "\n" ;
			str += pre + "remark = " + this.remark + "\n" ;

			return str;  
		}
	}
}