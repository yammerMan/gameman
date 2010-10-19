/**
* 生成时间 1 
*/
package roma.common.controller.common
{
	import framework.game.BaseResponse;
	import roma.common.valueObject.*;
	import mx.collections.ArrayCollection;
	import framework.util.CopyAryUtil;
	import flash.utils.ByteArray;
	
	public class MapInfo2Response extends BaseResponse
	{
		public function MapInfo2Response(type:String, data:Object,bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.setResponseData(data);
				if (data.mapStr!=null) {
					this.mapStr = data.mapStr;
				}
				if (data.x!=null) {
					this.x = data.x;
				}
				if (data.y!=null) {
					this.y = data.y;
				}
				if (data.success!=null) {
					this.success = data.success;
				}
			
				var n:int;
				if (data.mapCastles) {
					for (n=0; n<data.mapCastles.length; n++) {
						var _mapCastles:SimpleMapCastleBean = new SimpleMapCastleBean(data.mapCastles[n]);
						this.mapCastlesArray.addItem(_mapCastles);
					}
				}
			
		}

		public var mapStr:String;
		public var x:int;
		public var y:int;
		public var success:Boolean;

		public var mapCastlesArray:ArrayCollection = new ArrayCollection();
			
		public function getMapCastles(index:int):SimpleMapCastleBean {
			var res:SimpleMapCastleBean = SimpleMapCastleBean(this.mapCastlesArray[index]);
			return res; 
		}
		public function setMapCastles(bean:SimpleMapCastleBean, index:int):void {
			this.mapCastlesArray[index] = bean;
		}

		public function copyToBe(target:MapInfo2Response):void {
			target.mapStr = this.mapStr 
			target.x = this.x 
			target.y = this.y 
			target.success = this.success 
		}
		
		public function toBeObject():Object {
			var obj:Object = new Object();
			obj.mapStr = this.mapStr;
			obj.x = this.x;
			obj.y = this.y;
			obj.success = this.success;
			return obj;
		}

		public override function toBeString(pre:String=""):String {
			var str:String = "---- MapInfo2Response ----\n"  + this.toBeErrorString();
			str += pre + "mapStr = " + this.mapStr + "\n" ;
			str += pre + "x = " + this.x + "\n" ;
			str += pre + "y = " + this.y + "\n" ;
			str += pre + "success = " + this.success + "\n" ;

			var i:int;
			for (i=0; i<this.mapCastlesArray.length; i++) {
				str += this.getMapCastles(i).toBeString(pre + "mapCastles[" + i + "].") ;
			}
			

			return str;  
		}
	}
}