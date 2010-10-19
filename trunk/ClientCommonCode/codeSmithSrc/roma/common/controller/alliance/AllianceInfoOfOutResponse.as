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
	
	public class AllianceInfoOfOutResponse extends BaseResponse
	{
		public function AllianceInfoOfOutResponse(type:String, data:Object,bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.setResponseData(data);
				if (data.applayBean!=null) {
					this.applayBean = new AllianceApplyBean(data.applayBean);
				}
				if (data.success!=null) {
					this.success = data.success;
				}
			
				var n:int;
				if (data.invitedList) {
					for (n=0; n<data.invitedList.length; n++) {
						var _invitedList:AllianceInviteBean = new AllianceInviteBean(data.invitedList[n]);
						this.invitedListArray.addItem(_invitedList);
					}
				}
			
		}

		public var applayBean:AllianceApplyBean;
		public var success:Boolean;

		public var invitedListArray:ArrayCollection = new ArrayCollection();
			
		public function getInvitedList(index:int):AllianceInviteBean {
			var res:AllianceInviteBean = AllianceInviteBean(this.invitedListArray[index]);
			return res; 
		}
		public function setInvitedList(bean:AllianceInviteBean, index:int):void {
			this.invitedListArray[index] = bean;
		}

		public function copyToBe(target:AllianceInfoOfOutResponse):void {
			if (applayBean!=null) {
				this.applayBean.copyToBe(target.applayBean)
			} else {
				target.applayBean = null;
			}
			target.success = this.success 
		}
		
		public function toBeObject():Object {
			var obj:Object = new Object();
			obj.applayBean = this.applayBean.toBeObject();
			obj.success = this.success;
			return obj;
		}

		public override function toBeString(pre:String=""):String {
			var str:String = "---- AllianceInfoOfOutResponse ----\n"  + this.toBeErrorString();
			if (applayBean!=null) {
				str += this.applayBean.toBeString(pre + "applayBean.") ;
			} else {
				str += pre + "applayBean = null\n" ;
			}
			str += pre + "success = " + this.success + "\n" ;

			var i:int;
			for (i=0; i<this.invitedListArray.length; i++) {
				str += this.getInvitedList(i).toBeString(pre + "invitedList[" + i + "].") ;
			}
			

			return str;  
		}
	}
}