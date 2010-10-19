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
	public class FieldBattleInfoBean
	{
		public function FieldBattleInfoBean(data:Object=null)
		{
			if (data!=null){
				if (data.endTime!=null) {
					this.endTime = data.endTime;
				}
				if (data.fieldId!=null) {
					this.fieldId = data.fieldId;
				}
			}
		}
		

		public var endTime:Number;
		public var fieldId:int;

		public function copyToBe(target:FieldBattleInfoBean):void {
			target.endTime = this.endTime 
			target.fieldId = this.fieldId 
		}
		
		public function toBeObject():Object {
			var obj:Object = new Object();
			obj.endTime = this.endTime;
			obj.fieldId = this.fieldId;
			return obj;
		}

		public function toBeString(pre:String=""):String {
			var str:String = "";
			str += pre + "endTime = " + this.endTime + "\n" ;
			str += pre + "fieldId = " + this.fieldId + "\n" ;

			return str;  
		}
	}
}