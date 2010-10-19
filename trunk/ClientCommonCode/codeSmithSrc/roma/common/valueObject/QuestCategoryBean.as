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
	public class QuestCategoryBean
	{
		public function QuestCategoryBean(data:Object=null)
		{
			if (data!=null){
				if (data.categoryId!=null) {
					this.categoryId = data.categoryId;
				}
				if (data.finish!=null) {
					this.finish = data.finish;
				}
			}
		}
		

		public var categoryId:int;
		public var finish:Boolean;

		public function copyToBe(target:QuestCategoryBean):void {
			target.categoryId = this.categoryId 
			target.finish = this.finish 
		}
		
		public function toBeObject():Object {
			var obj:Object = new Object();
			obj.categoryId = this.categoryId;
			obj.finish = this.finish;
			return obj;
		}

		public function toBeString(pre:String=""):String {
			var str:String = "";
			str += pre + "categoryId = " + this.categoryId + "\n" ;
			str += pre + "finish = " + this.finish + "\n" ;

			return str;  
		}
	}
}