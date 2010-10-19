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
	
	public class AllianceMemberListResponse extends BaseResponse
	{
		public function AllianceMemberListResponse(type:String, data:Object,bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.setResponseData(data);
				if (data.success!=null) {
					this.success = data.success;
				}
			
				var n:int;
				if (data.memberInfo) {
					for (n=0; n<data.memberInfo.length; n++) {
						var _memberInfo:PlayerInfoDataBean = new PlayerInfoDataBean(data.memberInfo[n]);
						this.memberInfoArray.addItem(_memberInfo);
					}
				}
			
		}

		public var success:Boolean;

		public var memberInfoArray:ArrayCollection = new ArrayCollection();
			
		public function getMemberInfo(index:int):PlayerInfoDataBean {
			var res:PlayerInfoDataBean = PlayerInfoDataBean(this.memberInfoArray[index]);
			return res; 
		}
		public function setMemberInfo(bean:PlayerInfoDataBean, index:int):void {
			this.memberInfoArray[index] = bean;
		}

		public function copyToBe(target:AllianceMemberListResponse):void {
			target.success = this.success 
		}
		
		public function toBeObject():Object {
			var obj:Object = new Object();
			obj.success = this.success;
			return obj;
		}

		public override function toBeString(pre:String=""):String {
			var str:String = "---- AllianceMemberListResponse ----\n"  + this.toBeErrorString();
			str += pre + "success = " + this.success + "\n" ;

			var i:int;
			for (i=0; i<this.memberInfoArray.length; i++) {
				str += this.getMemberInfo(i).toBeString(pre + "memberInfo[" + i + "].") ;
			}
			

			return str;  
		}
	}
}