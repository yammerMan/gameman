/**
* 生成时间 1 
*/
package roma.common.controller.equip
{
	import framework.game.BaseResponse;
	import roma.common.valueObject.*;
	import mx.collections.ArrayCollection;
	import framework.util.CopyAryUtil;
	import flash.utils.ByteArray;
	
	public class HeroEquipsResponse extends BaseResponse
	{
		public function HeroEquipsResponse(type:String, data:Object,bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.setResponseData(data);
				if (data.success!=null) {
					this.success = data.success;
				}
			
				var n:int;
				if (data.equips) {
					for (n=0; n<data.equips.length; n++) {
						var _equips:String = new String(data.equips[n]);
						this.equipsArray.addItem(_equips);
					}
				}
			
		}

		public var success:Boolean;

		public var equipsArray:ArrayCollection = new ArrayCollection();
			
		public function getEquips(index:int):String {
			var res:String = String(this.equipsArray[index]);
			return res; 
		}
		public function setEquips(bean:String, index:int):void {
			this.equipsArray[index] = bean;
		}

		public function copyToBe(target:HeroEquipsResponse):void {
			target.success = this.success 
		}
		
		public function toBeObject():Object {
			var obj:Object = new Object();
			obj.success = this.success;
			return obj;
		}

		public override function toBeString(pre:String=""):String {
			var str:String = "---- HeroEquipsResponse ----\n"  + this.toBeErrorString();
			str += pre + "success = " + this.success + "\n" ;

			var i:int;
			for (i=0; i<this.equipsArray.length; i++) {
				str += pre + "equips[" + i + "] = " + this.getEquips(i) + "\n" ; 
			}
			

			return str;  
		}
	}
}