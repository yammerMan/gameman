package roma.logic.rule.ruleCheck
{
	import mx.collections.ArrayCollection;
	
	import roma.logic.RomaConstants;
	import roma.logic.rule.BaseRule;
	import roma.logic.rule.DependData;
	import roma.logic.rule.ItemDependData;
	
	[Bindable]
	public class RuleCheckResult
	{
		public var golds:ResourceCheck ;
		public var food:ResourceCheck ;
		public var wood:ResourceCheck ;
		public var stone:ResourceCheck ;
		public var iron:ResourceCheck ;
		public var needTime:Number;
				
		public var isMatch:Boolean = true;
		
		/*所有的条件 ,物品依赖除外*/
		public var conditionArray:ArrayCollection = new ArrayCollection();

		/*所有的条件 */
		public var resConditionArray:ArrayCollection = new ArrayCollection();		

		/* 除资源以外的条件 */
		public var otherArray:ArrayCollection = new ArrayCollection();
		
		/* 建筑依赖*/
		public var buildingDepenAry:ArrayCollection = new ArrayCollection();
		
		/* 科技依赖*/
		public var techDepenAry:ArrayCollection = new ArrayCollection();

		/* 物品依赖*/
		public var itemDependAry:ArrayCollection = new ArrayCollection();
		
		/* 当前人口依赖 */
		public var populationDependAry:ArrayCollection = new ArrayCollection();
		
		private var rule:BaseRule;
		
		public function RuleCheckResult(rule:BaseRule)
		{
			this.rule = rule;
			this.needTime = rule.costTime;
			this.food = new ResourceCheck(rule.costFood, RomaConstants.RES_TYPE_FOOD);
			this.wood = new ResourceCheck(rule.costWood, RomaConstants.RES_TYPE_WOOD);
			this.stone = new ResourceCheck(rule.costStone, RomaConstants.RES_TYPE_STONE);
			this.iron = new ResourceCheck(rule.costIron, RomaConstants.RES_TYPE_IRON);
			this.golds = new ResourceCheck(rule.costGold, RomaConstants.RES_TYPE_GOLD);
	
			if (this.food.isRequest) {
				this.conditionArray.addItem(this.food);
				this.resConditionArray.addItem(this.food);
			}
			if (this.wood.isRequest ) {
				this.conditionArray.addItem(this.wood);
				this.resConditionArray.addItem(this.wood);
			}
			if (this.stone.isRequest ) {
				this.conditionArray.addItem(this.stone);
				this.resConditionArray.addItem(this.stone);
			}
			if (this.iron.isRequest) {
				this.conditionArray.addItem(this.iron);
				this.resConditionArray.addItem(this.iron);
			}
			if (this.golds.isRequest) {
				this.conditionArray.addItem(this.golds);
				this.resConditionArray.addItem(this.golds);
			}
			
			// 加入对建筑的依赖
			if (this.rule.buildingDepends.length>0) {
				for each(var dependData:DependData in this.rule.buildingDepends) {
					this.conditionArray.addItem(new BuildingDependsCheck(dependData.typeId, dependData.level));
					this.buildingDepenAry.addItem(new BuildingDependsCheck(dependData.typeId, dependData.level));					
				}
			}

			// 加入对科技的依赖
			if(this.rule.techDepends.length>0){
				for each(var techData:DependData in this.rule.techDepends){
					this.conditionArray.addItem(new TechCheck(techData.typeId, techData.level));
					this.techDepenAry.addItem(new TechCheck(techData.typeId, techData.level));
				}
			}
						
			// 加入对物品的依赖
			if(this.rule.itemDepends.length>0){
				for each(var itemData:ItemDependData in this.rule.itemDepends){
//					this.conditionArray.addItem(new ItemCheck(itemData.itemId,itemData.count));
					this.itemDependAry.addItem(new ItemCheck(itemData.itemId,itemData.count));
				}
			}
			
			//对当前人口依赖
			if(this.rule.ppopulationDepends>0){
				this.conditionArray.addItem(new PeopleCheck(this.rule.ppopulationDepends));
				this.populationDependAry.addItem(new PeopleCheck(this.rule.ppopulationDepends));
			}
			
			this.check();
		}
		
		/**
		 * 判断所有的条件是否符合条件
		 */
		public function check():void {
			this.isMatch = true;
			for each(var check:BaseCheck in this.conditionArray ) {
				check.check();
				this.isMatch = this.isMatch && check.isMatch;
			}
			
			this.buildepCheck();
			this.techCheck();
			this.itemCheck();
			this.resCheck();
			this.populationCheck();
		}
		
		public function addExtendCheck(check:BaseCheck):void {
			this.conditionArray.addItem(check);
		}
		
		/**
		 *单独检查建筑是否符合条件 
		 */
		private function buildepCheck():void{
			for each( var check:BuildingDependsCheck in this.buildingDepenAry){
				check.check();
			}
		}
		
		private function techCheck():void{
			for each( var check:TechCheck in this.techDepenAry){
				check.check();
			}
		}

		private function itemCheck():void{
			for each( var check:ItemCheck in this.itemDependAry){
				check.check();
			}
		}
		
		private function resCheck():void{
			for each(var check:ResourceCheck in this.resConditionArray){
				check.check();
			}
		} 
		
		private function populationCheck():void{
			for each(var check:PeopleCheck in this.populationDependAry){
				check.check();
			}
		}
		
		public function getRule():BaseRule{
			return this.rule;
		}		
	}
}