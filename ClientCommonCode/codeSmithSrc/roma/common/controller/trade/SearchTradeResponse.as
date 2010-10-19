/**
* 生成时间 1 
*/
package roma.common.controller.trade
{
	import framework.game.BaseResponse;
	import roma.common.valueObject.*;
	import mx.collections.ArrayCollection;
	import framework.util.CopyAryUtil;
	import flash.utils.ByteArray;
	
	public class SearchTradeResponse extends BaseResponse
	{
		public function SearchTradeResponse(type:String, data:Object,bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.setResponseData(data);
				if (data.success!=null) {
					this.success = data.success;
				}
			
				var n:int;
				if (data.buys) {
					for (n=0; n<data.buys.length; n++) {
						var _buys:MarketBusinessBean = new MarketBusinessBean(data.buys[n]);
						this.buysArray.addItem(_buys);
					}
				}
			
				if (data.sellers) {
					for (n=0; n<data.sellers.length; n++) {
						var _sellers:MarketBusinessBean = new MarketBusinessBean(data.sellers[n]);
						this.sellersArray.addItem(_sellers);
					}
				}
			
		}

		public var success:Boolean;

		public var buysArray:ArrayCollection = new ArrayCollection();
		public var sellersArray:ArrayCollection = new ArrayCollection();
			
		public function getBuys(index:int):MarketBusinessBean {
			var res:MarketBusinessBean = MarketBusinessBean(this.buysArray[index]);
			return res; 
		}
		public function setBuys(bean:MarketBusinessBean, index:int):void {
			this.buysArray[index] = bean;
		}
		public function getSellers(index:int):MarketBusinessBean {
			var res:MarketBusinessBean = MarketBusinessBean(this.sellersArray[index]);
			return res; 
		}
		public function setSellers(bean:MarketBusinessBean, index:int):void {
			this.sellersArray[index] = bean;
		}

		public function copyToBe(target:SearchTradeResponse):void {
			target.success = this.success 
		}
		
		public function toBeObject():Object {
			var obj:Object = new Object();
			obj.success = this.success;
			return obj;
		}

		public override function toBeString(pre:String=""):String {
			var str:String = "---- SearchTradeResponse ----\n"  + this.toBeErrorString();
			str += pre + "success = " + this.success + "\n" ;

			var i:int;
			for (i=0; i<this.buysArray.length; i++) {
				str += this.getBuys(i).toBeString(pre + "buys[" + i + "].") ;
			}
			
			for (i=0; i<this.sellersArray.length; i++) {
				str += this.getSellers(i).toBeString(pre + "sellers[" + i + "].") ;
			}
			

			return str;  
		}
	}
}