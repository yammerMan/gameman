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
	public class ResourceInfoDataBean
	{
		public function ResourceInfoDataBean(data:Object=null)
		{
			if (data!=null){
				if (data.amounts!=null) {
					this.amounts = data.amounts;
				}
				if (data.incRate!=null) {
					this.incRate = data.incRate;
				}
				if (data.max!=null) {
					this.max = data.max;
				}
			}
		}
		

		public var amounts:Number;
		public var incRate:Number;
		public var max:int;

		public function copyToBe(target:ResourceInfoDataBean):void {
			target.amounts = this.amounts 
			target.incRate = this.incRate 
			target.max = this.max 
		}
		
		public function toBeObject():Object {
			var obj:Object = new Object();
			obj.amounts = this.amounts;
			obj.incRate = this.incRate;
			obj.max = this.max;
			return obj;
		}

		public function toBeString(pre:String=""):String {
			var str:String = "";
			str += pre + "amounts = " + this.amounts + "\n" ;
			str += pre + "incRate = " + this.incRate + "\n" ;
			str += pre + "max = " + this.max + "\n" ;

			return str;  
		}
	}
}