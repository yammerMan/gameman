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
	
	public class AllianceRelactionResponse extends BaseResponse
	{
		public function AllianceRelactionResponse(type:String, data:Object,bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.setResponseData(data);
				if (data.success!=null) {
					this.success = data.success;
				}
			
				var n:int;
				if (data.allianceRelations) {
					for (n=0; n<data.allianceRelations.length; n++) {
						var _allianceRelations:AllianceRelationBean = new AllianceRelationBean(data.allianceRelations[n]);
						this.allianceRelationsArray.addItem(_allianceRelations);
					}
				}
			
		}

		public var success:Boolean;

		public var allianceRelationsArray:ArrayCollection = new ArrayCollection();
			
		public function getAllianceRelations(index:int):AllianceRelationBean {
			var res:AllianceRelationBean = AllianceRelationBean(this.allianceRelationsArray[index]);
			return res; 
		}
		public function setAllianceRelations(bean:AllianceRelationBean, index:int):void {
			this.allianceRelationsArray[index] = bean;
		}

		public function copyToBe(target:AllianceRelactionResponse):void {
			target.success = this.success 
		}
		
		public function toBeObject():Object {
			var obj:Object = new Object();
			obj.success = this.success;
			return obj;
		}

		public override function toBeString(pre:String=""):String {
			var str:String = "---- AllianceRelactionResponse ----\n"  + this.toBeErrorString();
			str += pre + "success = " + this.success + "\n" ;

			var i:int;
			for (i=0; i<this.allianceRelationsArray.length; i++) {
				str += this.getAllianceRelations(i).toBeString(pre + "allianceRelations[" + i + "].") ;
			}
			

			return str;  
		}
	}
}