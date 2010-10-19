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
	
	public class BattleInfoResponse extends BaseResponse
	{
		public function BattleInfoResponse(type:String, data:Object,bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.setResponseData(data);
				if (data.success!=null) {
					this.success = data.success;
				}
			
				var n:int;
				if (data.attackBattles) {
					for (n=0; n<data.attackBattles.length; n++) {
						var _attackBattles:BattleFieldBean = new BattleFieldBean(data.attackBattles[n]);
						this.attackBattlesArray.addItem(_attackBattles);
					}
				}
			
				if (data.defendBattles) {
					for (n=0; n<data.defendBattles.length; n++) {
						var _defendBattles:BattleFieldBean = new BattleFieldBean(data.defendBattles[n]);
						this.defendBattlesArray.addItem(_defendBattles);
					}
				}
			
				if (data.otherBattles) {
					for (n=0; n<data.otherBattles.length; n++) {
						var _otherBattles:BattleFieldBean = new BattleFieldBean(data.otherBattles[n]);
						this.otherBattlesArray.addItem(_otherBattles);
					}
				}
			
		}

		public var success:Boolean;

		public var attackBattlesArray:ArrayCollection = new ArrayCollection();
		public var defendBattlesArray:ArrayCollection = new ArrayCollection();
		public var otherBattlesArray:ArrayCollection = new ArrayCollection();
			
		public function getAttackBattles(index:int):BattleFieldBean {
			var res:BattleFieldBean = BattleFieldBean(this.attackBattlesArray[index]);
			return res; 
		}
		public function setAttackBattles(bean:BattleFieldBean, index:int):void {
			this.attackBattlesArray[index] = bean;
		}
		public function getDefendBattles(index:int):BattleFieldBean {
			var res:BattleFieldBean = BattleFieldBean(this.defendBattlesArray[index]);
			return res; 
		}
		public function setDefendBattles(bean:BattleFieldBean, index:int):void {
			this.defendBattlesArray[index] = bean;
		}
		public function getOtherBattles(index:int):BattleFieldBean {
			var res:BattleFieldBean = BattleFieldBean(this.otherBattlesArray[index]);
			return res; 
		}
		public function setOtherBattles(bean:BattleFieldBean, index:int):void {
			this.otherBattlesArray[index] = bean;
		}

		public function copyToBe(target:BattleInfoResponse):void {
			target.success = this.success 
		}
		
		public function toBeObject():Object {
			var obj:Object = new Object();
			obj.success = this.success;
			return obj;
		}

		public override function toBeString(pre:String=""):String {
			var str:String = "---- BattleInfoResponse ----\n"  + this.toBeErrorString();
			str += pre + "success = " + this.success + "\n" ;

			var i:int;
			for (i=0; i<this.attackBattlesArray.length; i++) {
				str += this.getAttackBattles(i).toBeString(pre + "attackBattles[" + i + "].") ;
			}
			
			for (i=0; i<this.defendBattlesArray.length; i++) {
				str += this.getDefendBattles(i).toBeString(pre + "defendBattles[" + i + "].") ;
			}
			
			for (i=0; i<this.otherBattlesArray.length; i++) {
				str += this.getOtherBattles(i).toBeString(pre + "otherBattles[" + i + "].") ;
			}
			

			return str;  
		}
	}
}