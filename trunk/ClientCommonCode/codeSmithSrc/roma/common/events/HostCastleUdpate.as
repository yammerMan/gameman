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
	
	public class HostCastleUdpate extends BaseResponse
	{
		public function HostCastleUdpate(type:String, data:Object,bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.setResponseData(data);
				if (data.cityId!=null) {
					this.cityId = data.cityId;
				}
				if (data.hostCastle!=null) {
					this.hostCastle = new RelatedCastleTimeBean(data.hostCastle);
				}
				if (data.updateType!=null) {
					this.updateType = data.updateType;
				}
		}

		public var cityId:int;
		public var hostCastle:RelatedCastleTimeBean;
		public var updateType:int;

		public function copyToBe(target:HostCastleUdpate):void {
			target.cityId = this.cityId 
			if (hostCastle!=null) {
				this.hostCastle.copyToBe(target.hostCastle)
			} else {
				target.hostCastle = null;
			}
			target.updateType = this.updateType 
		}
		
		public function toBeObject():Object {
			var obj:Object = new Object();
			obj.cityId = this.cityId;
			obj.hostCastle = this.hostCastle.toBeObject();
			obj.updateType = this.updateType;
			return obj;
		}

		public override function toBeString(pre:String=""):String {
			var str:String = "---- HostCastleUdpate ----\n"  + this.toBeErrorString();
			str += pre + "cityId = " + this.cityId + "\n" ;
			if (hostCastle!=null) {
				str += this.hostCastle.toBeString(pre + "hostCastle.") ;
			} else {
				str += pre + "hostCastle = null\n" ;
			}
			str += pre + "updateType = " + this.updateType + "\n" ;

			return str;  
		}
	}
}