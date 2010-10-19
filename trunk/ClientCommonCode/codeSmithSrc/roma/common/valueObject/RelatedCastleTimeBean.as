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
	public class RelatedCastleTimeBean
	{
		public function RelatedCastleTimeBean(data:Object=null)
		{
			if (data!=null){
				if (data.castle!=null) {
					this.castle = new RelatedCastleBean(data.castle);
				}
				if (data.time!=null) {
					this.time = data.time;
				}
			}
		}
		

		public var castle:RelatedCastleBean;
		public var time:Number;

		public function copyToBe(target:RelatedCastleTimeBean):void {
			if (castle!=null) {
				this.castle.copyToBe(target.castle)
			} else {
				target.castle = null;
			}
			target.time = this.time 
		}
		
		public function toBeObject():Object {
			var obj:Object = new Object();
			obj.castle = this.castle.toBeObject();
			obj.time = this.time;
			return obj;
		}

		public function toBeString(pre:String=""):String {
			var str:String = "";
			if (castle!=null) {
				str += this.castle.toBeString(pre + "castle.") ;
			} else {
				str += pre + "castle = null\n" ;
			}
			str += pre + "time = " + this.time + "\n" ;

			return str;  
		}
	}
}