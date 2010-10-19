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
	
	public class OtherArmyLeave extends BaseResponse
	{
		public function OtherArmyLeave(type:String, data:Object,bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.setResponseData(data);
				if (data.heroManId!=null) {
					this.heroManId = data.heroManId;
				}
		}

		public var heroManId:int;

		public function copyToBe(target:OtherArmyLeave):void {
			target.heroManId = this.heroManId 
		}
		
		public function toBeObject():Object {
			var obj:Object = new Object();
			obj.heroManId = this.heroManId;
			return obj;
		}

		public override function toBeString(pre:String=""):String {
			var str:String = "---- OtherArmyLeave ----\n"  + this.toBeErrorString();
			str += pre + "heroManId = " + this.heroManId + "\n" ;

			return str;  
		}
	}
}