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
	
	public class OtherArmyUpdate extends BaseResponse
	{
		public function OtherArmyUpdate(type:String, data:Object,bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.setResponseData(data);
				if (data.otherArmy!=null) {
					this.otherArmy = new OtherArmyBean(data.otherArmy);
				}
				if (data.updateType!=null) {
					this.updateType = data.updateType;
				}
		}

		public var otherArmy:OtherArmyBean;
		public var updateType:int;

		public function copyToBe(target:OtherArmyUpdate):void {
			if (otherArmy!=null) {
				this.otherArmy.copyToBe(target.otherArmy)
			} else {
				target.otherArmy = null;
			}
			target.updateType = this.updateType 
		}
		
		public function toBeObject():Object {
			var obj:Object = new Object();
			obj.otherArmy = this.otherArmy.toBeObject();
			obj.updateType = this.updateType;
			return obj;
		}

		public override function toBeString(pre:String=""):String {
			var str:String = "---- OtherArmyUpdate ----\n"  + this.toBeErrorString();
			if (otherArmy!=null) {
				str += this.otherArmy.toBeString(pre + "otherArmy.") ;
			} else {
				str += pre + "otherArmy = null\n" ;
			}
			str += pre + "updateType = " + this.updateType + "\n" ;

			return str;  
		}
	}
}