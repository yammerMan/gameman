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
	public class HeroRetreatConditionBean
	{
		public function HeroRetreatConditionBean(data:Object=null)
		{
			if (data!=null){
				if (data.casualties!=null) {
					this.casualties = data.casualties;
				}
				if (data.noMelee!=null) {
					this.noMelee = data.noMelee;
				}
				if (data.noRange!=null) {
					this.noRange = data.noRange;
				}
			}
		}
		

		public var casualties:int;
		public var noMelee:Boolean;
		public var noRange:Boolean;

		public function copyToBe(target:HeroRetreatConditionBean):void {
			target.casualties = this.casualties 
			target.noMelee = this.noMelee 
			target.noRange = this.noRange 
		}
		
		public function toBeObject():Object {
			var obj:Object = new Object();
			obj.casualties = this.casualties;
			obj.noMelee = this.noMelee;
			obj.noRange = this.noRange;
			return obj;
		}

		public function toBeString(pre:String=""):String {
			var str:String = "";
			str += pre + "casualties = " + this.casualties + "\n" ;
			str += pre + "noMelee = " + this.noMelee + "\n" ;
			str += pre + "noRange = " + this.noRange + "\n" ;

			return str;  
		}
	}
}