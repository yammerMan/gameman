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
	public class TaskTypeBean
	{
		public function TaskTypeBean(data:Object=null)
		{
			if (data!=null){
				if (data.description!=null) {
					this.description = data.description;
				}
				if (data.name!=null) {
					this.name = data.name;
				}
				if (data.typeId!=null) {
					this.typeId = data.typeId;
				}
				if (data.finish!=null) {
					this.finish = data.finish;
				}
			}
		}
		

		public var description:String;
		public var name:String;
		public var typeId:int;
		public var finish:Boolean;

		public function copyToBe(target:TaskTypeBean):void {
			target.description = this.description 
			target.name = this.name 
			target.typeId = this.typeId 
			target.finish = this.finish 
		}
		
		public function toBeObject():Object {
			var obj:Object = new Object();
			obj.description = this.description;
			obj.name = this.name;
			obj.typeId = this.typeId;
			obj.finish = this.finish;
			return obj;
		}

		public function toBeString(pre:String=""):String {
			var str:String = "";
			str += pre + "description = " + this.description + "\n" ;
			str += pre + "name = " + this.name + "\n" ;
			str += pre + "typeId = " + this.typeId + "\n" ;
			str += pre + "finish = " + this.finish + "\n" ;

			return str;  
		}
	}
}