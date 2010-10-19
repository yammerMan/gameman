package roma.logic.object.buff
{
	import mx.collections.ArrayCollection;
	
	import roma.common.constants.GeneralConstants;
	import roma.common.valueObject.BufferBean;
	
	[Bindable]
	public class BuffResManager
	{
		
		/** 所有buff的数组 */
		private var buffArray:ArrayCollection = new ArrayCollection();
		
		public function getAllBuff():ArrayCollection {
			return this.buffArray;
		}
		
		public function BuffResManager(buffArray:ArrayCollection)
		{
			for each(var bean:BufferBean in buffArray) {
				this.addBuff(bean);
			}
		}
		
		private function addBuff(bean:BufferBean):void {
			var buff:BaseBuffObj = BuffFactory.newInstance(bean.typeId);
			if (buff!=null) {
				buff.setBean(bean);
				this.buffArray.addItem(buff);//加到数组
			}
		}
		
		/**
		 * 根据id获得buff对象
		 */
		public function getBuffById(typeId:int):BaseBuffObj {
			trace("BuffManager: getBuffById type=" + typeId);
			for each(var buff:BaseBuffObj in this.buffArray){
				if (buff.buffBean.typeId == typeId) {
					return buff;
				}
			}
			return null;
		}
		
		public function hasBuff(buffId:int):Boolean {
			return this.getBuffById(buffId) !=null;
		}
		
		public function updateBuff(updateType:int , bean:BufferBean):void {
			if (updateType == GeneralConstants.UPDATE_ADD_TYPE) {
				//增加buff
				trace("BuffManager: addBuff type=" + bean.typeId);
				this.addBuff(bean);
			} else {
				for (var i:int=0; i< this.buffArray.length; i++) {
					var  buff:BaseBuffObj = this.buffArray[i] as BaseBuffObj;
					if (buff.buffBean.typeId == bean.typeId) {
						if (updateType == GeneralConstants.UPDATE_DELETE_TYPE) {
							//从数组中删除
							trace("BuffManager: deleteBuff type=" + bean.typeId);
							this.buffArray.removeItemAt(i);
						} else {
							//更新
							buff.setBean(bean);
						}
						break;
					}
				}
			}
		}
	}
}