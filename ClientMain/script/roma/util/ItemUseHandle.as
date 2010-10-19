package roma.util
{
	import roma.common.valueObject.MaterialBean;
	import roma.logic.GameContext;
	
	public class ItemUseHandle
	{
		public static var instance:ItemUseHandle=new ItemUseHandle();
		public function ItemUseHandle()
		{
		}
	//判断能否使用物品
		public function canUseItem(typeId:String,num:int=1):Boolean{
			var canUseItem:Boolean=false;
			var itemBean:MaterialBean=GameContext.instance.getPlayerObj().itemManager.getMaterialBeanById(typeId);
			if(itemBean!=null&&itemBean.count>num){
				canUseItem=true;
			}
			return canUseItem;
		}
	}
}