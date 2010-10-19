/**
* 生成时间 1 
*/

package roma.common.valueObject
{
	import mx.collections.ArrayCollection;
	import framework.util.CopyAryUtil;
	import roma.common.valueObject.*;
	import flash.utils.ByteArray;

	[Bindable]
	public class CastleInfoBean
	{
		public function CastleInfoBean(data:Object=null)
		{
			if (data!=null){
				if (data.fieldId!=null) {
					this.fieldId = data.fieldId;
				}
				if (data.godType!=null) {
					this.godType = data.godType;
				}
				if (data.id!=null) {
					this.id = data.id;
				}
				if (data.level!=null) {
					this.level = data.level;
				}
				if (data.logoUrl!=null) {
					this.logoUrl = data.logoUrl;
				}
				if (data.name!=null) {
					this.name = data.name;
				}
				if (data.status!=null) {
					this.status = data.status;
				}
			}
		}
		

		public var fieldId:int;
		public var godType:int;
		public var id:int;
		public var level:int;
		public var logoUrl:String;
		public var name:String;
		public var status:int;

		public function copyToBe(target:CastleInfoBean):void {
			target.fieldId = this.fieldId 
			target.godType = this.godType 
			target.id = this.id 
			target.level = this.level 
			target.logoUrl = this.logoUrl 
			target.name = this.name 
			target.status = this.status 
		}
		
		public function toBeObject():Object {
			var obj:Object = new Object();
			obj.fieldId = this.fieldId;
			obj.godType = this.godType;
			obj.id = this.id;
			obj.level = this.level;
			obj.logoUrl = this.logoUrl;
			obj.name = this.name;
			obj.status = this.status;
			return obj;
		}

		public function toBeString(pre:String=""):String {
			var str:String = "";
			str += pre + "fieldId = " + this.fieldId + "\n" ;
			str += pre + "godType = " + this.godType + "\n" ;
			str += pre + "id = " + this.id + "\n" ;
			str += pre + "level = " + this.level + "\n" ;
			str += pre + "logoUrl = " + this.logoUrl + "\n" ;
			str += pre + "name = " + this.name + "\n" ;
			str += pre + "status = " + this.status + "\n" ;

			return str;  
		}
	}
}