/**
* 生成时间 1 
*/
package roma.common.events
{
	import framework.game.BaseResponse;
	import roma.common.valueObject.*;
	import mx.collections.ArrayCollection;
	import framework.util.CopyAryUtil;
	import flash.utils.ByteArray;
	
	public class PlayerInfoDataUpdate extends BaseResponse
	{
		public function PlayerInfoDataUpdate(type:String, data:Object,bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.setResponseData(data);
				if (data.playerInfo!=null) {
					this.playerInfo = new PlayerInfoDataBean(data.playerInfo);
				}
		}

		public var playerInfo:PlayerInfoDataBean;

		public function copyToBe(target:PlayerInfoDataUpdate):void {
			if (playerInfo!=null) {
				this.playerInfo.copyToBe(target.playerInfo)
			} else {
				target.playerInfo = null;
			}
		}
		
		public function toBeObject():Object {
			var obj:Object = new Object();
			obj.playerInfo = this.playerInfo.toBeObject();
			return obj;
		}

		public override function toBeString(pre:String=""):String {
			var str:String = "---- PlayerInfoDataUpdate ----\n"  + this.toBeErrorString();
			if (playerInfo!=null) {
				str += this.playerInfo.toBeString(pre + "playerInfo.") ;
			} else {
				str += pre + "playerInfo = null\n" ;
			}

			return str;  
		}
	}
}