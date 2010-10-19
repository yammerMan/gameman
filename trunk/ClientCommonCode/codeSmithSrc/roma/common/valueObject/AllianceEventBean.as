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
	public class AllianceEventBean
	{
		public function AllianceEventBean(data:Object=null)
		{
			if (data!=null){
				if (data.time!=null) {
					this.time = data.time;
				}
				if (data.xmlContent!=null) {
					this.xmlContent = data.xmlContent;
				}
			}
		}
		

		public var time:Number;
		public var xmlContent:String;

		public function copyToBe(target:AllianceEventBean):void {
			target.time = this.time 
			target.xmlContent = this.xmlContent 
		}
		
		public function toBeObject():Object {
			var obj:Object = new Object();
			obj.time = this.time;
			obj.xmlContent = this.xmlContent;
			return obj;
		}

		public function toBeString(pre:String=""):String {
			var str:String = "";
			str += pre + "time = " + this.time + "\n" ;
			str += pre + "xmlContent = " + this.xmlContent + "\n" ;

			return str;  
		}
	}
}