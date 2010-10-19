package roma.logic.object.player
{
	import flash.events.Event;
	
	import mx.collections.ArrayCollection;
	import mx.logging.ILogger;
	import mx.logging.Log;
	
	import roma.common.constants.AllianceConstant;
	import roma.common.constants.PlayerConstant;
	import roma.common.valueObject.MaterialBean;
	import roma.logic.GameContext;
	import roma.logic.rule.GameRuleHelper;
	import roma.logic.rule.ItemRule;
	import roma.message.EvtDispacther;
	
	import views.windows.functionWins.myItem.ItemEnlargeBean;
	import views.windows.functionWins.shop.ShopHelper;
	
	public class ItemResManager
	{
		private static var log:ILogger = Log.getLogger("roma.logic.object.player.ItemManager");
		
		public static var HERO_LOYALTY_9:String = "hero.loyalty.9";
		public static var RESETHERO:String = "resetHero";
		
		public var itemArray:ArrayCollection = new ArrayCollection();
		
		public function ItemResManager(itemArray:ArrayCollection)
		{
			log.debug("init");
			this.itemArray = itemBeanEnlarge(itemArray);
		}
		
		private function itemBeanEnlarge(itemArr:ArrayCollection):ArrayCollection{
			var newArr:ArrayCollection=new ArrayCollection();
			for each(var itemBean:MaterialBean in itemArr){
				var itemEnlargeBean:ItemEnlargeBean=new ItemEnlargeBean(itemBean);
				itemEnlargeBean.isNew=false;
				itemEnlargeBean.isOverView=false;
				newArr.addItem(itemEnlargeBean);
			}
			return newArr;
		}

		public function updateItem(updateBean:MaterialBean):void {
			var found:Boolean = false;
			for each (var bean:ItemEnlargeBean in this.itemArray ) {
				if (bean.id == updateBean.id) {
					if(updateBean.count>bean.count){
						bean.isNew=true;
						bean.isOverView=false;
					}
					bean.count = updateBean.count;
					found = true;
					break;
				}
			}
			
			if (!found) {
				var itemEnlargeBean:ItemEnlargeBean=new ItemEnlargeBean(updateBean);
				itemEnlargeBean.isNew=true;
				itemEnlargeBean.isOverView=false;
				this.itemArray.addItem(itemEnlargeBean);
			}
			
//			ShopHelper.instance.checkHaveNewItem();//ToDo 完成之后需要此代码
			if (!found || updateBean.count==0) {
				//通知“我的物品”窗口刷新
				EvtDispacther.instance.dispatchEvent(new Event(EvtDispacther.ITEM_ADD_OR_REMOVE));
			}
		}
		
		public function ifEnoughGold(itemId:String,count:int=1):Boolean{
			var g:ItemRule = GameRuleHelper.instance.getItemRuleById(itemId);
			var c:int = GameContext.instance.getPlayerObj().getPlayerInfo().coin;
			
			return (c>=g.price*count);
		}
		
		public function getMaterialBeanById(itemId:String):MaterialBean {
			for each (var bean:MaterialBean in this.itemArray ) {
				if (bean.id == itemId) {
					return bean;
				}
			}
			return null;
		}
		
		public function getItemCount(itemId:String):int{
			var count:int = 0;
			for each(var bean:MaterialBean in this.itemArray){
				if(bean.id == itemId){
					count = bean.count;
				}
			}
			return count;
		}
		
		/**
		 * 加速联盟升级
		 */
		public static const allianceLevelUpItemArrayCollection:ArrayCollection = new ArrayCollection([
			AllianceConstant.INCREASE_ALLIANCE_MEMBER_100,
			"incAllianceLimitTo200",
			"incAllianceLimitTo300"
		]);
		
		/**
		 * 加速建筑物品
		 */
		public static const speedItemArrayCollection:ArrayCollection = new ArrayCollection([
			"speedup15mBuilding",
			"speedup1hBuilding", 
			"speedup3hBuilding", 
			"speedup30pBuilding"
		]);
		
		
		/**
		 * 加速科技物品
		 */
		public static const speedTechItemArrayCollection:ArrayCollection = new ArrayCollection([
			"speedup15mTech",
			"speedup1hTech", 
			"speedup3hTech",
			"speedup30pTech"
		]);
		
		/**
		 * 加速工人生产物品
		 */
		public static const speedWorkerItemArrayCollection:ArrayCollection = new ArrayCollection([
			"speedup15mTraining",
			"speedup1hTraining",
			"speedup3hTraining",
			"speedup30pTraining"
		])
		
		/**
		 * 加速建筑降级物品
		 */
		public static const speedBuildingDemotionArrayCollection:ArrayCollection = new ArrayCollection([
			"destoryBuilding"
		]);
		
		
		/**
		 * 加速军队生产物品
		 */
		public static const speedArmyArrayCollection:ArrayCollection = new ArrayCollection([
			"speedupTroop",
			"speedup50pTroop"
		]);
		
		
		/**
		 * 加速城防建设物品
		 */
		public static const speedDefenceArrayCollection:ArrayCollection = new ArrayCollection([
			"speedupFort"
		]);


		/**
		 * 加速交易物品
		 */
		public static const speedDealArrayCollection:ArrayCollection = new ArrayCollection([
			"speedupTrade"
		]);		
		
		
		/**
		 * 增加粮食产量物品
		 */
		public static const incFoodItemArrayCollection:ArrayCollection = new ArrayCollection([
			"incResFood1D", 
			"incResFood7D" 
		]);
		
		
		/**
		 * 增加木材产量物品
		 */
		public static const incWoodItemArrayCollection:ArrayCollection = new ArrayCollection([
			"incResWood1D", 
			"incResWood7D" 
		]);


		/**
		 * 增加石头产量物品
		 */
		public static const incStoneItemArrayCollection:ArrayCollection = new ArrayCollection([
			"incResStone1D", 
			"incResStone7D" 
		]);


		/**
		 * 增加铁矿产量物品
		 */
		public static const incIronItemArrayCollection:ArrayCollection = new ArrayCollection([
			"incResIron1D", 
			"incResIron7D" 
		]);
		
		
		/**
		 * 增加民心物品
		 */
		public static const supportItemArrayCollection:ArrayCollection = new ArrayCollection([
			"incCastleLoyalty"
		]);
		
		
		/**
		 * 增加人口物品
		 */
		public static const populationItemArrayCollection:ArrayCollection = new ArrayCollection([
			"incPopulation"
		]);
		
		
		/**
		 * 增加黄金物品
		 */
		public static const goldsItemArrayCollection:ArrayCollection = new ArrayCollection([
			"incResGold1D", 
			"incResGold7D"
		]);
		
		/**
		 * 增加英雄经验物品
		 */
		public static const heroExpItemArrayCollection:ArrayCollection = new ArrayCollection([
			"incHeroExp1k",
			"incHeroExp10k",
			"incHeroExp100k"
		]);
		
		
		/**
		 * 英雄加属性物品
		 */ 	
		public static const heroProItemArrayCollection:ArrayCollection = new ArrayCollection([
		"incHeroPolitics1D"
		,"incHeroDefence1D"
		,"incHeroAttack1D"
		]);
		
		public static const heroAddPolitics:String = "incHeroPolitics1D"; 
		public static const heroAddDefence:String = "incHeroDefence1D"; 
		public static const heroAddAttack:String = "incHeroAttack1D"; 
		public static const heroAddArmyLimit:String = "incArmyTroopLimit";
		
		public static const heroTemperAddLimit:String = "incWorkout";
		
		
		/**
		 *英雄加忠诚物品
		 */ 
		public static const jewelryItemArrayCollection:ArrayCollection = new ArrayCollection([
			"hero.loyalty.1",
			"hero.loyalty.2",
			"hero.loyalty.3",
			"hero.loyalty.4",
			"hero.loyalty.5",
			"hero.loyalty.6",
			"hero.loyalty.7",
			"hero.loyalty.8",
			"hero.loyalty.9",
		])
		
		public static const phisicalItemArrayCollection:ArrayCollection = new ArrayCollection([
			"bread",'fruit','milk','meat'
		])
		/**
		 *修改玩家名称物品
		 */ 
		public static const playerChangeNameItemArrayCollection:ArrayCollection = new ArrayCollection([
			"changePlayerName"
		])
		
		
		/**
		 *修改玩家旗号物品
		 */ 
		public static const playerChangeFlagItemArrayCollection:ArrayCollection = new ArrayCollection([
			"changeFlag"
		])
		
		/**
		 *修改玩家状态物品
		 */ 
		public static const playerChangeStatusItemArrayCollection:ArrayCollection = new ArrayCollection([
			PlayerConstant.TRUCE_PLAYER_ITEM
		])
		
		
		/**
		 *修改玩家头像物品
		 */ 
		public static const playerChangeLogoItemArrayCollection:ArrayCollection = new ArrayCollection([
			PlayerConstant.MODIFY_LOGO_ITEM 
		])


		/**
		 *延长建筑进程物品
		 */ 
		public static const prolongBuildingProcessItemArrayCollection:ArrayCollection = new ArrayCollection([
			"incBuildFormation60h",
			"incBuildFormation"
		])
		
		/**
		 *派遣间谍物品
		 */ 
		public static const spyItemArrayCollection:ArrayCollection = new ArrayCollection([
			"spy"
		])
		
		/**
		 * 需要奖励的奢侈品
		 */ 
		public static function getItemsByHeros(lv:int):String{
			if(lv>50 && lv<=60){
				return "hero.loyalty.1";
			}else if(lv>60 && lv<=70){
				return "hero.loyalty.2"; 
			}else if(lv>70 && lv<=80){
				return "hero.loyalty.3";
			}else if(lv >80 && lv<=90){
				return "hero.loyalty.4";
			}else if(lv >90 && lv<=100){
				return "hero.loyalty.5";				
			}else if(lv>100 && lv<=110){
				return "hero.loyalty.6";
			}else if(lv>110 && lv<=120){
				return "hero.loyalty.7";
			}else if(lv>120 && lv<=130){
				return "hero.loyalty.8";
			}else{
				return "hero.loyalty.9";
			}
		}
		
	}
}