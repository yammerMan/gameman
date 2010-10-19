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
	
	public class ResourceMaterialUpdate extends BaseResponse
	{
		public function ResourceMaterialUpdate(type:String, data:Object,bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.setResponseData(data);
				if (data.castleResource!=null) {
					this.castleResource = new CityResourceBean(data.castleResource);
				}
				if (data.cityId!=null) {
					this.cityId = data.cityId;
				}
				if (data.serverTime!=null) {
					this.serverTime = data.serverTime;
				}
		}

		public var castleResource:CityResourceBean;
		public var cityId:int;
		public var serverTime:Number;

		public function copyToBe(target:ResourceMaterialUpdate):void {
			if (castleResource!=null) {
				this.castleResource.copyToBe(target.castleResource)
			} else {
				target.castleResource = null;
			}
			target.cityId = this.cityId 
			target.serverTime = this.serverTime 
		}
		
		public function toBeObject():Object {
			var obj:Object = new Object();
			obj.castleResource = this.castleResource.toBeObject();
			obj.cityId = this.cityId;
			obj.serverTime = this.serverTime;
			return obj;
		}

		public override function toBeString(pre:String=""):String {
			var str:String = "---- ResourceMaterialUpdate ----\n"  + this.toBeErrorString();
			if (castleResource!=null) {
				str += this.castleResource.toBeString(pre + "castleResource.") ;
			} else {
				str += pre + "castleResource = null\n" ;
			}
			str += pre + "cityId = " + this.cityId + "\n" ;
			str += pre + "serverTime = " + this.serverTime + "\n" ;

			return str;  
		}
	}
}