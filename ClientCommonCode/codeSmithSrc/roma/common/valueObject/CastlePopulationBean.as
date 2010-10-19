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
	public class CastlePopulationBean
	{
		public function CastlePopulationBean(data:Object=null)
		{
			if (data!=null){
				if (data.curentPop!=null) {
					this.curentPop = data.curentPop;
				}
				if (data.foodRate!=null) {
					this.foodRate = data.foodRate;
				}
				if (data.foodWorker!=null) {
					this.foodWorker = data.foodWorker;
				}
				if (data.ironRate!=null) {
					this.ironRate = data.ironRate;
				}
				if (data.ironWorker!=null) {
					this.ironWorker = data.ironWorker;
				}
				if (data.maxPopu!=null) {
					this.maxPopu = data.maxPopu;
				}
				if (data.popComp!=null) {
					this.popComp = data.popComp;
				}
				if (data.popSupp!=null) {
					this.popSupp = data.popSupp;
				}
				if (data.stoneRate!=null) {
					this.stoneRate = data.stoneRate;
				}
				if (data.stoneWorker!=null) {
					this.stoneWorker = data.stoneWorker;
				}
				if (data.tax!=null) {
					this.tax = data.tax;
				}
				if (data.woodRate!=null) {
					this.woodRate = data.woodRate;
				}
				if (data.woodWorker!=null) {
					this.woodWorker = data.woodWorker;
				}
			}
		}
		

		public var curentPop:int;
		public var foodRate:int;
		public var foodWorker:int;
		public var ironRate:int;
		public var ironWorker:int;
		public var maxPopu:int;
		public var popComp:int;
		public var popSupp:int;
		public var stoneRate:int;
		public var stoneWorker:int;
		public var tax:int;
		public var woodRate:int;
		public var woodWorker:int;

		public function copyToBe(target:CastlePopulationBean):void {
			target.curentPop = this.curentPop 
			target.foodRate = this.foodRate 
			target.foodWorker = this.foodWorker 
			target.ironRate = this.ironRate 
			target.ironWorker = this.ironWorker 
			target.maxPopu = this.maxPopu 
			target.popComp = this.popComp 
			target.popSupp = this.popSupp 
			target.stoneRate = this.stoneRate 
			target.stoneWorker = this.stoneWorker 
			target.tax = this.tax 
			target.woodRate = this.woodRate 
			target.woodWorker = this.woodWorker 
		}
		
		public function toBeObject():Object {
			var obj:Object = new Object();
			obj.curentPop = this.curentPop;
			obj.foodRate = this.foodRate;
			obj.foodWorker = this.foodWorker;
			obj.ironRate = this.ironRate;
			obj.ironWorker = this.ironWorker;
			obj.maxPopu = this.maxPopu;
			obj.popComp = this.popComp;
			obj.popSupp = this.popSupp;
			obj.stoneRate = this.stoneRate;
			obj.stoneWorker = this.stoneWorker;
			obj.tax = this.tax;
			obj.woodRate = this.woodRate;
			obj.woodWorker = this.woodWorker;
			return obj;
		}

		public function toBeString(pre:String=""):String {
			var str:String = "";
			str += pre + "curentPop = " + this.curentPop + "\n" ;
			str += pre + "foodRate = " + this.foodRate + "\n" ;
			str += pre + "foodWorker = " + this.foodWorker + "\n" ;
			str += pre + "ironRate = " + this.ironRate + "\n" ;
			str += pre + "ironWorker = " + this.ironWorker + "\n" ;
			str += pre + "maxPopu = " + this.maxPopu + "\n" ;
			str += pre + "popComp = " + this.popComp + "\n" ;
			str += pre + "popSupp = " + this.popSupp + "\n" ;
			str += pre + "stoneRate = " + this.stoneRate + "\n" ;
			str += pre + "stoneWorker = " + this.stoneWorker + "\n" ;
			str += pre + "tax = " + this.tax + "\n" ;
			str += pre + "woodRate = " + this.woodRate + "\n" ;
			str += pre + "woodWorker = " + this.woodWorker + "\n" ;

			return str;  
		}
	}
}