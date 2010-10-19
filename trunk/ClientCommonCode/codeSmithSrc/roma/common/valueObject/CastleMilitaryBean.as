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
	public class CastleMilitaryBean
	{
		public function CastleMilitaryBean(data:Object=null)
		{
			if (data!=null){
				if (data.allow!=null) {
					this.allow = data.allow;
				}
				if (data.antiLoot!=null) {
					this.antiLoot = data.antiLoot;
				}
			}
		}
		

		public var allow:Boolean;
		public var antiLoot:Boolean;

		public function copyToBe(target:CastleMilitaryBean):void {
			target.allow = this.allow 
			target.antiLoot = this.antiLoot 
		}
		
		public function toBeObject():Object {
			var obj:Object = new Object();
			obj.allow = this.allow;
			obj.antiLoot = this.antiLoot;
			return obj;
		}

		public function toBeString(pre:String=""):String {
			var str:String = "";
			str += pre + "allow = " + this.allow + "\n" ;
			str += pre + "antiLoot = " + this.antiLoot + "\n" ;

			return str;  
		}
	}
}