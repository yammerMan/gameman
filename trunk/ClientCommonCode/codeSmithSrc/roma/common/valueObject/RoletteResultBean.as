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
	public class RoletteResultBean
	{
		public function RoletteResultBean(data:Object=null)
		{
			if (data!=null){
				if (data.resultItem!=null) {
					this.resultItem = new RoletteAppearItemBean(data.resultItem);
				}
			
				var n:int;
				if (data.firstLevelItems) {
					for (n=0; n<data.firstLevelItems.length; n++) {
						var _firstLevelItems:RoletteAppearItemBean = new RoletteAppearItemBean(data.firstLevelItems[n]);
						this.firstLevelItemsArray.addItem(_firstLevelItems);
					}
				}
			
				if (data.secondLevelItems) {
					for (n=0; n<data.secondLevelItems.length; n++) {
						var _secondLevelItems:RoletteAppearItemBean = new RoletteAppearItemBean(data.secondLevelItems[n]);
						this.secondLevelItemsArray.addItem(_secondLevelItems);
					}
				}
			
				if (data.thirdLevelItems) {
					for (n=0; n<data.thirdLevelItems.length; n++) {
						var _thirdLevelItems:RoletteAppearItemBean = new RoletteAppearItemBean(data.thirdLevelItems[n]);
						this.thirdLevelItemsArray.addItem(_thirdLevelItems);
					}
				}
			
			}
		}
		

		public var resultItem:RoletteAppearItemBean;

		public var firstLevelItemsArray:ArrayCollection = new ArrayCollection();
		public var secondLevelItemsArray:ArrayCollection = new ArrayCollection();
		public var thirdLevelItemsArray:ArrayCollection = new ArrayCollection();
			
		public function getFirstLevelItems(index:int):RoletteAppearItemBean {
			var res:RoletteAppearItemBean = RoletteAppearItemBean(this.firstLevelItemsArray[index]);
			return res; 
		}
		public function setFirstLevelItems(bean:RoletteAppearItemBean, index:int):void {
			this.firstLevelItemsArray[index] = bean;
		}
		public function getSecondLevelItems(index:int):RoletteAppearItemBean {
			var res:RoletteAppearItemBean = RoletteAppearItemBean(this.secondLevelItemsArray[index]);
			return res; 
		}
		public function setSecondLevelItems(bean:RoletteAppearItemBean, index:int):void {
			this.secondLevelItemsArray[index] = bean;
		}
		public function getThirdLevelItems(index:int):RoletteAppearItemBean {
			var res:RoletteAppearItemBean = RoletteAppearItemBean(this.thirdLevelItemsArray[index]);
			return res; 
		}
		public function setThirdLevelItems(bean:RoletteAppearItemBean, index:int):void {
			this.thirdLevelItemsArray[index] = bean;
		}

		public function copyToBe(target:RoletteResultBean):void {
			if (resultItem!=null) {
				this.resultItem.copyToBe(target.resultItem)
			} else {
				target.resultItem = null;
			}
		}
		
		public function toBeObject():Object {
			var obj:Object = new Object();
			obj.resultItem = this.resultItem.toBeObject();
			return obj;
		}

		public function toBeString(pre:String=""):String {
			var str:String = "";
			if (resultItem!=null) {
				str += this.resultItem.toBeString(pre + "resultItem.") ;
			} else {
				str += pre + "resultItem = null\n" ;
			}

			var i:int;
			for (i=0; i<this.firstLevelItemsArray.length; i++) {
				str += this.getFirstLevelItems(i).toBeString(pre + "firstLevelItems[" + i + "].") ;
			}
			
			for (i=0; i<this.secondLevelItemsArray.length; i++) {
				str += this.getSecondLevelItems(i).toBeString(pre + "secondLevelItems[" + i + "].") ;
			}
			
			for (i=0; i<this.thirdLevelItemsArray.length; i++) {
				str += this.getThirdLevelItems(i).toBeString(pre + "thirdLevelItems[" + i + "].") ;
			}
			

			return str;  
		}
	}
}