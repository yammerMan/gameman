/**
* 生成时间 1 
*/

package roma.common.valueObject
{
	import mx.collections.ArrayCollection;
	import framework.util.CopyAryUtil;
	import roma.common.valueObject.*;
	import flash.utils.ByteArray;

	[Bindable]
	public class ManufactureQueue
	{
		public function ManufactureQueue(data:Object=null)
		{
			if (data!=null){
				if (data.positionId!=null) {
					this.positionId = data.positionId;
				}
			
				var n:int;
				if (data.produces) {
					for (n=0; n<data.produces.length; n++) {
						var _produces:ManufactureBean = new ManufactureBean(data.produces[n]);
						this.producesArray.addItem(_produces);
					}
				}
			
			}
		}
		

		public var positionId:int;

		public var producesArray:ArrayCollection = new ArrayCollection();
			
		public function getProduces(index:int):ManufactureBean {
			var res:ManufactureBean = ManufactureBean(this.producesArray[index]);
			return res; 
		}
		public function setProduces(bean:ManufactureBean, index:int):void {
			this.producesArray[index] = bean;
		}

		public function copyToBe(target:ManufactureQueue):void {
			target.positionId = this.positionId 
		}
		
		public function toBeObject():Object {
			var obj:Object = new Object();
			obj.positionId = this.positionId;
			return obj;
		}

		public function toBeString(pre:String=""):String {
			var str:String = "";
			str += pre + "positionId = " + this.positionId + "\n" ;

			var i:int;
			for (i=0; i<this.producesArray.length; i++) {
				str += this.getProduces(i).toBeString(pre + "produces[" + i + "].") ;
			}
			

			return str;  
		}
	}
}