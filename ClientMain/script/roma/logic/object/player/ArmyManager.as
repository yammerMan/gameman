package roma.logic.object.player
{
	import mx.collections.ArrayCollection;
	
	import roma.common.constants.GeneralConstants;
	import roma.common.constants.HeroManConstants;
	import roma.common.events.ScoutUpdate;
	import roma.common.valueObject.ScoutBean;
	import roma.logic.GameContext;
	import roma.logic.object.castle.CastleObj;
	import roma.logic.object.hero.HeroObj;
	import roma.message.EvtDispacther;
	import roma.message.events.HerosEvent;
	import roma.message.events.MsgEvent;
	
	/**
	 * 玩家自己的军队（包括侦查）
	 */ 
	public class ArmyManager
	{
		public var allHerosGuard:ArrayCollection = new ArrayCollection();
		public var heroOutSideList:ArrayCollection = new ArrayCollection();
		public var heroMoveList:ArrayCollection = new ArrayCollection();
		public var heroInbattleList:ArrayCollection = new ArrayCollection();
		public var scoutTempList:ArrayCollection = new ArrayCollection();
		
		private var allCastle:Array = [];
		
		public function ArmyManager()
		{
			allHerosGuard = getAllCastleHeroGuard();
			heroOutSideList = getOutSideHeroArray();
			heroMoveList = getOutSiteHeroOfMove();
			heroInbattleList = getOutSiteHeroOfInbattle();
			scoutTempList = getScoutTeamArray();
			allCastle = GameContext.instance.getPlayerObj().getAllCastle();
			EvtDispacther.instance.addEventListener(EvtDispacther.HERO_STATUS_CHANGE, onHeroStatusChange);
			EvtDispacther.instance.addEventListener(HerosEvent.HERO_UPDATE,onHeroManUpdateResponse);
		}
		
		
		/**
			 * 有英雄更新的相应 
			 */ 
		private function onHeroManUpdateResponse(event:HerosEvent):void{
			heroOutSideList = getOutSideHeroArray();
			heroMoveList = getOutSiteHeroOfMove();
			heroInbattleList = getOutSiteHeroOfInbattle();
			allHerosGuard = getAllCastleHeroGuard();
		}
		
		/**
		 * 英雄状态更新
		 */
		private function onHeroStatusChange(e:MsgEvent):void{
			heroOutSideList = getOutSideHeroArray();
			heroMoveList = getOutSiteHeroOfMove();
			heroInbattleList = getOutSiteHeroOfInbattle();
			allHerosGuard = getAllCastleHeroGuard();
		}
		 
		/**
		 * 获得所有在外英雄
		 */
		private function getOutSideHeroArray():ArrayCollection{
			var ac:ArrayCollection = new ArrayCollection();
			var castleArray:Array = GameContext.instance.getPlayerObj().getAllCastle();
			var castle:CastleObj;
			var hero:HeroObj;
			for each (castle in castleArray) {
				for each (hero in castle.heroManager.heroArray) {
					if (!hero.isInCastle && !hero.isCaptive) {
						ac.addItem(hero);
					}
				}
			}
			return ac;
		}
		
		/**
		 * 获得在外英雄军队动态中的英雄
		 */ 
		private function getOutSiteHeroOfMove():ArrayCollection{
			var heroArr:ArrayCollection = this.heroOutSideList;
			var arr:ArrayCollection = new ArrayCollection();
			for each(var h:HeroObj in heroArr){
				if(!(h.heroInfo.status == HeroManConstants.STATUS_IN_BATTLE_FIELD || h.heroInfo.status == HeroManConstants.STATUS_GROWTH)){
					arr.addItem(h);
				}
			}
			return arr;
		}
		
		/**
		 * 获得在外英雄军队出征的英雄列表
		 */ 
		private function getOutSiteHeroOfInbattle():ArrayCollection{
			var heroArr:ArrayCollection = this.heroOutSideList;
			var arr:ArrayCollection = new ArrayCollection();
			for each(var h:HeroObj in heroArr){
				if(h.heroInfo.status == HeroManConstants.STATUS_IN_BATTLE_FIELD){
					arr.addItem(h);
				}
			}
			return arr;
		}
		
		/**
		 * 获得所有城堡的侦察行动
		 */
		private function getScoutTeamArray():ArrayCollection {
			var ac:ArrayCollection = new ArrayCollection();
			var castleArray:Array = GameContext.instance.getPlayerObj().getAllCastle();
			for each (var castle:CastleObj in castleArray) {
				for each (var bean:ScoutBean in castle.scoutsBeanArray) {
					ac.addItem(new ScoutTeamObj(castle , bean));
				}
			}
			return ac;
		}
		
		/**
		 * 更新侦察行动
		 */
		public function updateScoutTeam(event:ScoutUpdate):void {
			var castle:CastleObj = GameContext.instance.getPlayerObj().getCastleObjById(event.cityId);
			if (castle!=null) {
				if (event.updateType == GeneralConstants.UPDATE_ADD_TYPE) {
					//增加
					castle.scoutsBeanArray.addItem(event.scoutBean);
				} else {
					//删除
					for (var i:int=0; i<castle.scoutsBeanArray.length; i++) {
						var bean:ScoutBean = ScoutBean(castle.scoutsBeanArray[i]);
						if (bean.mission == event.scoutBean.mission && 
							bean.arriveTime == event.scoutBean.arriveTime &&
							bean.targetFieldId == bean.targetFieldId) {
							if(event.updateType == GeneralConstants.UPDATE_DELETE_TYPE){
								castle.scoutsBeanArray.removeItemAt(i);
							}else{
							}
							break;	
						}
					}
				}
			}
			scoutTempList = getScoutTeamArray();
		}
		
		/**
		 * 在外驻守的英雄
		 */ 
		public function getAllCastleHeroGuard():ArrayCollection{
			var arr:ArrayCollection = new ArrayCollection();
			allCastle = GameContext.instance.getPlayerObj().getAllCastle();
			for each(var castle:CastleObj in allCastle){
				var arr1:ArrayCollection =castle.heroManager.heroArray;
				for each(var h:HeroObj in arr1){
					if(h.heroInfo.status == HeroManConstants.STATUS_GUARD){
						arr.addItem(h);
					}
				}
			}
			return arr;
		}
		
	}
}