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
	
	public class OtherArmyStatusUpdate extends BaseResponse
	{
		public function OtherArmyStatusUpdate(type:String, data:Object,bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.setResponseData(data);
				if (data.heroManId!=null) {
					this.heroManId = data.heroManId;
				}
				if (data.status!=null) {
					this.status = data.status;
				}
		}

		public var heroManId:int;
		public var status:int;

		public function copyToBe(target:OtherArmyStatusUpdate):void {
			target.heroManId = this.heroManId 
			target.status = this.status 
		}
		
		public function toBeObject():Object {
			var obj:Object = new Object();
			obj.heroManId = this.heroManId;
			obj.status = this.status;
			return obj;
		}

		public override function toBeString(pre:String=""):String {
			var str:String = "---- OtherArmyStatusUpdate ----\n"  + this.toBeErrorString();
			str += pre + "heroManId = " + this.heroManId + "\n" ;
			str += pre + "status = " + this.status + "\n" ;

			return str;  
		}
	}
}