/**
* 生成时间 1 
*/
package roma.common.controller.player
{
	import framework.game.BaseResponse;
	import roma.common.valueObject.*;
	import mx.collections.ArrayCollection;
	import framework.util.CopyAryUtil;
	import flash.utils.ByteArray;
	
	public class PlayerCastleResponse extends BaseResponse
	{
		public function PlayerCastleResponse(type:String, data:Object,bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.setResponseData(data);
				if (data.success!=null) {
					this.success = data.success;
				}
			
				var n:int;
				if (data.citys) {
					for (n=0; n<data.citys.length; n++) {
						var _citys:CastleInfoBean = new CastleInfoBean(data.citys[n]);
						this.citysArray.addItem(_citys);
					}
				}
			
		}

		public var success:Boolean;

		public var citysArray:ArrayCollection = new ArrayCollection();
			
		public function getCitys(index:int):CastleInfoBean {
			var res:CastleInfoBean = CastleInfoBean(this.citysArray[index]);
			return res; 
		}
		public function setCitys(bean:CastleInfoBean, index:int):void {
			this.citysArray[index] = bean;
		}

		public function copyToBe(target:PlayerCastleResponse):void {
			target.success = this.success 
		}
		
		public function toBeObject():Object {
			var obj:Object = new Object();
			obj.success = this.success;
			return obj;
		}

		public override function toBeString(pre:String=""):String {
			var str:String = "---- PlayerCastleResponse ----\n"  + this.toBeErrorString();
			str += pre + "success = " + this.success + "\n" ;

			var i:int;
			for (i=0; i<this.citysArray.length; i++) {
				str += this.getCitys(i).toBeString(pre + "citys[" + i + "].") ;
			}
			

			return str;  
		}
	}
}