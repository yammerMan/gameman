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
	
	public class AllianceApplyListResponse extends BaseResponse
	{
		public function AllianceApplyListResponse(type:String, data:Object,bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.setResponseData(data);
				if (data.success!=null) {
					this.success = data.success;
				}
			
				var n:int;
				if (data.allianceApply) {
					for (n=0; n<data.allianceApply.length; n++) {
						var _allianceApply:AllianceApplyBean = new AllianceApplyBean(data.allianceApply[n]);
						this.allianceApplyArray.addItem(_allianceApply);
					}
				}
			
		}

		public var success:Boolean;

		public var allianceApplyArray:ArrayCollection = new ArrayCollection();
			
		public function getAllianceApply(index:int):AllianceApplyBean {
			var res:AllianceApplyBean = AllianceApplyBean(this.allianceApplyArray[index]);
			return res; 
		}
		public function setAllianceApply(bean:AllianceApplyBean, index:int):void {
			this.allianceApplyArray[index] = bean;
		}

		public function copyToBe(target:AllianceApplyListResponse):void {
			target.success = this.success 
		}
		
		public function toBeObject():Object {
			var obj:Object = new Object();
			obj.success = this.success;
			return obj;
		}

		public override function toBeString(pre:String=""):String {
			var str:String = "---- AllianceApplyListResponse ----\n"  + this.toBeErrorString();
			str += pre + "success = " + this.success + "\n" ;

			var i:int;
			for (i=0; i<this.allianceApplyArray.length; i++) {
				str += this.getAllianceApply(i).toBeString(pre + "allianceApply[" + i + "].") ;
			}
			

			return str;  
		}
	}
}