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
	
	public class TroopManUpdate extends BaseResponse
	{
		public function TroopManUpdate(type:String, data:Object,bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.setResponseData(data);
				if (data.castleId!=null) {
					this.castleId = data.castleId;
				}
				if (data.troop!=null) {
					this.troop = new PairValueBean(data.troop);
				}
		}

		public var castleId:int;
		public var troop:PairValueBean;

		public function copyToBe(target:TroopManUpdate):void {
			target.castleId = this.castleId 
			if (troop!=null) {
				this.troop.copyToBe(target.troop)
			} else {
				target.troop = null;
			}
		}
		
		public function toBeObject():Object {
			var obj:Object = new Object();
			obj.castleId = this.castleId;
			obj.troop = this.troop.toBeObject();
			return obj;
		}

		public override function toBeString(pre:String=""):String {
			var str:String = "---- TroopManUpdate ----\n"  + this.toBeErrorString();
			str += pre + "castleId = " + this.castleId + "\n" ;
			if (troop!=null) {
				str += this.troop.toBeString(pre + "troop.") ;
			} else {
				str += pre + "troop = null\n" ;
			}

			return str;  
		}
	}
}