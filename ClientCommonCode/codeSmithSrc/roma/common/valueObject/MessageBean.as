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
	public class MessageBean
	{
		public function MessageBean(data:Object=null)
		{
			if (data!=null){
				if (data.id!=null) {
					this.id = data.id;
				}
				if (data.title!=null) {
					this.title = data.title;
				}
				if (data.type!=null) {
					this.type = data.type;
				}
				if (data.readed!=null) {
					this.readed = data.readed;
				}
				if (data.store!=null) {
					this.store = data.store;
				}
			}
		}
		

		public var id:int;
		public var title:String;
		public var type:String;
		public var readed:Boolean;
		public var store:Boolean;

		public function copyToBe(target:MessageBean):void {
			target.id = this.id 
			target.title = this.title 
			target.type = this.type 
			target.readed = this.readed 
			target.store = this.store 
		}
		
		public function toBeObject():Object {
			var obj:Object = new Object();
			obj.id = this.id;
			obj.title = this.title;
			obj.type = this.type;
			obj.readed = this.readed;
			obj.store = this.store;
			return obj;
		}

		public function toBeString(pre:String=""):String {
			var str:String = "";
			str += pre + "id = " + this.id + "\n" ;
			str += pre + "title = " + this.title + "\n" ;
			str += pre + "type = " + this.type + "\n" ;
			str += pre + "readed = " + this.readed + "\n" ;
			str += pre + "store = " + this.store + "\n" ;

			return str;  
		}
	}
}