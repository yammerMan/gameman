/**
* 生成时间 1 
*/
package roma.common.controller.chat
{
	import framework.game.BaseResponse;
	import roma.common.valueObject.*;
	import mx.collections.ArrayCollection;
	import framework.util.CopyAryUtil;
	import flash.utils.ByteArray;
	
	public class PlayerResponse extends BaseResponse
	{
		public function PlayerResponse(type:String, data:Object,bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.setResponseData(data);
				if (data.success!=null) {
					this.success = data.success;
				}
			
				var n:int;
				if (data.playerNames) {
					for (n=0; n<data.playerNames.length; n++) {
						var _playerNames:String = new String(data.playerNames[n]);
						this.playerNamesArray.addItem(_playerNames);
					}
				}
			
		}

		public var success:Boolean;

		public var playerNamesArray:ArrayCollection = new ArrayCollection();
			
		public function getPlayerNames(index:int):String {
			var res:String = String(this.playerNamesArray[index]);
			return res; 
		}
		public function setPlayerNames(bean:String, index:int):void {
			this.playerNamesArray[index] = bean;
		}

		public function copyToBe(target:PlayerResponse):void {
			target.success = this.success 
		}
		
		public function toBeObject():Object {
			var obj:Object = new Object();
			obj.success = this.success;
			return obj;
		}

		public override function toBeString(pre:String=""):String {
			var str:String = "---- PlayerResponse ----\n"  + this.toBeErrorString();
			str += pre + "success = " + this.success + "\n" ;

			var i:int;
			for (i=0; i<this.playerNamesArray.length; i++) {
				str += pre + "playerNames[" + i + "] = " + this.getPlayerNames(i) + "\n" ; 
			}
			

			return str;  
		}
	}
}