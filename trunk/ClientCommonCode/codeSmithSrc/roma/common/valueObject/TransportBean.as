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
	public class TransportBean
	{
		public function TransportBean(data:Object=null)
		{
			if (data!=null){
				if (data.endTime!=null) {
					this.endTime = data.endTime;
				}
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
				if (data.positionName!=null) {
					this.positionName = data.positionName;
				}
				if (data.stones!=null) {
					this.stones = data.stones;
				}
				if (data.taravanUsed!=null) {
					this.taravanUsed = data.taravanUsed;
				}
				if (data.userName!=null) {
					this.userName = data.userName;
				}
				if (data.woods!=null) {
					this.woods = data.woods;
				}
				if (data.goBack!=null) {
					this.goBack = data.goBack;
				}
				if (data.self!=null) {
					this.self = data.self;
				}
			}
		}
		

		public var endTime:Number;
		public var foods:int;
		public var golds:int;
		public var id:int;
		public var irons:int;
		public var positionName:String;
		public var stones:int;
		public var taravanUsed:int;
		public var userName:String;
		public var woods:int;
		public var goBack:Boolean;
		public var self:Boolean;

		public function copyToBe(target:TransportBean):void {
			target.endTime = this.endTime 
			target.foods = this.foods 
			target.golds = this.golds 
			target.id = this.id 
			target.irons = this.irons 
			target.positionName = this.positionName 
			target.stones = this.stones 
			target.taravanUsed = this.taravanUsed 
			target.userName = this.userName 
			target.woods = this.woods 
			target.goBack = this.goBack 
			target.self = this.self 
		}
		
		public function toBeObject():Object {
			var obj:Object = new Object();
			obj.endTime = this.endTime;
			obj.foods = this.foods;
			obj.golds = this.golds;
			obj.id = this.id;
			obj.irons = this.irons;
			obj.positionName = this.positionName;
			obj.stones = this.stones;
			obj.taravanUsed = this.taravanUsed;
			obj.userName = this.userName;
			obj.woods = this.woods;
			obj.goBack = this.goBack;
			obj.self = this.self;
			return obj;
		}

		public function toBeString(pre:String=""):String {
			var str:String = "";
			str += pre + "endTime = " + this.endTime + "\n" ;
			str += pre + "foods = " + this.foods + "\n" ;
			str += pre + "golds = " + this.golds + "\n" ;
			str += pre + "id = " + this.id + "\n" ;
			str += pre + "irons = " + this.irons + "\n" ;
			str += pre + "positionName = " + this.positionName + "\n" ;
			str += pre + "stones = " + this.stones + "\n" ;
			str += pre + "taravanUsed = " + this.taravanUsed + "\n" ;
			str += pre + "userName = " + this.userName + "\n" ;
			str += pre + "woods = " + this.woods + "\n" ;
			str += pre + "goBack = " + this.goBack + "\n" ;
			str += pre + "self = " + this.self + "\n" ;

			return str;  
		}
	}
}