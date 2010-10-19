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
	public class PostTransportBean
	{
		public function PostTransportBean(data:Object=null)
		{
			if (data!=null){
				if (data.foods!=null) {
					this.foods = data.foods;
				}
				if (data.golds!=null) {
					this.golds = data.golds;
				}
				if (data.id!=null) {
					this.id = data.id;
				}
				if (data.irons!=null) {
					this.irons = data.irons;
				}
				if (data.startCastleId!=null) {
					this.startCastleId = data.startCastleId;
				}
				if (data.stones!=null) {
					this.stones = data.stones;
				}
				if (data.targetCastleId!=null) {
					this.targetCastleId = data.targetCastleId;
				}
				if (data.woods!=null) {
					this.woods = data.woods;
				}
			}
		}
		

		public var foods:int;
		public var golds:int;
		public var id:int;
		public var irons:int;
		public var startCastleId:int;
		public var stones:int;
		public var targetCastleId:int;
		public var woods:int;

		public function copyToBe(target:PostTransportBean):void {
			target.foods = this.foods 
			target.golds = this.golds 
			target.id = this.id 
			target.irons = this.irons 
			target.startCastleId = this.startCastleId 
			target.stones = this.stones 
			target.targetCastleId = this.targetCastleId 
			target.woods = this.woods 
		}
		
		public function toBeObject():Object {
			var obj:Object = new Object();
			obj.foods = this.foods;
			obj.golds = this.golds;
			obj.id = this.id;
			obj.irons = this.irons;
			obj.startCastleId = this.startCastleId;
			obj.stones = this.stones;
			obj.targetCastleId = this.targetCastleId;
			obj.woods = this.woods;
			return obj;
		}

		public function toBeString(pre:String=""):String {
			var str:String = "";
			str += pre + "foods = " + this.foods + "\n" ;
			str += pre + "golds = " + this.golds + "\n" ;
			str += pre + "id = " + this.id + "\n" ;
			str += pre + "irons = " + this.irons + "\n" ;
			str += pre + "startCastleId = " + this.startCastleId + "\n" ;
			str += pre + "stones = " + this.stones + "\n" ;
			str += pre + "targetCastleId = " + this.targetCastleId + "\n" ;
			str += pre + "woods = " + this.woods + "\n" ;

			return str;  
		}
	}
}