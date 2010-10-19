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
	
	public class NewRelatedBattleField extends BaseResponse
	{
		public function NewRelatedBattleField(type:String, data:Object,bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.setResponseData(data);
		}

		public function copyToBe(target:NewRelatedBattleField):void {
		}
		
		public function toBeObject():Object {
			var obj:Object = new Object();
			return obj;
		}

		public override function toBeString(pre:String=""):String {
			var str:String = "---- NewRelatedBattleField ----\n"  + this.toBeErrorString();

			return str;  
		}
	}
}