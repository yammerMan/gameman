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
	public class NpcFieldBean
	{
		public function NpcFieldBean(data:Object=null)
		{
			if (data!=null){
				if (data.currNpc!=null) {
					this.currNpc = new CurrNpcFieldBean(data.currNpc);
				}
				if (data.dieTroopRate!=null) {
					this.dieTroopRate = data.dieTroopRate;
				}
				if (data.expRate!=null) {
					this.expRate = data.expRate;
				}
				if (data.fieldName!=null) {
					this.fieldName = data.fieldName;
				}
				if (data.flag!=null) {
					this.flag = data.flag;
				}
				if (data.injuredRate!=null) {
					this.injuredRate = data.injuredRate;
				}
				if (data.maxMarchSecs!=null) {
					this.maxMarchSecs = data.maxMarchSecs;
				}
				if (data.minMarchSecs!=null) {
					this.minMarchSecs = data.minMarchSecs;
				}
				if (data.requiredStr!=null) {
					this.requiredStr = data.requiredStr;
				}
				if (data.resetTime!=null) {
					this.resetTime = data.resetTime;
				}
				if (data.title!=null) {
					this.title = data.title;
				}
				if (data.total!=null) {
					this.total = data.total;
				}
				if (data.type!=null) {
					this.type = data.type;
				}
				if (data.announce!=null) {
					this.announce = data.announce;
				}
				if (data.dieTroop!=null) {
					this.dieTroop = data.dieTroop;
				}
			
				var n:int;
				if (data.requiredItems) {
					for (n=0; n<data.requiredItems.length; n++) {
						var _requiredItems:MaterialBean = new MaterialBean(data.requiredItems[n]);
						this.requiredItemsArray.addItem(_requiredItems);
					}
				}
			
			}
		}
		

		public var currNpc:CurrNpcFieldBean;
		public var dieTroopRate:Number;
		public var expRate:Number;
		public var fieldName:String;
		public var flag:String;
		public var injuredRate:Number;
		public var maxMarchSecs:int;
		public var minMarchSecs:int;
		public var requiredStr:int;
		public var resetTime:Number;
		public var title:int;
		public var total:int;
		public var type:int;
		public var announce:Boolean;
		public var dieTroop:Boolean;

		public var requiredItemsArray:ArrayCollection = new ArrayCollection();
			
		public function getRequiredItems(index:int):MaterialBean {
			var res:MaterialBean = MaterialBean(this.requiredItemsArray[index]);
			return res; 
		}
		public function setRequiredItems(bean:MaterialBean, index:int):void {
			this.requiredItemsArray[index] = bean;
		}

		public function copyToBe(target:NpcFieldBean):void {
			if (currNpc!=null) {
				this.currNpc.copyToBe(target.currNpc)
			} else {
				target.currNpc = null;
			}
			target.dieTroopRate = this.dieTroopRate 
			target.expRate = this.expRate 
			target.fieldName = this.fieldName 
			target.flag = this.flag 
			target.injuredRate = this.injuredRate 
			target.maxMarchSecs = this.maxMarchSecs 
			target.minMarchSecs = this.minMarchSecs 
			target.requiredStr = this.requiredStr 
			target.resetTime = this.resetTime 
			target.title = this.title 
			target.total = this.total 
			target.type = this.type 
			target.announce = this.announce 
			target.dieTroop = this.dieTroop 
		}
		
		public function toBeObject():Object {
			var obj:Object = new Object();
			obj.currNpc = this.currNpc.toBeObject();
			obj.dieTroopRate = this.dieTroopRate;
			obj.expRate = this.expRate;
			obj.fieldName = this.fieldName;
			obj.flag = this.flag;
			obj.injuredRate = this.injuredRate;
			obj.maxMarchSecs = this.maxMarchSecs;
			obj.minMarchSecs = this.minMarchSecs;
			obj.requiredStr = this.requiredStr;
			obj.resetTime = this.resetTime;
			obj.title = this.title;
			obj.total = this.total;
			obj.type = this.type;
			obj.announce = this.announce;
			obj.dieTroop = this.dieTroop;
			return obj;
		}

		public function toBeString(pre:String=""):String {
			var str:String = "";
			if (currNpc!=null) {
				str += this.currNpc.toBeString(pre + "currNpc.") ;
			} else {
				str += pre + "currNpc = null\n" ;
			}
			str += pre + "dieTroopRate = " + this.dieTroopRate + "\n" ;
			str += pre + "expRate = " + this.expRate + "\n" ;
			str += pre + "fieldName = " + this.fieldName + "\n" ;
			str += pre + "flag = " + this.flag + "\n" ;
			str += pre + "injuredRate = " + this.injuredRate + "\n" ;
			str += pre + "maxMarchSecs = " + this.maxMarchSecs + "\n" ;
			str += pre + "minMarchSecs = " + this.minMarchSecs + "\n" ;
			str += pre + "requiredStr = " + this.requiredStr + "\n" ;
			str += pre + "resetTime = " + this.resetTime + "\n" ;
			str += pre + "title = " + this.title + "\n" ;
			str += pre + "total = " + this.total + "\n" ;
			str += pre + "type = " + this.type + "\n" ;
			str += pre + "announce = " + this.announce + "\n" ;
			str += pre + "dieTroop = " + this.dieTroop + "\n" ;

			var i:int;
			for (i=0; i<this.requiredItemsArray.length; i++) {
				str += this.getRequiredItems(i).toBeString(pre + "requiredItems[" + i + "].") ;
			}
			

			return str;  
		}
	}
}