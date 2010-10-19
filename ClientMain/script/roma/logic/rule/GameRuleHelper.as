package roma.logic.rule
{
	import flash.utils.Dictionary;
	
	import framework.game.IGameRuleHelper;
	
	import mx.collections.ArrayCollection;
	
	import roma.common.gameRule.GameRuleData;
	
	public class GameRuleHelper implements IGameRuleHelper
	{
		public static var instance:GameRuleHelper = new GameRuleHelper();
		
		private var buildingRuleMap:Dictionary = new Dictionary();
		private var techRuleMap:Dictionary = new Dictionary();
		private var troopRuleMap:Dictionary = new Dictionary();
		private var fortRuleMap:Dictionary = new Dictionary();
		private var itemRuleMap:Dictionary = new Dictionary();
		private var allianceMap:Dictionary=new Dictionary();
		private var questMap:Dictionary = new Dictionary();
		private var questTypeMap:Dictionary = new Dictionary();
		private var workerRuleMap:Dictionary = new Dictionary();
		
		public var itemRuleArray:ArrayCollection = new ArrayCollection();
		
		public var basicItemRuleArray:ArrayCollection = new ArrayCollection();
		
		public var showItemRuleArray:ArrayCollection = new ArrayCollection();
		
		public function GameRuleHelper() {
			new GameRuleData(this);
		}
		
		/**
		 * 加入建筑规则数据
		 */
		public function _b(
				building:String,
				food:int,wood:int,stone:int,iron:int,time:int,
				buff1:int,buff2:int,buff3:int,
				buildingDepends:String,techDepends:String,itemDepends:String,populationDepend:String
				):void {
			this.buildingRuleMap[building] = new BuildingRule(
				building,0,food,wood,stone,iron,time,buff1,buff2,buff3,buildingDepends,techDepends,itemDepends,populationDepend);
		}


		/**
		 * 加入科技规则数据
		 */
		public function _t(
				tech:String,
				golds:int,food:int,wood:int,stone:int,iron:int,time:int,
				effect:int,
				buildingDepends:String,techDepends:String,itemDepends:String
				):void {
			this.techRuleMap[tech] = new TechRule(
				tech,golds,food,wood,stone,iron,time,effect,buildingDepends,techDepends,itemDepends);
		}
		
				
		public function _q (
			id:int,
			questTarget:String,
			getAward:String
		):void{
			this.questMap[id] = new QuestRule(id,questTarget,getAward);
		}
		
		public function _qt (
			typeId:int
		):void{
			this.questTypeMap[typeId] = new QuestTypeRule(typeId);
		}

		/**
		 * 加入军队规则数据
		 */
		public function _tr(
				troop:int,
				life:int,golds:int,food:int,wood:int,stone:int,iron:int,time:int,attack:int,defence:int,dmgMin:int,dmgMax:int,
				speed:int,load:int,foodRequest:int,population:int,buildingLevelRequest:int,
				buildingDepends:String,techDepends:String,itemDepends:String
				):void {
			this.troopRuleMap[troop] = new TroopRule(
				troop,
				life,
				golds,
				food,
				wood,
				stone,
				iron,
				time,
				attack,
				defence,
				dmgMin,
				dmgMax,
				speed,
				load,
				foodRequest,
				population,
				buildingLevelRequest,
				buildingDepends,
				techDepends,
				itemDepends);
						
		}
		
		public function _w(
			id:int,
			food:int,
			wood:int,
			stone:int,
			iron:int,
			population:int,
			time:int,
			value:int,
			severancePay:int
		):void{
			this.workerRuleMap[id] = new WorkerRule(
			id,
			food,
			wood,
			stone,
			iron,
			population,
			time,
			value,
			severancePay
			);
		};		
		
		/**
		 * 加入盟库规则数据
		 */
		public function _a(
				level:int,
				food:int,
				wood:int,
				stone:int,
				iron:int,
				golds:int,
				memberLimit:int,
				maxCap:int
				):void{
				this.allianceMap[level]=new AllianceRule(
				level,
				food,
				wood,
				stone,
				iron,
				golds,
				memberLimit,
				maxCap);
		}

		/**
		 * 加入城防规则数据
		 */
		public function _f(
				fortType:int,
				life:int,
				food:int,
				wood:int,
				stone:int,
				iron:int,
				time:int,
				attack:int,
				defence:int,
				dmgMin:int,
				dmgMax:int,
				space:int,
				buildingLevelRequest:int,
				buildingDepends:String,
				techDepends:String,
				itemDepends:String
				):void {
			this.fortRuleMap[fortType] = new ForticationRule(
				fortType,
				life,
				food,
				wood,
				stone,
				iron,
				time,
				attack,
				defence,
				dmgMin,
				dmgMax,
				space,
				buildingLevelRequest,
				buildingDepends,
				techDepends,
				itemDepends);
		}
		/**
		 * 加入物品规则
		 */
		public function _i (itemId:String,price:int,user_limit:int,day_limit:int,itemType:int,isHeroItem:Boolean, isPlayerItem:Boolean , keyItemId:String=null):void {
			var rule:ItemRule = new ItemRule(itemId, price, user_limit, day_limit, itemType,isHeroItem,isPlayerItem , keyItemId);
			this.itemRuleArray.addItem(rule);
			this.basicItemRuleArray.addItem(rule);
			this.showItemRuleArray.addItem(rule);
			this.itemRuleMap[rule.itemId] = rule;  
		}
		
		public function getItemRuleById(itemId:String):ItemRule {
			return this.itemRuleMap[itemId];
		}
		
		public function getBuildingRule(type:int , level:int):BuildingRule {
			var key:String = type + "." + level;
			var res:BuildingRule = BuildingRule(this.buildingRuleMap[key]);
			if (res ==null) {
				throw new Error("invaild rule type=" + type , ",level=" + level);
			}
			return res;
		}
		
		public function getTechRule(techType:int , level:int):TechRule {
			var key:String = techType + "." + level;
			var res:TechRule = TechRule(this.techRuleMap[key]);
			if (res ==null) {
				throw new Error("invaild rule techType=" + techType , ",level=" + level);
			}
			return res;
		}
		
		public function getTroopRule(troop:int):TroopRule {
			var res:TroopRule = TroopRule(this.troopRuleMap[troop]);
			/* if (res ==null) {
				throw new Error("invaild rule troop=" + troop );
			} */ 
			return res;
		}
		
		public function getForticationRule(fortType:int):ForticationRule {
			var res:ForticationRule = ForticationRule(this.fortRuleMap[fortType]);
			if (res ==null) {
				throw new Error("invaild rule fortType=" + fortType );
			}
			return res;
		}
		
		public function getWorkerRule(typeId:int):WorkerRule{
			var res:WorkerRule= WorkerRule(this.workerRuleMap[typeId]);
			return res;
		}

		public function getTaskTypeRule(typeId:int):QuestTypeRule{
			if(!questTypeMap.hasOwnProperty(typeId))return null;
			return this.questTypeMap[typeId];
		}
		
		public function getTaskRule(taskId:int):QuestRule{
			if(!questMap.hasOwnProperty(taskId))return null;
			return this.questMap[taskId];
		}
		
		public function getLeagueRule(level:int):AllianceRule{
			return this.allianceMap[level];
		}
		
		public function modifyItemMap(itemRule:ItemRule,deleteForShop:Boolean=false,deleteForMyItem:Boolean=false):void{
			this.itemRuleMap[itemRule.itemId]=itemRule;
			if(deleteForShop){
				for(var shopItem:int=0;shopItem<this.itemRuleArray.length;shopItem++){
					if(ItemRule(this.itemRuleArray[shopItem]).itemId==itemRule.itemId){
						this.itemRuleArray.removeItemAt(shopItem);
						break;
					}
				}
			}
			if(deleteForMyItem){
				for(var myItem:int=0;myItem<this.showItemRuleArray.length;myItem++){
					if(ItemRule(this.showItemRuleArray[myItem]).itemId==itemRule.itemId){
						this.showItemRuleArray.removeItemAt(myItem);
						break;
					}
				}
			}
		}
		
		public function modifyItemRule(itemRule:ItemRule):void{
			this.itemRuleMap[itemRule.itemId]=itemRule;
			for(var i:int=0;i<this.basicItemRuleArray.length;i++){
				if(ItemRule(this.basicItemRuleArray[i]).itemId==itemRule.itemId){
					this.basicItemRuleArray[i]=itemRule;
					break;
				}
			}
			for(var ii:int=0;ii<this.itemRuleArray.length;ii++){
				if(ItemRule(this.itemRuleArray[ii]).itemId==itemRule.itemId){
					this.itemRuleArray[ii]=itemRule;
					break;
				}
			}
			for(var iii:int=0;iii<this.showItemRuleArray.length;iii++){
				if(ItemRule(this.showItemRuleArray[iii]).itemId==itemRule.itemId){
					this.showItemRuleArray[iii]=itemRule;
					break;
				}
			}

		}
		
		public function resetItemArray():void{
			this.itemRuleArray.removeAll();
			this.showItemRuleArray.removeAll();
			for each(var itemrule:ItemRule in this.basicItemRuleArray){
				this.itemRuleArray.addItem(itemrule);
				this.showItemRuleArray.addItem(itemrule);
			}
		}
		
	}
}