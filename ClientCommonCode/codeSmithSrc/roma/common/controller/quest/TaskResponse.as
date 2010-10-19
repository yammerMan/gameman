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
	
	public class TaskResponse extends BaseResponse
	{
		public function TaskResponse(type:String, data:Object,bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.setResponseData(data);
				if (data.task!=null) {
					this.task = new TaskBean(data.task);
				}
				if (data.success!=null) {
					this.success = data.success;
				}
		}

		public var task:TaskBean;
		public var success:Boolean;

		public function copyToBe(target:TaskResponse):void {
			if (task!=null) {
				this.task.copyToBe(target.task)
			} else {
				target.task = null;
			}
			target.success = this.success 
		}
		
		public function toBeObject():Object {
			var obj:Object = new Object();
			obj.task = this.task.toBeObject();
			obj.success = this.success;
			return obj;
		}

		public override function toBeString(pre:String=""):String {
			var str:String = "---- TaskResponse ----\n"  + this.toBeErrorString();
			if (task!=null) {
				str += this.task.toBeString(pre + "task.") ;
			} else {
				str += pre + "task = null\n" ;
			}
			str += pre + "success = " + this.success + "\n" ;

			return str;  
		}
	}
}