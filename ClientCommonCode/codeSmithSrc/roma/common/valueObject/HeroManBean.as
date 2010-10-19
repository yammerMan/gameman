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
	public class HeroManBean
	{
		public function HeroManBean(data:Object=null)
		{
			if (data!=null){
				if (data.heroInfo!=null) {
					this.heroInfo = new HeroInfoBean(data.heroInfo);
				}
				if (data.retreatCondition!=null) {
					this.retreatCondition = new HeroRetreatConditionBean(data.retreatCondition);
				}
			
				var n:int;
				if (data.buffers) {
					for (n=0; n<data.buffers.length; n++) {
						var _buffers:BufferBean = new BufferBean(data.buffers[n]);
						this.buffersArray.addItem(_buffers);
					}
				}
			
				if (data.troops) {
					for (n=0; n<data.troops.length; n++) {
						var _troops:HeroTroopBean = new HeroTroopBean(data.troops[n]);
						this.troopsArray.addItem(_troops);
					}
				}
			
			}
		}
		

		public var heroInfo:HeroInfoBean;
		public var retreatCondition:HeroRetreatConditionBean;

		public var buffersArray:ArrayCollection = new ArrayCollection();
		public var troopsArray:ArrayCollection = new ArrayCollection();
			
		public function getBuffers(index:int):BufferBean {
			var res:BufferBean = BufferBean(this.buffersArray[index]);
			return res; 
		}
		public function setBuffers(bean:BufferBean, index:int):void {
			this.buffersArray[index] = bean;
		}
		public function getTroops(index:int):HeroTroopBean {
			var res:HeroTroopBean = HeroTroopBean(this.troopsArray[index]);
			return res; 
		}
		public function setTroops(bean:HeroTroopBean, index:int):void {
			this.troopsArray[index] = bean;
		}

		public function copyToBe(target:HeroManBean):void {
			if (heroInfo!=null) {
				this.heroInfo.copyToBe(target.heroInfo)
			} else {
				target.heroInfo = null;
			}
			if (retreatCondition!=null) {
				this.retreatCondition.copyToBe(target.retreatCondition)
			} else {
				target.retreatCondition = null;
			}
		}
		
		public function toBeObject():Object {
			var obj:Object = new Object();
			obj.heroInfo = this.heroInfo.toBeObject();
			obj.retreatCondition = this.retreatCondition.toBeObject();
			return obj;
		}

		public function toBeString(pre:String=""):String {
			var str:String = "";
			if (heroInfo!=null) {
				str += this.heroInfo.toBeString(pre + "heroInfo.") ;
			} else {
				str += pre + "heroInfo = null\n" ;
			}
			if (retreatCondition!=null) {
				str += this.retreatCondition.toBeString(pre + "retreatCondition.") ;
			} else {
				str += pre + "retreatCondition = null\n" ;
			}

			var i:int;
			for (i=0; i<this.buffersArray.length; i++) {
				str += this.getBuffers(i).toBeString(pre + "buffers[" + i + "].") ;
			}
			
			for (i=0; i<this.troopsArray.length; i++) {
				str += this.getTroops(i).toBeString(pre + "troops[" + i + "].") ;
			}
			

			return str;  
		}
	}
}