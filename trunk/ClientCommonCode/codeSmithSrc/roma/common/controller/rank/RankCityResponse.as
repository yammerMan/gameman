/**
* 生成时间 1 
*/
package roma.common.controller.rank
{
	import framework.game.BaseResponse;
	import roma.common.valueObject.*;
	import mx.collections.ArrayCollection;
	import framework.util.CopyAryUtil;
	import flash.utils.ByteArray;
	
	public class RankCityResponse extends BaseResponse
	{
		public function RankCityResponse(type:String, data:Object,bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.setResponseData(data);
				if (data.pageNo!=null) {
					this.pageNo = data.pageNo;
				}
				if (data.pageSize!=null) {
					this.pageSize = data.pageSize;
				}
				if (data.totalPage!=null) {
					this.totalPage = data.totalPage;
				}
				if (data.success!=null) {
					this.success = data.success;
				}
			
				var n:int;
				if (data.beans) {
					for (n=0; n<data.beans.length; n++) {
						var _beans:RankCityBean = new RankCityBean(data.beans[n]);
						this.beansArray.addItem(_beans);
					}
				}
			
		}

		public var pageNo:int;
		public var pageSize:int;
		public var totalPage:int;
		public var success:Boolean;

		public var beansArray:ArrayCollection = new ArrayCollection();
			
		public function getBeans(index:int):RankCityBean {
			var res:RankCityBean = RankCityBean(this.beansArray[index]);
			return res; 
		}
		public function setBeans(bean:RankCityBean, index:int):void {
			this.beansArray[index] = bean;
		}

		public function copyToBe(target:RankCityResponse):void {
			target.pageNo = this.pageNo 
			target.pageSize = this.pageSize 
			target.totalPage = this.totalPage 
			target.success = this.success 
		}
		
		public function toBeObject():Object {
			var obj:Object = new Object();
			obj.pageNo = this.pageNo;
			obj.pageSize = this.pageSize;
			obj.totalPage = this.totalPage;
			obj.success = this.success;
			return obj;
		}

		public override function toBeString(pre:String=""):String {
			var str:String = "---- RankCityResponse ----\n"  + this.toBeErrorString();
			str += pre + "pageNo = " + this.pageNo + "\n" ;
			str += pre + "pageSize = " + this.pageSize + "\n" ;
			str += pre + "totalPage = " + this.totalPage + "\n" ;
			str += pre + "success = " + this.success + "\n" ;

			var i:int;
			for (i=0; i<this.beansArray.length; i++) {
				str += this.getBeans(i).toBeString(pre + "beans[" + i + "].") ;
			}
			

			return str;  
		}
	}
}