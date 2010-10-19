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
	
	public class FreshBattleFieldResponse extends BaseResponse
	{
		public function FreshBattleFieldResponse(type:String, data:Object,bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.setResponseData(data);
				if (data.fieldId!=null) {
					this.fieldId = data.fieldId;
				}
				if (data.level!=null) {
					this.level = data.level;
				}
				if (data.hasEnforceArmy!=null) {
					this.hasEnforceArmy = data.hasEnforceArmy;
				}
				if (data.success!=null) {
					this.success = data.success;
				}
		}

		public var fieldId:int;
		public var level:int;
		public var hasEnforceArmy:Boolean;
		public var success:Boolean;

		public function copyToBe(target:FreshBattleFieldResponse):void {
			target.fieldId = this.fieldId 
			target.level = this.level 
			target.hasEnforceArmy = this.hasEnforceArmy 
			target.success = this.success 
		}
		
		public function toBeObject():Object {
			var obj:Object = new Object();
			obj.fieldId = this.fieldId;
			obj.level = this.level;
			obj.hasEnforceArmy = this.hasEnforceArmy;
			obj.success = this.success;
			return obj;
		}

		public override function toBeString(pre:String=""):String {
			var str:String = "---- FreshBattleFieldResponse ----\n"  + this.toBeErrorString();
			str += pre + "fieldId = " + this.fieldId + "\n" ;
			str += pre + "level = " + this.level + "\n" ;
			str += pre + "hasEnforceArmy = " + this.hasEnforceArmy + "\n" ;
			str += pre + "success = " + this.success + "\n" ;

			return str;  
		}
	}
}