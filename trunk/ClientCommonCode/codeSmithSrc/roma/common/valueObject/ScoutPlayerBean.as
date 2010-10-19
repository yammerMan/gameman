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
	public class ScoutPlayerBean
	{
		public function ScoutPlayerBean(data:Object=null)
		{
			if (data!=null){
				if (data.endTime!=null) {
					this.endTime = data.endTime;
				}
				if (data.playerId!=null) {
					this.playerId = data.playerId;
				}
			}
		}
		

		public var endTime:Number;
		public var playerId:int;

		public function copyToBe(target:ScoutPlayerBean):void {
			target.endTime = this.endTime 
			target.playerId = this.playerId 
		}
		
		public function toBeObject():Object {
			var obj:Object = new Object();
			obj.endTime = this.endTime;
			obj.playerId = this.playerId;
			return obj;
		}

		public function toBeString(pre:String=""):String {
			var str:String = "";
			str += pre + "endTime = " + this.endTime + "\n" ;
			str += pre + "playerId = " + this.playerId + "\n" ;

			return str;  
		}
	}
}