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
	public class AllianceInviteBean
	{
		public function AllianceInviteBean(data:Object=null)
		{
			if (data!=null){
				if (data.allianceId!=null) {
					this.allianceId = data.allianceId;
				}
				if (data.honor!=null) {
					this.honor = data.honor;
				}
				if (data.invitor!=null) {
					this.invitor = data.invitor;
				}
				if (data.leagueName!=null) {
					this.leagueName = data.leagueName;
				}
				if (data.playerId!=null) {
					this.playerId = data.playerId;
				}
				if (data.playerName!=null) {
					this.playerName = data.playerName;
				}
				if (data.rank!=null) {
					this.rank = data.rank;
				}
				if (data.time!=null) {
					this.time = data.time;
				}
			}
		}
		

		public var allianceId:int;
		public var honor:int;
		public var invitor:String;
		public var leagueName:String;
		public var playerId:int;
		public var playerName:String;
		public var rank:int;
		public var time:Number;

		public function copyToBe(target:AllianceInviteBean):void {
			target.allianceId = this.allianceId 
			target.honor = this.honor 
			target.invitor = this.invitor 
			target.leagueName = this.leagueName 
			target.playerId = this.playerId 
			target.playerName = this.playerName 
			target.rank = this.rank 
			target.time = this.time 
		}
		
		public function toBeObject():Object {
			var obj:Object = new Object();
			obj.allianceId = this.allianceId;
			obj.honor = this.honor;
			obj.invitor = this.invitor;
			obj.leagueName = this.leagueName;
			obj.playerId = this.playerId;
			obj.playerName = this.playerName;
			obj.rank = this.rank;
			obj.time = this.time;
			return obj;
		}

		public function toBeString(pre:String=""):String {
			var str:String = "";
			str += pre + "allianceId = " + this.allianceId + "\n" ;
			str += pre + "honor = " + this.honor + "\n" ;
			str += pre + "invitor = " + this.invitor + "\n" ;
			str += pre + "leagueName = " + this.leagueName + "\n" ;
			str += pre + "playerId = " + this.playerId + "\n" ;
			str += pre + "playerName = " + this.playerName + "\n" ;
			str += pre + "rank = " + this.rank + "\n" ;
			str += pre + "time = " + this.time + "\n" ;

			return str;  
		}
	}
}