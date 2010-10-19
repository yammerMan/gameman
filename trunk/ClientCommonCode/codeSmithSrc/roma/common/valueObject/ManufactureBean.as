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
	public class ManufactureBean
	{
		public function ManufactureBean(data:Object=null)
		{
			if (data!=null){
				if (data.costTime!=null) {
					this.costTime = data.costTime;
				}
				if (data.endTime!=null) {
					this.endTime = data.endTime;
				}
				if (data.id!=null) {
					this.id = data.id;
				}
				if (data.number!=null) {
					this.number = data.number;
				}
				if (data.type!=null) {
					this.type = data.type;
				}
				if (data.havaSpeedUp!=null) {
					this.havaSpeedUp = data.havaSpeedUp;
				}
			}
		}
		

		public var costTime:Number;
		public var endTime:Number;
		public var id:int;
		public var number:int;
		public var type:int;
		public var havaSpeedUp:Boolean;

		public function copyToBe(target:ManufactureBean):void {
			target.costTime = this.costTime 
			target.endTime = this.endTime 
			target.id = this.id 
			target.number = this.number 
			target.type = this.type 
			target.havaSpeedUp = this.havaSpeedUp 
		}
		
		public function toBeObject():Object {
			var obj:Object = new Object();
			obj.costTime = this.costTime;
			obj.endTime = this.endTime;
			obj.id = this.id;
			obj.number = this.number;
			obj.type = this.type;
			obj.havaSpeedUp = this.havaSpeedUp;
			return obj;
		}

		public function toBeString(pre:String=""):String {
			var str:String = "";
			str += pre + "costTime = " + this.costTime + "\n" ;
			str += pre + "endTime = " + this.endTime + "\n" ;
			str += pre + "id = " + this.id + "\n" ;
			str += pre + "number = " + this.number + "\n" ;
			str += pre + "type = " + this.type + "\n" ;
			str += pre + "havaSpeedUp = " + this.havaSpeedUp + "\n" ;

			return str;  
		}
	}
}