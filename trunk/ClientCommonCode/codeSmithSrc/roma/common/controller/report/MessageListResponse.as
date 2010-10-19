/**
* 生成时间 1 
*/
package roma.common.controller.report
{
	import framework.game.BaseResponse;
	import roma.common.valueObject.*;
	import mx.collections.ArrayCollection;
	import framework.util.CopyAryUtil;
	import flash.utils.ByteArray;
	
	public class MessageListResponse extends BaseResponse
	{
		public function MessageListResponse(type:String, data:Object,bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.setResponseData(data);
				if (data.pageNo!=null) {
					this.pageNo = data.pageNo;
				}
				if (data.pageSize!=null) {
					this.pageSize = data.pageSize;
				}
				if (data.success!=null) {
					this.success = data.success;
				}
			
				var n:int;
				if (data.array) {
					for (n=0; n<data.array.length; n++) {
						var _array:MessageBean = new MessageBean(data.array[n]);
						this.arrayArray.addItem(_array);
					}
				}
			
		}

		public var pageNo:int;
		public var pageSize:int;
		public var success:Boolean;

		public var arrayArray:ArrayCollection = new ArrayCollection();
			
		public function getArray(index:int):MessageBean {
			var res:MessageBean = MessageBean(this.arrayArray[index]);
			return res; 
		}
		public function setArray(bean:MessageBean, index:int):void {
			this.arrayArray[index] = bean;
		}

		public function copyToBe(target:MessageListResponse):void {
			target.pageNo = this.pageNo 
			target.pageSize = this.pageSize 
			target.success = this.success 
		}
		
		public function toBeObject():Object {
			var obj:Object = new Object();
			obj.pageNo = this.pageNo;
			obj.pageSize = this.pageSize;
			obj.success = this.success;
			return obj;
		}

		public override function toBeString(pre:String=""):String {
			var str:String = "---- MessageListResponse ----\n"  + this.toBeErrorString();
			str += pre + "pageNo = " + this.pageNo + "\n" ;
			str += pre + "pageSize = " + this.pageSize + "\n" ;
			str += pre + "success = " + this.success + "\n" ;

			var i:int;
			for (i=0; i<this.arrayArray.length; i++) {
				str += this.getArray(i).toBeString(pre + "array[" + i + "].") ;
			}
			

			return str;  
		}
	}
}