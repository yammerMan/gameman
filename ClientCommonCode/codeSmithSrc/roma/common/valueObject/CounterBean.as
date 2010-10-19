/**
* 生成时间 1 
*/

package roma.common.valueObject
{
	import mx.collections.ArrayCollection;
	import framework.util.CopyAryUtil;
	import roma.common.valueObject.*;
	import flash.utils.ByteArray;

	[Bindable]
	public class CounterBean
	{
		public function CounterBean(data:Object=null)
		{
			if (data!=null){
				if (data.newBattleMailCounter!=null) {
					this.newBattleMailCounter = data.newBattleMailCounter;
				}
				if (data.newMailCounter!=null) {
					this.newMailCounter = data.newMailCounter;
				}
			}
		}
		

		public var newBattleMailCounter:int;
		public var newMailCounter:int;

		public function copyToBe(target:CounterBean):void {
			target.newBattleMailCounter = this.newBattleMailCounter 
			target.newMailCounter = this.newMailCounter 
		}
		
		public function toBeObject():Object {
			var obj:Object = new Object();
			obj.newBattleMailCounter = this.newBattleMailCounter;
			obj.newMailCounter = this.newMailCounter;
			return obj;
		}

		public function toBeString(pre:String=""):String {
			var str:String = "";
			str += pre + "newBattleMailCounter = " + this.newBattleMailCounter + "\n" ;
			str += pre + "newMailCounter = " + this.newMailCounter + "\n" ;

			return str;  
		}
	}
}