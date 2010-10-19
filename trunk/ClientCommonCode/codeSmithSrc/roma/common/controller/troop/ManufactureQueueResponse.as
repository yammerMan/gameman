/**
* 生成时间 1 
*/
package roma.common.controller.troop
{
	import framework.game.BaseResponse;
	import roma.common.valueObject.*;
	import mx.collections.ArrayCollection;
	import framework.util.CopyAryUtil;
	import flash.utils.ByteArray;
	
	public class ManufactureQueueResponse extends BaseResponse
	{
		public function ManufactureQueueResponse(type:String, data:Object,bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.setResponseData(data);
				if (data.success!=null) {
					this.success = data.success;
				}
			
				var n:int;
				if (data.produces) {
					for (n=0; n<data.produces.length; n++) {
						var _produces:ManufactureBean = new ManufactureBean(data.produces[n]);
						this.producesArray.addItem(_produces);
					}
				}
			
		}

		public var success:Boolean;

		public var producesArray:ArrayCollection = new ArrayCollection();
			
		public function getProduces(index:int):ManufactureBean {
			var res:ManufactureBean = ManufactureBean(this.producesArray[index]);
			return res; 
		}
		public function setProduces(bean:ManufactureBean, index:int):void {
			this.producesArray[index] = bean;
		}

		public function copyToBe(target:ManufactureQueueResponse):void {
			target.success = this.success 
		}
		
		public function toBeObject():Object {
			var obj:Object = new Object();
			obj.success = this.success;
			return obj;
		}

		public override function toBeString(pre:String=""):String {
			var str:String = "---- ManufactureQueueResponse ----\n"  + this.toBeErrorString();
			str += pre + "success = " + this.success + "\n" ;

			var i:int;
			for (i=0; i<this.producesArray.length; i++) {
				str += this.getProduces(i).toBeString(pre + "produces[" + i + "].") ;
			}
			

			return str;  
		}
	}
}