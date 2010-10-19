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
	
	public class FriendRelationUpdate extends BaseResponse
	{
		public function FriendRelationUpdate(type:String, data:Object,bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.setResponseData(data);
				if (data.bean!=null) {
					this.bean = new FriendRelationBean(data.bean);
				}
				if (data.relationType!=null) {
					this.relationType = data.relationType;
				}
				if (data.updateType!=null) {
					this.updateType = data.updateType;
				}
		}

		public var bean:FriendRelationBean;
		public var relationType:int;
		public var updateType:int;

		public function copyToBe(target:FriendRelationUpdate):void {
			if (bean!=null) {
				this.bean.copyToBe(target.bean)
			} else {
				target.bean = null;
			}
			target.relationType = this.relationType 
			target.updateType = this.updateType 
		}
		
		public function toBeObject():Object {
			var obj:Object = new Object();
			obj.bean = this.bean.toBeObject();
			obj.relationType = this.relationType;
			obj.updateType = this.updateType;
			return obj;
		}

		public override function toBeString(pre:String=""):String {
			var str:String = "---- FriendRelationUpdate ----\n"  + this.toBeErrorString();
			if (bean!=null) {
				str += this.bean.toBeString(pre + "bean.") ;
			} else {
				str += pre + "bean = null\n" ;
			}
			str += pre + "relationType = " + this.relationType + "\n" ;
			str += pre + "updateType = " + this.updateType + "\n" ;

			return str;  
		}
	}
}