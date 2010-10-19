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
	public class ArchitectureBean
	{
		public function ArchitectureBean(data:Object=null)
		{
			if (data!=null){
				if (data.finishTime!=null) {
					this.finishTime = data.finishTime;
				}
				if (data.level!=null) {
					this.level = data.level;
				}
				if (data.positionId!=null) {
					this.positionId = data.positionId;
				}
				if (data.status!=null) {
					this.status = data.status;
				}
				if (data.timeNeed!=null) {
					this.timeNeed = data.timeNeed;
				}
				if (data.typeId!=null) {
					this.typeId = data.typeId;
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
		

		public var finishTime:Number;
		public var level:int;
		public var positionId:int;
		public var status:int;
		public var timeNeed:int;
		public var typeId:int;

		public var producesArray:ArrayCollection = new ArrayCollection();
			
		public function getProduces(index:int):ManufactureBean {
			var res:ManufactureBean = ManufactureBean(this.producesArray[index]);
			return res; 
		}
		public function setProduces(bean:ManufactureBean, index:int):void {
			this.producesArray[index] = bean;
		}

		public function copyToBe(target:ArchitectureBean):void {
			target.finishTime = this.finishTime 
			target.level = this.level 
			target.positionId = this.positionId 
			target.status = this.status 
			target.timeNeed = this.timeNeed 
			target.typeId = this.typeId 
		}
		
		public function toBeObject():Object {
			var obj:Object = new Object();
			obj.finishTime = this.finishTime;
			obj.level = this.level;
			obj.positionId = this.positionId;
			obj.status = this.status;
			obj.timeNeed = this.timeNeed;
			obj.typeId = this.typeId;
			return obj;
		}

		public function toBeString(pre:String=""):String {
			var str:String = "";
			str += pre + "finishTime = " + this.finishTime + "\n" ;
			str += pre + "level = " + this.level + "\n" ;
			str += pre + "positionId = " + this.positionId + "\n" ;
			str += pre + "status = " + this.status + "\n" ;
			str += pre + "timeNeed = " + this.timeNeed + "\n" ;
			str += pre + "typeId = " + this.typeId + "\n" ;

			var i:int;
			for (i=0; i<this.producesArray.length; i++) {
				str += this.getProduces(i).toBeString(pre + "produces[" + i + "].") ;
			}
			

			return str;  
		}
	}
}