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
	
	public class PlayerBufferUpdate extends BaseResponse
	{
		public function PlayerBufferUpdate(type:String, data:Object,bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.setResponseData(data);
				if (data.buffBean!=null) {
					this.buffBean = new BufferBean(data.buffBean);
				}
				if (data.updateType!=null) {
					this.updateType = data.updateType;
				}
		}

		public var buffBean:BufferBean;
		public var updateType:int;

		public function copyToBe(target:PlayerBufferUpdate):void {
			if (buffBean!=null) {
				this.buffBean.copyToBe(target.buffBean)
			} else {
				target.buffBean = null;
			}
			target.updateType = this.updateType 
		}
		
		public function toBeObject():Object {
			var obj:Object = new Object();
			obj.buffBean = this.buffBean.toBeObject();
			obj.updateType = this.updateType;
			return obj;
		}

		public override function toBeString(pre:String=""):String {
			var str:String = "---- PlayerBufferUpdate ----\n"  + this.toBeErrorString();
			if (buffBean!=null) {
				str += this.buffBean.toBeString(pre + "buffBean.") ;
			} else {
				str += pre + "buffBean = null\n" ;
			}
			str += pre + "updateType = " + this.updateType + "\n" ;

			return str;  
		}
	}
}