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
	public class QuestAnswerBean
	{
		public function QuestAnswerBean(data:Object=null)
		{
			if (data!=null){
				if (data.id!=null) {
					this.id = data.id;
				}
			}
		}
		

		public var id:int;

		public function copyToBe(target:QuestAnswerBean):void {
			target.id = this.id 
		}
		
		public function toBeObject():Object {
			var obj:Object = new Object();
			obj.id = this.id;
			return obj;
		}

		public function toBeString(pre:String=""):String {
			var str:String = "";
			str += pre + "id = " + this.id + "\n" ;

			return str;  
		}
	}
}