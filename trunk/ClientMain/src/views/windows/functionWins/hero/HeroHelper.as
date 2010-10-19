package views.windows.functionWins.hero
{
	import flash.events.Event;
	import flash.utils.Dictionary;
	
	import mx.collections.ArrayCollection;
	
	import roma.common.action.ControllerFactory;
	import roma.common.constants.BattleConstants;
	import roma.common.constants.HeroGrowthConstant;
	import roma.common.constants.HeroManConstants;
	import roma.common.controller.CommonResponse;
	import roma.common.valueObject.HeroTroopBean;
	import roma.data.MapTileData;
	import roma.logic.GameContext;
	import roma.logic.object.castle.CastleObj;
	import roma.logic.object.hero.HeroObj;
	import roma.logic.object.player.ItemResManager;
	import roma.logic.rule.ItemRule;
	import roma.message.EvtDispacther;
	import roma.resource.ImgManager;
	import roma.util.MultiLang;
	
	import views.MainContainer;
	import views.spreadUI.MyAlert;
	import views.spreadUI.speedUp.ItemSelectSpeedUpWin;
	
	public class HeroHelper
	{
		
		public static var instance:HeroHelper=new HeroHelper();
		
		public var curSelectCastle:CastleObj=null;
		public var curSelectHero:HeroObj=null;
		
		public var secSelectHero:HeroObj=null;
		
		public var targetMapTileData:MapTileData=null;
		
		public static var OUTFIT_TYPE_HEAD:int=0;
		
		public static var OUTFIT_TYPE_NECKLACE:int=1;
		
		public static var OUTFIT_TYPE_CLOSE:int=2;
		
		public static var OUTFIT_TYPE_SHOES:int=3;
		
		public static var OUTFIT_TYPE_LEFTHAND:int=4;
		
		public static var OUTFIT_TYPE_RIGHTHAND:int=5;
		
		public static var OUTFIT_TYPE_MOUNTS:int=6;
		
		public static var OUTFIT_TYPE_RING:int=7;
		
		public static var OUTFIT_TYPE_CAESTUS:int=8;
		
		public static var OUTFIT_TYPE_ACCESSORIES:int=9;
		
		public static var OUTFIT_TYPE_ALLEQUIP:int=10;
		
		public static var OUTFIT_SHOW_INONEPAGE:int=35;
		
		public var showAllqualityItem:Boolean=true;//是否显示全部质量的道具
		
		public var showAllTypeItem:Boolean=true;//是否显示全部类别的道具
		
		public var showItemName:Boolean=true;//是否显示道具名称
		
		public var showingType:int;//当前显示的类别
		
		public var showingQuality:int;//当前显示的质量类别
		
		
		
		
		
		private var outfitDic:Dictionary;
		
		private var outfitIconDic:Dictionary;
		
		

		
		public function HeroHelper()
		{
		}	
		public function callbackHero(heroObj:HeroObj,callbackFunction:Function=null):void{
			MyAlert.show(MultiLang.msg("hero.callback.confirmTip",heroObj.heroInfo.name),sureToCallback);
			function sureToCallback(_true:Boolean):void{
				if(_true){
					ControllerFactory.getInstance().getArmyController().reCallArmy(heroObj.castleObj.cityId, heroObj.heroInfo.id,reCallArmyResponse);
				}
			}
			function reCallArmyResponse(e:CommonResponse):void{
				if(callbackFunction!=null){
					callbackFunction.apply(this,[e]);
				}
			} 
		}
		
		public static function getBeanIcons(t:int):*{
			switch(t){
				case BattleConstants.ARMY_MISSION_ATTACK:
				return ImgManager.clazz('buffer.status.occupy.icon');
				case BattleConstants.ARMY_MISSION_CONQUEST:
				return ImgManager.clazz('buffer.status.occupy.icon');
				case BattleConstants.ARMY_MISSION_INDEPENDENT:
				return ImgManager.clazz('buffer.status.occupy.icon');
				case BattleConstants.ARMY_MISSION_LOOT:
				return ImgManager.clazz('buffer.status.plunder.icon');
				case BattleConstants.ARMY_MISSION_REINFORCE:
				return ImgManager.clazz('buffer.status.reinforce.icon');
				case HeroManConstants.STATUS_GROWTH:
				return ImgManager.clazz('hero.heroStatus.growth');				
				default:
				return null;
			}
		}
		
		/**
		 * 消耗金币
		 */ 
		public function getTemperConsumeCoins(t:int):int{
			switch(t){
				case HeroGrowthConstant.HERO_GROWTH_TYPE_READING:
				return 2;
				case HeroGrowthConstant.HERO_GROWTH_TYPE_VISITING:
				return 1;
				case HeroGrowthConstant.HERO_GROWTH_TYPE_SCOUTING:
				return 3;
				default:
				return -1;
			}
		}
		
		/**
		 * 消耗黄金
		 */ 
		public function getTemperConsumeGold(t:int):int{
			switch(t){
				case HeroGrowthConstant.HERO_GROWTH_TYPE_FIGHTING:
				return 20000;
				case HeroGrowthConstant.HERO_GROWTH_TYPE_INSPECTING:
				return 10000;
				case HeroGrowthConstant.HERO_GROWTH_TYPE_TREASURING:
				return 30000;
				default:
				return -1;
			}
		}
		
		public function getOutFitTypeName(id:int):String{
			if(outfitDic==null){
				outfitDic=new Dictionary();
				outfitDic[HeroHelper.OUTFIT_TYPE_HEAD]=MultiLang.msg("hero.outfitPart.head");
				outfitDic[HeroHelper.OUTFIT_TYPE_NECKLACE]=MultiLang.msg("hero.outfitPart.necklace");
				outfitDic[HeroHelper.OUTFIT_TYPE_CLOSE]=MultiLang.msg("hero.outfitPart.close");
				outfitDic[HeroHelper.OUTFIT_TYPE_SHOES]=MultiLang.msg("hero.outfitPart.shoes");
				outfitDic[HeroHelper.OUTFIT_TYPE_LEFTHAND]=MultiLang.msg("hero.outfitPart.lefthand");
				outfitDic[HeroHelper.OUTFIT_TYPE_RIGHTHAND]=MultiLang.msg("hero.outfitPart.righthand");
				outfitDic[HeroHelper.OUTFIT_TYPE_MOUNTS]=MultiLang.msg("hero.outfitPart.mounts");
				outfitDic[HeroHelper.OUTFIT_TYPE_RING]=MultiLang.msg("hero.outfitPart.ring");
				outfitDic[HeroHelper.OUTFIT_TYPE_CAESTUS]=MultiLang.msg("hero.outfitPart.caestus");
				outfitDic[HeroHelper.OUTFIT_TYPE_ACCESSORIES]=MultiLang.msg("hero.outfitPart.accessories");
			}
			return outfitDic[id];
		}
		
		public function getOutFitTypeIcon(id:int):Class{
			if(outfitIconDic==null){
				outfitIconDic=new Dictionary();
				outfitIconDic[HeroHelper.OUTFIT_TYPE_HEAD]=ImgManager.clazz('hero.outfit.btnType.head');
				outfitIconDic[HeroHelper.OUTFIT_TYPE_NECKLACE]=ImgManager.clazz('hero.outfit.btnType.necklace');
				outfitIconDic[HeroHelper.OUTFIT_TYPE_CLOSE]=ImgManager.clazz('hero.outfit.btnType.close');
				outfitIconDic[HeroHelper.OUTFIT_TYPE_SHOES]=ImgManager.clazz('hero.outfit.btnType.shoes');
				outfitIconDic[HeroHelper.OUTFIT_TYPE_LEFTHAND]=ImgManager.clazz('hero.outfit.btnType.lefthand');
				outfitIconDic[HeroHelper.OUTFIT_TYPE_RIGHTHAND]=ImgManager.clazz('hero.outfit.btnType.righthand');
				outfitIconDic[HeroHelper.OUTFIT_TYPE_MOUNTS]=ImgManager.clazz('hero.outfit.btnType.mounts');
				outfitIconDic[HeroHelper.OUTFIT_TYPE_RING]=ImgManager.clazz('hero.outfit.btnType.ring');
				outfitIconDic[HeroHelper.OUTFIT_TYPE_CAESTUS]=ImgManager.clazz('hero.outfit.btnType.caestus');
				outfitIconDic[HeroHelper.OUTFIT_TYPE_ACCESSORIES]=ImgManager.clazz('hero.outfit.btnType.accessories');
			}
			return outfitIconDic[id];
		}
		
		
		public function getCurSelectHero():HeroObj{
			if(this.curSelectHero==null){
				if(GameContext.instance.getPlayerObj().getCurCastleObj().heroManager.heroArray.length>0){
					this.curSelectHero=GameContext.instance.getPlayerObj().getCurCastleObj().heroManager.heroArray[0];
				}
			}
			return this.curSelectHero;
		}
		
		/* 卸载英雄部队 */	
	   public function uninstallHeroTroop(hero:HeroObj):void{
			var count:int;
			for each(var bean:HeroTroopBean in hero.armyManager.troopsArray){
				count +=bean.count;
			}
			
			if(count<=0){
				MyAlert.show(MultiLang.msg("hero.don't.bring.troop"));
				return;
			}

	   		var castleId:int =hero.castleObj.cityId;
	   		ControllerFactory.getInstance().getArmyController().uninstallHeroTroop(castleId,hero.heroInfo.id,onUninstallHeroTroopResponse);
	   		
	   		function onUninstallHeroTroopResponse(event:CommonResponse):void{
	   			if(!event.isSuccess()){
	   				MyAlert.showError(event)
	   			}
	   		}	
	   }
	   
	   //增加英雄统帅
	   public function addArmyLimit(hero:HeroObj):void{
			if(!hero.isInCastle){MyAlert.show(MultiLang.msg('hero.notInCastle.tips'));return;}
			ItemSelectSpeedUpWin.show(new ArrayCollection([ItemResManager.heroAddArmyLimit]),onUseItem);
			function onUseItem(iRule:ItemRule):void{
				ControllerFactory.getInstance().getHeroController().awardItem(hero.castleObj.cityId,hero.heroInfo.id,iRule.itemId,onArmyLimitItemUse);
			}
			function onArmyLimitItemUse(event:CommonResponse):void{
				if(event.isSuccess()){
					MainContainer.instance.risePlay(MultiLang.msg("hero.useItem.success"));
					EvtDispacther.instance.dispatchEvent(new Event(EvtDispacther.HERO_LEADERSHIP_CHANGE));
				}
			}
		}
		
	}
}