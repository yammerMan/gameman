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
	public class BattleFieldBean
	{
		public function BattleFieldBean(data:Object=null)
		{
			if (data!=null){
				if (data.battleId!=null) {
					this.battleId = data.battleId;
				}
				if (data.battleTime!=null) {
					this.battleTime = data.battleTime;
				}
				if (data.battleType!=null) {
					this.battleType = data.battleType;
				}
				if (data.startCastleLogo!=null) {
					this.startCastleLogo = data.startCastleLogo;
				}
				if (data.startCastleName!=null) {
					this.startCastleName = data.startCastleName;
				}
				if (data.startId!=null) {
					this.startId = data.startId;
				}
				if (data.startTime!=null) {
					this.startTime = data.startTime;
				}
				if (data.targetFieldLogo!=null) {
					this.targetFieldLogo = data.targetFieldLogo;
				}
				if (data.targetFieldName!=null) {
					this.targetFieldName = data.targetFieldName;
				}
				if (data.targetFieldType!=null) {
					this.targetFieldType = data.targetFieldType;
				}
				if (data.targetId!=null) {
					this.targetId = data.targetId;
				}
			}
		}
		

		public var battleId:int;
		public var battleTime:Number;
		public var battleType:int;
		public var startCastleLogo:String;
		public var startCastleName:String;
		public var startId:int;
		public var startTime:Number;
		public var targetFieldLogo:String;
		public var targetFieldName:String;
		public var targetFieldType:int;
		public var targetId:int;

		public function copyToBe(target:BattleFieldBean):void {
			target.battleId = this.battleId 
			target.battleTime = this.battleTime 
			target.battleType = this.battleType 
			target.startCastleLogo = this.startCastleLogo 
			target.startCastleName = this.startCastleName 
			target.startId = this.startId 
			target.startTime = this.startTime 
			target.targetFieldLogo = this.targetFieldLogo 
			target.targetFieldName = this.targetFieldName 
			target.targetFieldType = this.targetFieldType 
			target.targetId = this.targetId 
		}
		
		public function toBeObject():Object {
			var obj:Object = new Object();
			obj.battleId = this.battleId;
			obj.battleTime = this.battleTime;
			obj.battleType = this.battleType;
			obj.startCastleLogo = this.startCastleLogo;
			obj.startCastleName = this.startCastleName;
			obj.startId = this.startId;
			obj.startTime = this.startTime;
			obj.targetFieldLogo = this.targetFieldLogo;
			obj.targetFieldName = this.targetFieldName;
			obj.targetFieldType = this.targetFieldType;
			obj.targetId = this.targetId;
			return obj;
		}

		public function toBeString(pre:String=""):String {
			var str:String = "";
			str += pre + "battleId = " + this.battleId + "\n" ;
			str += pre + "battleTime = " + this.battleTime + "\n" ;
			str += pre + "battleType = " + this.battleType + "\n" ;
			str += pre + "startCastleLogo = " + this.startCastleLogo + "\n" ;
			str += pre + "startCastleName = " + this.startCastleName + "\n" ;
			str += pre + "startId = " + this.startId + "\n" ;
			str += pre + "startTime = " + this.startTime + "\n" ;
			str += pre + "targetFieldLogo = " + this.targetFieldLogo + "\n" ;
			str += pre + "targetFieldName = " + this.targetFieldName + "\n" ;
			str += pre + "targetFieldType = " + this.targetFieldType + "\n" ;
			str += pre + "targetId = " + this.targetId + "\n" ;

			return str;  
		}
	}
}