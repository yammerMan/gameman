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
	
	public class ConquestCastleUpdate extends BaseResponse
	{
		public function ConquestCastleUpdate(type:String, data:Object,bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.setResponseData(data);
				if (data.cityId!=null) {
					this.cityId = data.cityId;
				}
				if (data.conquestBean!=null) {
					this.conquestBean = new RelatedCastleTimeBean(data.conquestBean);
				}
				if (data.updateType!=null) {
					this.updateType = data.updateType;
				}
		}

		public var cityId:int;
		public var conquestBean:RelatedCastleTimeBean;
		public var updateType:int;

		public function copyToBe(target:ConquestCastleUpdate):void {
			target.cityId = this.cityId 
			if (conquestBean!=null) {
				this.conquestBean.copyToBe(target.conquestBean)
			} else {
				target.conquestBean = null;
			}
			target.updateType = this.updateType 
		}
		
		public function toBeObject():Object {
			var obj:Object = new Object();
			obj.cityId = this.cityId;
			obj.conquestBean = this.conquestBean.toBeObject();
			obj.updateType = this.updateType;
			return obj;
		}

		public override function toBeString(pre:String=""):String {
			var str:String = "---- ConquestCastleUpdate ----\n"  + this.toBeErrorString();
			str += pre + "cityId = " + this.cityId + "\n" ;
			if (conquestBean!=null) {
				str += this.conquestBean.toBeString(pre + "conquestBean.") ;
			} else {
				str += pre + "conquestBean = null\n" ;
			}
			str += pre + "updateType = " + this.updateType + "\n" ;

			return str;  
		}
	}
}