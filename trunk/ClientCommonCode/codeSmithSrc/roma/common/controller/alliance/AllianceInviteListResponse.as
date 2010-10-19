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
	
	public class AllianceInviteListResponse extends BaseResponse
	{
		public function AllianceInviteListResponse(type:String, data:Object,bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.setResponseData(data);
				if (data.success!=null) {
					this.success = data.success;
				}
			
				var n:int;
				if (data.allianceInvite) {
					for (n=0; n<data.allianceInvite.length; n++) {
						var _allianceInvite:AllianceInviteBean = new AllianceInviteBean(data.allianceInvite[n]);
						this.allianceInviteArray.addItem(_allianceInvite);
					}
				}
			
		}

		public var success:Boolean;

		public var allianceInviteArray:ArrayCollection = new ArrayCollection();
			
		public function getAllianceInvite(index:int):AllianceInviteBean {
			var res:AllianceInviteBean = AllianceInviteBean(this.allianceInviteArray[index]);
			return res; 
		}
		public function setAllianceInvite(bean:AllianceInviteBean, index:int):void {
			this.allianceInviteArray[index] = bean;
		}

		public function copyToBe(target:AllianceInviteListResponse):void {
			target.success = this.success 
		}
		
		public function toBeObject():Object {
			var obj:Object = new Object();
			obj.success = this.success;
			return obj;
		}

		public override function toBeString(pre:String=""):String {
			var str:String = "---- AllianceInviteListResponse ----\n"  + this.toBeErrorString();
			str += pre + "success = " + this.success + "\n" ;

			var i:int;
			for (i=0; i<this.allianceInviteArray.length; i++) {
				str += this.getAllianceInvite(i).toBeString(pre + "allianceInvite[" + i + "].") ;
			}
			

			return str;  
		}
	}
}