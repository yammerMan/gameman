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
	
	public class AllianceMessageListResponse extends BaseResponse
	{
		public function AllianceMessageListResponse(type:String, data:Object,bubbles:Boolean=false, cancelable:Boolean=false)
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
			
				var n:int;
				if (data.eventList) {
					for (n=0; n<data.eventList.length; n++) {
						var _eventList:AllianceEventBean = new AllianceEventBean(data.eventList[n]);
						this.eventListArray.addItem(_eventList);
					}
				}
			
		}

		public var pageNo:int;
		public var totalPage:int;
		public var success:Boolean;

		public var eventListArray:ArrayCollection = new ArrayCollection();
			
		public function getEventList(index:int):AllianceEventBean {
			var res:AllianceEventBean = AllianceEventBean(this.eventListArray[index]);
			return res; 
		}
		public function setEventList(bean:AllianceEventBean, index:int):void {
			this.eventListArray[index] = bean;
		}

		public function copyToBe(target:AllianceMessageListResponse):void {
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
			var str:String = "---- AllianceMessageListResponse ----\n"  + this.toBeErrorString();
			str += pre + "pageNo = " + this.pageNo + "\n" ;
			str += pre + "totalPage = " + this.totalPage + "\n" ;
			str += pre + "success = " + this.success + "\n" ;

			var i:int;
			for (i=0; i<this.eventListArray.length; i++) {
				str += this.getEventList(i).toBeString(pre + "eventList[" + i + "].") ;
			}
			

			return str;  
		}
	}
}