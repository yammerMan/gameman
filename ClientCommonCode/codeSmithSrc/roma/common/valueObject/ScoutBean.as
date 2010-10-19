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
	public class ScoutBean
	{
		public function ScoutBean(data:Object=null)
		{
			if (data!=null){
				if (data.arriveTime!=null) {
					this.arriveTime = data.arriveTime;
				}
				if (data.mission!=null) {
					this.mission = data.mission;
				}
				if (data.targetFieldId!=null) {
					this.targetFieldId = data.targetFieldId;
				}
				if (data.targetFieldName!=null) {
					this.targetFieldName = data.targetFieldName;
				}
				if (data.targetFieldType!=null) {
					this.targetFieldType = data.targetFieldType;
				}
			}
		}
		

		public var arriveTime:Number;
		public var mission:int;
		public var targetFieldId:int;
		public var targetFieldName:String;
		public var targetFieldType:int;

		public function copyToBe(target:ScoutBean):void {
			target.arriveTime = this.arriveTime 
			target.mission = this.mission 
			target.targetFieldId = this.targetFieldId 
			target.targetFieldName = this.targetFieldName 
			target.targetFieldType = this.targetFieldType 
		}
		
		public function toBeObject():Object {
			var obj:Object = new Object();
			obj.arriveTime = this.arriveTime;
			obj.mission = this.mission;
			obj.targetFieldId = this.targetFieldId;
			obj.targetFieldName = this.targetFieldName;
			obj.targetFieldType = this.targetFieldType;
			return obj;
		}

		public function toBeString(pre:String=""):String {
			var str:String = "";
			str += pre + "arriveTime = " + this.arriveTime + "\n" ;
			str += pre + "mission = " + this.mission + "\n" ;
			str += pre + "targetFieldId = " + this.targetFieldId + "\n" ;
			str += pre + "targetFieldName = " + this.targetFieldName + "\n" ;
			str += pre + "targetFieldType = " + this.targetFieldType + "\n" ;

			return str;  
		}
	}
}