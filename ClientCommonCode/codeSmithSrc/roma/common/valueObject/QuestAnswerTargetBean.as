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
	public class QuestAnswerTargetBean
	{
		public function QuestAnswerTargetBean(data:Object=null)
		{
			if (data!=null){
				if (data.targetId!=null) {
					this.targetId = data.targetId;
				}
				if (data.finished!=null) {
					this.finished = data.finished;
				}
			}
		}
		

		public var targetId:int;
		public var finished:Boolean;

		public function copyToBe(target:QuestAnswerTargetBean):void {
			target.targetId = this.targetId 
			target.finished = this.finished 
		}
		
		public function toBeObject():Object {
			var obj:Object = new Object();
			obj.targetId = this.targetId;
			obj.finished = this.finished;
			return obj;
		}

		public function toBeString(pre:String=""):String {
			var str:String = "";
			str += pre + "targetId = " + this.targetId + "\n" ;
			str += pre + "finished = " + this.finished + "\n" ;

			return str;  
		}
	}
}