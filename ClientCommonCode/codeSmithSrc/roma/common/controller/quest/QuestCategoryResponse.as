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
	
	public class QuestCategoryResponse extends BaseResponse
	{
		public function QuestCategoryResponse(type:String, data:Object,bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.setResponseData(data);
				if (data.success!=null) {
					this.success = data.success;
				}
			
				var n:int;
				if (data.types) {
					for (n=0; n<data.types.length; n++) {
						var _types:QuestCategoryBean = new QuestCategoryBean(data.types[n]);
						this.typesArray.addItem(_types);
					}
				}
			
		}

		public var success:Boolean;

		public var typesArray:ArrayCollection = new ArrayCollection();
			
		public function getTypes(index:int):QuestCategoryBean {
			var res:QuestCategoryBean = QuestCategoryBean(this.typesArray[index]);
			return res; 
		}
		public function setTypes(bean:QuestCategoryBean, index:int):void {
			this.typesArray[index] = bean;
		}

		public function copyToBe(target:QuestCategoryResponse):void {
			target.success = this.success 
		}
		
		public function toBeObject():Object {
			var obj:Object = new Object();
			obj.success = this.success;
			return obj;
		}

		public override function toBeString(pre:String=""):String {
			var str:String = "---- QuestCategoryResponse ----\n"  + this.toBeErrorString();
			str += pre + "success = " + this.success + "\n" ;

			var i:int;
			for (i=0; i<this.typesArray.length; i++) {
				str += this.getTypes(i).toBeString(pre + "types[" + i + "].") ;
			}
			

			return str;  
		}
	}
}