/**
* 生成时间 1 
*/
package roma.common.controller.alliance
{
	import framework.game.BaseResponse;
	import roma.common.valueObject.*;
	import mx.collections.ArrayCollection;
	import framework.util.CopyAryUtil;
	import flash.utils.ByteArray;
	
	public class AllianceInfoDataResponse extends BaseResponse
	{
		public function AllianceInfoDataResponse(type:String, data:Object,bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.setResponseData(data);
				if (data.leagueInfo!=null) {
					this.leagueInfo = new RankLeagueBean(data.leagueInfo);
				}
				if (data.success!=null) {
					this.success = data.success;
				}
		}

		public var leagueInfo:RankLeagueBean;
		public var success:Boolean;

		public function copyToBe(target:AllianceInfoDataResponse):void {
			if (leagueInfo!=null) {
				this.leagueInfo.copyToBe(target.leagueInfo)
			} else {
				target.leagueInfo = null;
			}
			target.success = this.success 
		}
		
		public function toBeObject():Object {
			var obj:Object = new Object();
			obj.leagueInfo = this.leagueInfo.toBeObject();
			obj.success = this.success;
			return obj;
		}

		public override function toBeString(pre:String=""):String {
			var str:String = "---- AllianceInfoDataResponse ----\n"  + this.toBeErrorString();
			if (leagueInfo!=null) {
				str += this.leagueInfo.toBeString(pre + "leagueInfo.") ;
			} else {
				str += pre + "leagueInfo = null\n" ;
			}
			str += pre + "success = " + this.success + "\n" ;

			return str;  
		}
	}
}