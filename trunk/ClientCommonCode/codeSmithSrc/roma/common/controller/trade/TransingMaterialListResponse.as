/**
* 生成时间 1 
*/
package roma.common.controller.trade
{
	import framework.game.BaseResponse;
	import roma.common.valueObject.*;
	import mx.collections.ArrayCollection;
	import framework.util.CopyAryUtil;
	import flash.utils.ByteArray;
	
	public class TransingMaterialListResponse extends BaseResponse
	{
		public function TransingMaterialListResponse(type:String, data:Object,bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.setResponseData(data);
				if (data.success!=null) {
					this.success = data.success;
				}
			
				var n:int;
				if (data.transingMaterials) {
					for (n=0; n<data.transingMaterials.length; n++) {
						var _transingMaterials:TransingBusinessBean = new TransingBusinessBean(data.transingMaterials[n]);
						this.transingMaterialsArray.addItem(_transingMaterials);
					}
				}
			
		}

		public var success:Boolean;

		public var transingMaterialsArray:ArrayCollection = new ArrayCollection();
			
		public function getTransingMaterials(index:int):TransingBusinessBean {
			var res:TransingBusinessBean = TransingBusinessBean(this.transingMaterialsArray[index]);
			return res; 
		}
		public function setTransingMaterials(bean:TransingBusinessBean, index:int):void {
			this.transingMaterialsArray[index] = bean;
		}

		public function copyToBe(target:TransingMaterialListResponse):void {
			target.success = this.success 
		}
		
		public function toBeObject():Object {
			var obj:Object = new Object();
			obj.success = this.success;
			return obj;
		}

		public override function toBeString(pre:String=""):String {
			var str:String = "---- TransingMaterialListResponse ----\n"  + this.toBeErrorString();
			str += pre + "success = " + this.success + "\n" ;

			var i:int;
			for (i=0; i<this.transingMaterialsArray.length; i++) {
				str += this.getTransingMaterials(i).toBeString(pre + "transingMaterials[" + i + "].") ;
			}
			

			return str;  
		}
	}
}