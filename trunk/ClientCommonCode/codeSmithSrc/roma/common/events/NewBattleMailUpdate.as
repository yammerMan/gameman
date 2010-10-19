/**
* 生成时间 1 
*/
package roma.common.events
{
	import framework.game.BaseResponse;
	import roma.common.valueObject.*;
	import mx.collections.ArrayCollection;
	import framework.util.CopyAryUtil;
	import flash.utils.ByteArray;
	
	public class NewBattleMailUpdate extends BaseResponse
	{
		public function NewBattleMailUpdate(type:String, data:Object,bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.setResponseData(data);
				if (data.newBattleReportCount!=null) {
					this.newBattleReportCount = data.newBattleReportCount;
				}
		}

		public var newBattleReportCount:int;

		public function copyToBe(target:NewBattleMailUpdate):void {
			target.newBattleReportCount = this.newBattleReportCount 
		}
		
		public function toBeObject():Object {
			var obj:Object = new Object();
			obj.newBattleReportCount = this.newBattleReportCount;
			return obj;
		}

		public override function toBeString(pre:String=""):String {
			var str:String = "---- NewBattleMailUpdate ----\n"  + this.toBeErrorString();
			str += pre + "newBattleReportCount = " + this.newBattleReportCount + "\n" ;

			return str;  
		}
	}
}