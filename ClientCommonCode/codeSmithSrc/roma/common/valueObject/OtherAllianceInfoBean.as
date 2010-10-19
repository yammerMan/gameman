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
	public class OtherAllianceInfoBean
	{
		public function OtherAllianceInfoBean(data:Object=null)
		{
			if (data!=null){
				if (data.allianceId!=null) {
					this.allianceId = data.allianceId;
				}
				if (data.leagueName!=null) {
					this.leagueName = data.leagueName;
				}
			}
		}
		

		public var allianceId:int;
		public var leagueName:String;

		public function copyToBe(target:OtherAllianceInfoBean):void {
			target.allianceId = this.allianceId 
			target.leagueName = this.leagueName 
		}
		
		public function toBeObject():Object {
			var obj:Object = new Object();
			obj.allianceId = this.allianceId;
			obj.leagueName = this.leagueName;
			return obj;
		}

		public function toBeString(pre:String=""):String {
			var str:String = "";
			str += pre + "allianceId = " + this.allianceId + "\n" ;
			str += pre + "leagueName = " + this.leagueName + "\n" ;

			return str;  
		}
	}
}