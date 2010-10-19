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
	
	public class BattleArmysInfoResponse extends BaseResponse
	{
		public function BattleArmysInfoResponse(type:String, data:Object,bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.setResponseData(data);
				if (data.success!=null) {
					this.success = data.success;
				}
			
				var n:int;
				if (data.attackArmys) {
					for (n=0; n<data.attackArmys.length; n++) {
						var _attackArmys:ForceBean = new ForceBean(data.attackArmys[n]);
						this.attackArmysArray.addItem(_attackArmys);
					}
				}
			
				if (data.defendArmys) {
					for (n=0; n<data.defendArmys.length; n++) {
						var _defendArmys:ForceBean = new ForceBean(data.defendArmys[n]);
						this.defendArmysArray.addItem(_defendArmys);
					}
				}
			
		}

		public var success:Boolean;

		public var attackArmysArray:ArrayCollection = new ArrayCollection();
		public var defendArmysArray:ArrayCollection = new ArrayCollection();
			
		public function getAttackArmys(index:int):ForceBean {
			var res:ForceBean = ForceBean(this.attackArmysArray[index]);
			return res; 
		}
		public function setAttackArmys(bean:ForceBean, index:int):void {
			this.attackArmysArray[index] = bean;
		}
		public function getDefendArmys(index:int):ForceBean {
			var res:ForceBean = ForceBean(this.defendArmysArray[index]);
			return res; 
		}
		public function setDefendArmys(bean:ForceBean, index:int):void {
			this.defendArmysArray[index] = bean;
		}

		public function copyToBe(target:BattleArmysInfoResponse):void {
			target.success = this.success 
		}
		
		public function toBeObject():Object {
			var obj:Object = new Object();
			obj.success = this.success;
			return obj;
		}

		public override function toBeString(pre:String=""):String {
			var str:String = "---- BattleArmysInfoResponse ----\n"  + this.toBeErrorString();
			str += pre + "success = " + this.success + "\n" ;

			var i:int;
			for (i=0; i<this.attackArmysArray.length; i++) {
				str += this.getAttackArmys(i).toBeString(pre + "attackArmys[" + i + "].") ;
			}
			
			for (i=0; i<this.defendArmysArray.length; i++) {
				str += this.getDefendArmys(i).toBeString(pre + "defendArmys[" + i + "].") ;
			}
			

			return str;  
		}
	}
}