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
	public class CurrNpcFieldBean
	{
		public function CurrNpcFieldBean(data:Object=null)
		{
			if (data!=null){
				if (data.currentIndex!=null) {
					this.currentIndex = data.currentIndex;
				}
				if (data.techLevel!=null) {
					this.techLevel = data.techLevel;
				}
			
				var n:int;
				if (data.heroMans) {
					for (n=0; n<data.heroMans.length; n++) {
						var _heroMans:HeroManBean = new HeroManBean(data.heroMans[n]);
						this.heroMansArray.addItem(_heroMans);
					}
				}
			
				if (data.items) {
					for (n=0; n<data.items.length; n++) {
						var _items:MaterialBean = new MaterialBean(data.items[n]);
						this.itemsArray.addItem(_items);
					}
				}
			
			}
		}
		

		public var currentIndex:int;
		public var techLevel:int;

		public var heroMansArray:ArrayCollection = new ArrayCollection();
		public var itemsArray:ArrayCollection = new ArrayCollection();
			
		public function getHeroMans(index:int):HeroManBean {
			var res:HeroManBean = HeroManBean(this.heroMansArray[index]);
			return res; 
		}
		public function setHeroMans(bean:HeroManBean, index:int):void {
			this.heroMansArray[index] = bean;
		}
		public function getItems(index:int):MaterialBean {
			var res:MaterialBean = MaterialBean(this.itemsArray[index]);
			return res; 
		}
		public function setItems(bean:MaterialBean, index:int):void {
			this.itemsArray[index] = bean;
		}

		public function copyToBe(target:CurrNpcFieldBean):void {
			target.currentIndex = this.currentIndex 
			target.techLevel = this.techLevel 
		}
		
		public function toBeObject():Object {
			var obj:Object = new Object();
			obj.currentIndex = this.currentIndex;
			obj.techLevel = this.techLevel;
			return obj;
		}

		public function toBeString(pre:String=""):String {
			var str:String = "";
			str += pre + "currentIndex = " + this.currentIndex + "\n" ;
			str += pre + "techLevel = " + this.techLevel + "\n" ;

			var i:int;
			for (i=0; i<this.heroMansArray.length; i++) {
				str += this.getHeroMans(i).toBeString(pre + "heroMans[" + i + "].") ;
			}
			
			for (i=0; i<this.itemsArray.length; i++) {
				str += this.getItems(i).toBeString(pre + "items[" + i + "].") ;
			}
			

			return str;  
		}
	}
}