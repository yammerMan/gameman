package views.windows.functionWins.shop
{
	import flash.net.SharedObject;
	
	import mx.collections.ArrayCollection;
	
	import roma.common.valueObject.MaterialBean;
	import roma.logic.CaesaryConfig;
	import roma.logic.GameContext;
	import roma.logic.RomaConstants;
	import roma.logic.rule.GameRuleHelper;
	import roma.logic.rule.ItemRule;
	import roma.message.EvtDispacther;
	
	import views.windows.functionWins.myItem.ItemEnlargeBean;
	
	public class ShopHelper
	{
		public static var instance:ShopHelper=new ShopHelper()
		private var sharedObject:SharedObject;
		public function ShopHelper()
		{
		}
		
		public static function getMaterialBeanFromPlayer(itemId:String):MaterialBean {
			var res:MaterialBean = null ;
			for each(var bean:MaterialBean in GameContext.instance.getPlayerObj().itemManager.itemArray) {
				if (bean.id == itemId) {
					res = bean;
				}
			}
			return res;
		} 
		
		public function writeLocal():void{
			var share:SharedObject = SharedObject.getLocal(EvtDispacther.ITEM_USE_COOKIE);
			share.data.isClickToTurn = CaesaryConfig.instance.isClickToTurn;
			share.data.isClickToBuy = CaesaryConfig.instance.isClickToBuy;
			share.flush();
		}
		
		public function readLocal():void{
			if(sharedObject==null){
				sharedObject = SharedObject.getLocal(EvtDispacther.ITEM_USE_COOKIE);
				if(sharedObject.data){
					if(sharedObject.data.isClickToTurn){
						CaesaryConfig.instance.isClickToTurn=sharedObject.data.isClickToTurn==true?true:false;
					}else{
						CaesaryConfig.instance.isClickToTurn==false;
					}
					if(sharedObject.data.isClickToBuy){
						CaesaryConfig.instance.isClickToBuy=sharedObject.data.isClickToBuy==true?true:false;
					}else{
						CaesaryConfig.instance.isClickToBuy==false;
					}
				}
			}
		}
		
		public function checkHaveNewItem():void{
			return;
			var itemArr:ArrayCollection=GameContext.instance.getPlayerObj().itemManager.itemArray;
			/* CaesaryConfig.instance.haveNewTreasure=true;
			CaesaryConfig.instance.haveNewSpeedup=true;
			CaesaryConfig.instance.haveNewProduce=true;
			CaesaryConfig.instance.haveNewChest=true;
			CaesaryConfig.instance.haveNewLuxury=true; */
			
			CaesaryConfig.instance.haveNewTreasure=false;
			CaesaryConfig.instance.haveNewSpeedup=false;
			CaesaryConfig.instance.haveNewProduce=false;
			CaesaryConfig.instance.haveNewChest=false;
			CaesaryConfig.instance.haveNewLuxury=false;
			for each(var bean:ItemEnlargeBean in itemArr){
				if(bean==null)continue;
				if(ItemRule(GameRuleHelper.instance.getItemRuleById(bean.id))==null)continue;
				if(ItemRule(GameRuleHelper.instance.getItemRuleById(bean.id)).itemType==RomaConstants.ITEM_TYPE_TREASURE||ItemRule(GameRuleHelper.instance.getItemRuleById(bean.id)).itemType==RomaConstants.ITEM_TYPE_ACTIVITY){
					if(CaesaryConfig.instance.haveNewTreasure)continue;
					CaesaryConfig.instance.haveNewTreasure=bean.isNew&&!bean.isOverView&&bean.count>0;continue;
				}else if(ItemRule(GameRuleHelper.instance.getItemRuleById(bean.id)).itemType==RomaConstants.ITEM_TYPE_SPEEDUP){
					if(CaesaryConfig.instance.haveNewSpeedup)continue;
					CaesaryConfig.instance.haveNewSpeedup=bean.isNew&&!bean.isOverView&&bean.count>0;continue;
				}else if(ItemRule(GameRuleHelper.instance.getItemRuleById(bean.id)).itemType==RomaConstants.ITEM_TYPE_PRODUCE){
					if(CaesaryConfig.instance.haveNewProduce)continue;
					CaesaryConfig.instance.haveNewProduce=bean.isNew&&!bean.isOverView&&bean.count>0;continue;
				}else if(ItemRule(GameRuleHelper.instance.getItemRuleById(bean.id)).itemType==RomaConstants.ITEM_TYPE_CHEST){
					if(CaesaryConfig.instance.haveNewChest)continue;
					CaesaryConfig.instance.haveNewChest=bean.isNew&&!bean.isOverView&&bean.count>0;continue;
				}else if(ItemRule(GameRuleHelper.instance.getItemRuleById(bean.id)).itemType==RomaConstants.ITEM_TYPE_LUXURY){
					if(CaesaryConfig.instance.haveNewLuxury)continue;
					CaesaryConfig.instance.haveNewLuxury=bean.isNew&&!bean.isOverView&&bean.count>0;
				}
			}
		}

	}
}