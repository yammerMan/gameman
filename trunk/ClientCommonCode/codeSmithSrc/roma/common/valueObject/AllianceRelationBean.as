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
	public class AllianceRelationBean
	{
		public function AllianceRelationBean(data:Object=null)
		{
			if (data!=null){
				if (data.allianceId!=null) {
					this.allianceId = data.allianceId;
				}
				if (data.leagueName!=null) {
					this.leagueName = data.leagueName;
				}
				if (data.relationType!=null) {
					this.relationType = data.relationType;
				}
			}
		}
		

		public var allianceId:int;
		public var leagueName:String;
		public var relationType:int;

		public function copyToBe(target:AllianceRelationBean):void {
			target.allianceId = this.allianceId 
			target.leagueName = this.leagueName 
			target.relationType = this.relationType 
		}
		
		public function toBeObject():Object {
			var obj:Object = new Object();
			obj.allianceId = this.allianceId;
			obj.leagueName = this.leagueName;
			obj.relationType = this.relationType;
			return obj;
		}

		public function toBeString(pre:String=""):String {
			var str:String = "";
			str += pre + "allianceId = " + this.allianceId + "\n" ;
			str += pre + "leagueName = " + this.leagueName + "\n" ;
			str += pre + "relationType = " + this.relationType + "\n" ;

			return str;  
		}
	}
}