/**
* 生成时间 1 
*/
package roma.common.controller.alliance
{
	import framework.game.BaseResponse;
	import roma.common.valueObject.*;
	import mx.collections.ArrayCollection;
	import framework.util.CopyAryUtil;
	import flash.utils.ByteArray;
	
	public class MilitaryListResponse extends BaseResponse
	{
		public function MilitaryListResponse(type:String, data:Object,bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.setResponseData(data);
				if (data.pageNo!=null) {
					this.pageNo = data.pageNo;
				}
				if (data.totalPage!=null) {
					this.totalPage = data.totalPage;
				}
				if (data.success!=null) {
					this.success = data.success;
				}
		}

		public var pageNo:int;
		public var totalPage:int;
		public var success:Boolean;

		public function copyToBe(target:MilitaryListResponse):void {
			target.pageNo = this.pageNo 
			target.totalPage = this.totalPage 
			target.success = this.success 
		}
		
		public function toBeObject():Object {
			var obj:Object = new Object();
			obj.pageNo = this.pageNo;
			obj.totalPage = this.totalPage;
			obj.success = this.success;
			return obj;
		}

		public override function toBeString(pre:String=""):String {
			var str:String = "---- MilitaryListResponse ----\n"  + this.toBeErrorString();
			str += pre + "pageNo = " + this.pageNo + "\n" ;
			str += pre + "totalPage = " + this.totalPage + "\n" ;
			str += pre + "success = " + this.success + "\n" ;

			return str;  
		}
	}
}