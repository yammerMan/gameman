/**
* 生成时间 1 
*/
package roma.common.events
{
	import framework.game.BaseResponse;
	import roma.common.valueObject.*;
	import mx.collections.ArrayCollection;
	import framework.util.CopyAryUtil;
	import flash.utils.ByteArray;
	
	public class AllianceRelationEvent extends BaseResponse
	{
		public function AllianceRelationEvent(type:String, data:Object,bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.setResponseData(data);
				if (data.fromAlliance!=null) {
					this.fromAlliance = data.fromAlliance;
				}
				if (data.relation!=null) {
					this.relation = data.relation;
				}
				if (data.toAlliance!=null) {
					this.toAlliance = data.toAlliance;
				}
		}

		public var fromAlliance:String;
		public var relation:int;
		public var toAlliance:String;

		public function copyToBe(target:AllianceRelationEvent):void {
			target.fromAlliance = this.fromAlliance 
			target.relation = this.relation 
			target.toAlliance = this.toAlliance 
		}
		
		public function toBeObject():Object {
			var obj:Object = new Object();
			obj.fromAlliance = this.fromAlliance;
			obj.relation = this.relation;
			obj.toAlliance = this.toAlliance;
			return obj;
		}

		public override function toBeString(pre:String=""):String {
			var str:String = "---- AllianceRelationEvent ----\n"  + this.toBeErrorString();
			str += pre + "fromAlliance = " + this.fromAlliance + "\n" ;
			str += pre + "relation = " + this.relation + "\n" ;
			str += pre + "toAlliance = " + this.toAlliance + "\n" ;

			return str;  
		}
	}
}