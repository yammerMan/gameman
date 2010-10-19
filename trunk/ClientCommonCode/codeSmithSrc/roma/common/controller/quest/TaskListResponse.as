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
	
	public class TaskListResponse extends BaseResponse
	{
		public function TaskListResponse(type:String, data:Object,bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.setResponseData(data);
				if (data.success!=null) {
					this.success = data.success;
				}
			
				var n:int;
				if (data.tasks) {
					for (n=0; n<data.tasks.length; n++) {
						var _tasks:TaskBean = new TaskBean(data.tasks[n]);
						this.tasksArray.addItem(_tasks);
					}
				}
			
		}

		public var success:Boolean;

		public var tasksArray:ArrayCollection = new ArrayCollection();
			
		public function getTasks(index:int):TaskBean {
			var res:TaskBean = TaskBean(this.tasksArray[index]);
			return res; 
		}
		public function setTasks(bean:TaskBean, index:int):void {
			this.tasksArray[index] = bean;
		}

		public function copyToBe(target:TaskListResponse):void {
			target.success = this.success 
		}
		
		public function toBeObject():Object {
			var obj:Object = new Object();
			obj.success = this.success;
			return obj;
		}

		public override function toBeString(pre:String=""):String {
			var str:String = "---- TaskListResponse ----\n"  + this.toBeErrorString();
			str += pre + "success = " + this.success + "\n" ;

			var i:int;
			for (i=0; i<this.tasksArray.length; i++) {
				str += this.getTasks(i).toBeString(pre + "tasks[" + i + "].") ;
			}
			

			return str;  
		}
	}
}