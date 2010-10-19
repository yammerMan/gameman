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
	public class ResourceStaticBean
	{
		public function ResourceStaticBean(data:Object=null)
		{
			if (data!=null){
				if (data.basicProduce!=null) {
					this.basicProduce = data.basicProduce;
				}
				if (data.buffIncreasePer!=null) {
					this.buffIncreasePer = data.buffIncreasePer;
				}
				if (data.chiefIncreasePer!=null) {
					this.chiefIncreasePer = data.chiefIncreasePer;
				}
				if (data.conquestAdd!=null) {
					this.conquestAdd = data.conquestAdd;
				}
				if (data.dakTransport!=null) {
					this.dakTransport = data.dakTransport;
				}
				if (data.fieldIncreasePer!=null) {
					this.fieldIncreasePer = data.fieldIncreasePer;
				}
				if (data.militaryConsume!=null) {
					this.militaryConsume = data.militaryConsume;
				}
				if (data.operRate!=null) {
					this.operRate = data.operRate;
				}
				if (data.originalProduce!=null) {
					this.originalProduce = data.originalProduce;
				}
				if (data.techIncreasePer!=null) {
					this.techIncreasePer = data.techIncreasePer;
				}
				if (data.totoalProduce!=null) {
					this.totoalProduce = data.totoalProduce;
				}
			}
		}
		

		public var basicProduce:int;
		public var buffIncreasePer:int;
		public var chiefIncreasePer:int;
		public var conquestAdd:int;
		public var dakTransport:int;
		public var fieldIncreasePer:int;
		public var militaryConsume:int;
		public var operRate:int;
		public var originalProduce:Number;
		public var techIncreasePer:int;
		public var totoalProduce:Number;

		public function copyToBe(target:ResourceStaticBean):void {
			target.basicProduce = this.basicProduce 
			target.buffIncreasePer = this.buffIncreasePer 
			target.chiefIncreasePer = this.chiefIncreasePer 
			target.conquestAdd = this.conquestAdd 
			target.dakTransport = this.dakTransport 
			target.fieldIncreasePer = this.fieldIncreasePer 
			target.militaryConsume = this.militaryConsume 
			target.operRate = this.operRate 
			target.originalProduce = this.originalProduce 
			target.techIncreasePer = this.techIncreasePer 
			target.totoalProduce = this.totoalProduce 
		}
		
		public function toBeObject():Object {
			var obj:Object = new Object();
			obj.basicProduce = this.basicProduce;
			obj.buffIncreasePer = this.buffIncreasePer;
			obj.chiefIncreasePer = this.chiefIncreasePer;
			obj.conquestAdd = this.conquestAdd;
			obj.dakTransport = this.dakTransport;
			obj.fieldIncreasePer = this.fieldIncreasePer;
			obj.militaryConsume = this.militaryConsume;
			obj.operRate = this.operRate;
			obj.originalProduce = this.originalProduce;
			obj.techIncreasePer = this.techIncreasePer;
			obj.totoalProduce = this.totoalProduce;
			return obj;
		}

		public function toBeString(pre:String=""):String {
			var str:String = "";
			str += pre + "basicProduce = " + this.basicProduce + "\n" ;
			str += pre + "buffIncreasePer = " + this.buffIncreasePer + "\n" ;
			str += pre + "chiefIncreasePer = " + this.chiefIncreasePer + "\n" ;
			str += pre + "conquestAdd = " + this.conquestAdd + "\n" ;
			str += pre + "dakTransport = " + this.dakTransport + "\n" ;
			str += pre + "fieldIncreasePer = " + this.fieldIncreasePer + "\n" ;
			str += pre + "militaryConsume = " + this.militaryConsume + "\n" ;
			str += pre + "operRate = " + this.operRate + "\n" ;
			str += pre + "originalProduce = " + this.originalProduce + "\n" ;
			str += pre + "techIncreasePer = " + this.techIncreasePer + "\n" ;
			str += pre + "totoalProduce = " + this.totoalProduce + "\n" ;

			return str;  
		}
	}
}