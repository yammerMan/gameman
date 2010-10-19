/**
* 生成时间 1 
*/
package roma.common.controller.army
{
	import framework.game.BaseResponse;
	import roma.common.valueObject.*;
	import mx.collections.ArrayCollection;
	import framework.util.CopyAryUtil;
	import flash.utils.ByteArray;
	
	public class BattleArmyCountResponse extends BaseResponse
	{
		public function BattleArmyCountResponse(type:String, data:Object,bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.setResponseData(data);
				if (data.attacks!=null) {
					this.attacks = data.attacks;
				}
				if (data.defends!=null) {
					this.defends = data.defends;
				}
				if (data.success!=null) {
					this.success = data.success;
				}
		}

		public var attacks:int;
		public var defends:int;
		public var success:Boolean;

		public function copyToBe(target:BattleArmyCountResponse):void {
			target.attacks = this.attacks 
			target.defends = this.defends 
			target.success = this.success 
		}
		
		public function toBeObject():Object {
			var obj:Object = new Object();
			obj.attacks = this.attacks;
			obj.defends = this.defends;
			obj.success = this.success;
			return obj;
		}

		public override function toBeString(pre:String=""):String {
			var str:String = "---- BattleArmyCountResponse ----\n"  + this.toBeErrorString();
			str += pre + "attacks = " + this.attacks + "\n" ;
			str += pre + "defends = " + this.defends + "\n" ;
			str += pre + "success = " + this.success + "\n" ;

			return str;  
		}
	}
}