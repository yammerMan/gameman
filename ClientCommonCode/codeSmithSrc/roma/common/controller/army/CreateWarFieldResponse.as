/**
* 生成时间 1 
*/
package roma.common.controller.army
{
	import framework.game.BaseResponse;
	import roma.common.valueObject.*;
	import mx.collections.ArrayCollection;
	import framework.util.CopyAryUtil;
	import flash.utils.ByteArray;
	
	public class CreateWarFieldResponse extends BaseResponse
	{
		public function CreateWarFieldResponse(type:String, data:Object,bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.setResponseData(data);
				if (data.arriveTime!=null) {
					this.arriveTime = data.arriveTime;
				}
				if (data.battleId!=null) {
					this.battleId = data.battleId;
				}
				if (data.success!=null) {
					this.success = data.success;
				}
		}

		public var arriveTime:Number;
		public var battleId:int;
		public var success:Boolean;

		public function copyToBe(target:CreateWarFieldResponse):void {
			target.arriveTime = this.arriveTime 
			target.battleId = this.battleId 
			target.success = this.success 
		}
		
		public function toBeObject():Object {
			var obj:Object = new Object();
			obj.arriveTime = this.arriveTime;
			obj.battleId = this.battleId;
			obj.success = this.success;
			return obj;
		}

		public override function toBeString(pre:String=""):String {
			var str:String = "---- CreateWarFieldResponse ----\n"  + this.toBeErrorString();
			str += pre + "arriveTime = " + this.arriveTime + "\n" ;
			str += pre + "battleId = " + this.battleId + "\n" ;
			str += pre + "success = " + this.success + "\n" ;

			return str;  
		}
	}
}