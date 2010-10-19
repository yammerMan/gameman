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
	
	public class CastleBuffUpdate extends BaseResponse
	{
		public function CastleBuffUpdate(type:String, data:Object,bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.setResponseData(data);
				if (data.buff!=null) {
					this.buff = new BufferBean(data.buff);
				}
				if (data.castleId!=null) {
					this.castleId = data.castleId;
				}
				if (data.updateType!=null) {
					this.updateType = data.updateType;
				}
		}

		public var buff:BufferBean;
		public var castleId:int;
		public var updateType:int;

		public function copyToBe(target:CastleBuffUpdate):void {
			if (buff!=null) {
				this.buff.copyToBe(target.buff)
			} else {
				target.buff = null;
			}
			target.castleId = this.castleId 
			target.updateType = this.updateType 
		}
		
		public function toBeObject():Object {
			var obj:Object = new Object();
			obj.buff = this.buff.toBeObject();
			obj.castleId = this.castleId;
			obj.updateType = this.updateType;
			return obj;
		}

		public override function toBeString(pre:String=""):String {
			var str:String = "---- CastleBuffUpdate ----\n"  + this.toBeErrorString();
			if (buff!=null) {
				str += this.buff.toBeString(pre + "buff.") ;
			} else {
				str += pre + "buff = null\n" ;
			}
			str += pre + "castleId = " + this.castleId + "\n" ;
			str += pre + "updateType = " + this.updateType + "\n" ;

			return str;  
		}
	}
}