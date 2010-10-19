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
	
	public class TransportUpdate extends BaseResponse
	{
		public function TransportUpdate(type:String, data:Object,bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.setResponseData(data);
				if (data.cityId!=null) {
					this.cityId = data.cityId;
				}
				if (data.transport!=null) {
					this.transport = new TransportBean(data.transport);
				}
				if (data.transportId!=null) {
					this.transportId = data.transportId;
				}
				if (data.updateType!=null) {
					this.updateType = data.updateType;
				}
		}

		public var cityId:int;
		public var transport:TransportBean;
		public var transportId:int;
		public var updateType:int;

		public function copyToBe(target:TransportUpdate):void {
			target.cityId = this.cityId 
			if (transport!=null) {
				this.transport.copyToBe(target.transport)
			} else {
				target.transport = null;
			}
			target.transportId = this.transportId 
			target.updateType = this.updateType 
		}
		
		public function toBeObject():Object {
			var obj:Object = new Object();
			obj.cityId = this.cityId;
			obj.transport = this.transport.toBeObject();
			obj.transportId = this.transportId;
			obj.updateType = this.updateType;
			return obj;
		}

		public override function toBeString(pre:String=""):String {
			var str:String = "---- TransportUpdate ----\n"  + this.toBeErrorString();
			str += pre + "cityId = " + this.cityId + "\n" ;
			if (transport!=null) {
				str += this.transport.toBeString(pre + "transport.") ;
			} else {
				str += pre + "transport = null\n" ;
			}
			str += pre + "transportId = " + this.transportId + "\n" ;
			str += pre + "updateType = " + this.updateType + "\n" ;

			return str;  
		}
	}
}