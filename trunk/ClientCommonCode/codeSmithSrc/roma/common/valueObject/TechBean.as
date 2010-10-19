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
	public class TechBean
	{
		public function TechBean(data:Object=null)
		{
			if (data!=null){
				if (data.cityId!=null) {
					this.cityId = data.cityId;
				}
				if (data.finishTime!=null) {
					this.finishTime = data.finishTime;
				}
				if (data.level!=null) {
					this.level = data.level;
				}
				if (data.timeNeed!=null) {
					this.timeNeed = data.timeNeed;
				}
				if (data.typeId!=null) {
					this.typeId = data.typeId;
				}
				if (data.researching!=null) {
					this.researching = data.researching;
				}
			}
		}
		

		public var cityId:int;
		public var finishTime:Number;
		public var level:int;
		public var timeNeed:int;
		public var typeId:int;
		public var researching:Boolean;

		public function copyToBe(target:TechBean):void {
			target.cityId = this.cityId 
			target.finishTime = this.finishTime 
			target.level = this.level 
			target.timeNeed = this.timeNeed 
			target.typeId = this.typeId 
			target.researching = this.researching 
		}
		
		public function toBeObject():Object {
			var obj:Object = new Object();
			obj.cityId = this.cityId;
			obj.finishTime = this.finishTime;
			obj.level = this.level;
			obj.timeNeed = this.timeNeed;
			obj.typeId = this.typeId;
			obj.researching = this.researching;
			return obj;
		}

		public function toBeString(pre:String=""):String {
			var str:String = "";
			str += pre + "cityId = " + this.cityId + "\n" ;
			str += pre + "finishTime = " + this.finishTime + "\n" ;
			str += pre + "level = " + this.level + "\n" ;
			str += pre + "timeNeed = " + this.timeNeed + "\n" ;
			str += pre + "typeId = " + this.typeId + "\n" ;
			str += pre + "researching = " + this.researching + "\n" ;

			return str;  
		}
	}
}