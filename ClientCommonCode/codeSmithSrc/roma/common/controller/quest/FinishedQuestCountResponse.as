/**
* 生成时间 1 
*/
package roma.common.controller.quest
{
	import framework.game.BaseResponse;
	import roma.common.valueObject.*;
	import mx.collections.ArrayCollection;
	import framework.util.CopyAryUtil;
	import flash.utils.ByteArray;
	
	public class FinishedQuestCountResponse extends BaseResponse
	{
		public function FinishedQuestCountResponse(type:String, data:Object,bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.setResponseData(data);
				if (data.changeCount!=null) {
					this.changeCount = data.changeCount;
				}
				if (data.dailyCount!=null) {
					this.dailyCount = data.dailyCount;
				}
				if (data.finishedQuestCount!=null) {
					this.finishedQuestCount = data.finishedQuestCount;
				}
				if (data.growthCount!=null) {
					this.growthCount = data.growthCount;
				}
				if (data.success!=null) {
					this.success = data.success;
				}
		}

		public var changeCount:int;
		public var dailyCount:int;
		public var finishedQuestCount:int;
		public var growthCount:int;
		public var success:Boolean;

		public function copyToBe(target:FinishedQuestCountResponse):void {
			target.changeCount = this.changeCount 
			target.dailyCount = this.dailyCount 
			target.finishedQuestCount = this.finishedQuestCount 
			target.growthCount = this.growthCount 
			target.success = this.success 
		}
		
		public function toBeObject():Object {
			var obj:Object = new Object();
			obj.changeCount = this.changeCount;
			obj.dailyCount = this.dailyCount;
			obj.finishedQuestCount = this.finishedQuestCount;
			obj.growthCount = this.growthCount;
			obj.success = this.success;
			return obj;
		}

		public override function toBeString(pre:String=""):String {
			var str:String = "---- FinishedQuestCountResponse ----\n"  + this.toBeErrorString();
			str += pre + "changeCount = " + this.changeCount + "\n" ;
			str += pre + "dailyCount = " + this.dailyCount + "\n" ;
			str += pre + "finishedQuestCount = " + this.finishedQuestCount + "\n" ;
			str += pre + "growthCount = " + this.growthCount + "\n" ;
			str += pre + "success = " + this.success + "\n" ;

			return str;  
		}
	}
}