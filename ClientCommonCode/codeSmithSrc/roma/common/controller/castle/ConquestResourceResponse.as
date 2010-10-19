/**
* 生成时间 1 
*/
package roma.common.controller.castle
{
	import framework.game.BaseResponse;
	import roma.common.valueObject.*;
	import mx.collections.ArrayCollection;
	import framework.util.CopyAryUtil;
	import flash.utils.ByteArray;
	
	public class ConquestResourceResponse extends BaseResponse
	{
		public function ConquestResourceResponse(type:String, data:Object,bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.setResponseData(data);
				if (data.foods!=null) {
					this.foods = data.foods;
				}
				if (data.irons!=null) {
					this.irons = data.irons;
				}
				if (data.stones!=null) {
					this.stones = data.stones;
				}
				if (data.woods!=null) {
					this.woods = data.woods;
				}
				if (data.success!=null) {
					this.success = data.success;
				}
		}

		public var foods:int;
		public var irons:int;
		public var stones:int;
		public var woods:int;
		public var success:Boolean;

		public function copyToBe(target:ConquestResourceResponse):void {
			target.foods = this.foods 
			target.irons = this.irons 
			target.stones = this.stones 
			target.woods = this.woods 
			target.success = this.success 
		}
		
		public function toBeObject():Object {
			var obj:Object = new Object();
			obj.foods = this.foods;
			obj.irons = this.irons;
			obj.stones = this.stones;
			obj.woods = this.woods;
			obj.success = this.success;
			return obj;
		}

		public override function toBeString(pre:String=""):String {
			var str:String = "---- ConquestResourceResponse ----\n"  + this.toBeErrorString();
			str += pre + "foods = " + this.foods + "\n" ;
			str += pre + "irons = " + this.irons + "\n" ;
			str += pre + "stones = " + this.stones + "\n" ;
			str += pre + "woods = " + this.woods + "\n" ;
			str += pre + "success = " + this.success + "\n" ;

			return str;  
		}
	}
}