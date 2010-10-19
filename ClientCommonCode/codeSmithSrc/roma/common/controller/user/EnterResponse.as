/**
* 生成时间 1 
*/
package roma.common.controller.user
{
	import framework.game.BaseResponse;
	import roma.common.valueObject.*;
	import mx.collections.ArrayCollection;
	import framework.util.CopyAryUtil;
	import flash.utils.ByteArray;
	
	public class EnterResponse extends BaseResponse
	{
		public function EnterResponse(type:String, data:Object,bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.setResponseData(data);
				if (data.player!=null) {
					this.player = new PlayerDataBean(data.player);
				}
				if (data.restartTime!=null) {
					this.restartTime = data.restartTime;
				}
				if (data.firstTimeLogin!=null) {
					this.firstTimeLogin = data.firstTimeLogin;
				}
				if (data.success!=null) {
					this.success = data.success;
				}
		}

		public var player:PlayerDataBean;
		public var restartTime:Number;
		public var firstTimeLogin:Boolean;
		public var success:Boolean;

		public function copyToBe(target:EnterResponse):void {
			if (player!=null) {
				this.player.copyToBe(target.player)
			} else {
				target.player = null;
			}
			target.restartTime = this.restartTime 
			target.firstTimeLogin = this.firstTimeLogin 
			target.success = this.success 
		}
		
		public function toBeObject():Object {
			var obj:Object = new Object();
			obj.player = this.player.toBeObject();
			obj.restartTime = this.restartTime;
			obj.firstTimeLogin = this.firstTimeLogin;
			obj.success = this.success;
			return obj;
		}

		public override function toBeString(pre:String=""):String {
			var str:String = "---- EnterResponse ----\n"  + this.toBeErrorString();
			if (player!=null) {
				str += this.player.toBeString(pre + "player.") ;
			} else {
				str += pre + "player = null\n" ;
			}
			str += pre + "restartTime = " + this.restartTime + "\n" ;
			str += pre + "firstTimeLogin = " + this.firstTimeLogin + "\n" ;
			str += pre + "success = " + this.success + "\n" ;

			return str;  
		}
	}
}