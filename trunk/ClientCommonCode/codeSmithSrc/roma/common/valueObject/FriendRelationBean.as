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
	public class FriendRelationBean
	{
		public function FriendRelationBean(data:Object=null)
		{
			if (data!=null){
				if (data.leagueName!=null) {
					this.leagueName = data.leagueName;
				}
				if (data.logo!=null) {
					this.logo = data.logo;
				}
				if (data.playerId!=null) {
					this.playerId = data.playerId;
				}
				if (data.playerName!=null) {
					this.playerName = data.playerName;
				}
				if (data.remark!=null) {
					this.remark = data.remark;
				}
			}
		}
		

		public var leagueName:String;
		public var logo:String;
		public var playerId:int;
		public var playerName:String;
		public var remark:String;

		public function copyToBe(target:FriendRelationBean):void {
			target.leagueName = this.leagueName 
			target.logo = this.logo 
			target.playerId = this.playerId 
			target.playerName = this.playerName 
			target.remark = this.remark 
		}
		
		public function toBeObject():Object {
			var obj:Object = new Object();
			obj.leagueName = this.leagueName;
			obj.logo = this.logo;
			obj.playerId = this.playerId;
			obj.playerName = this.playerName;
			obj.remark = this.remark;
			return obj;
		}

		public function toBeString(pre:String=""):String {
			var str:String = "";
			str += pre + "leagueName = " + this.leagueName + "\n" ;
			str += pre + "logo = " + this.logo + "\n" ;
			str += pre + "playerId = " + this.playerId + "\n" ;
			str += pre + "playerName = " + this.playerName + "\n" ;
			str += pre + "remark = " + this.remark + "\n" ;

			return str;  
		}
	}
}