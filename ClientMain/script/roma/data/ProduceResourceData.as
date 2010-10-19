package roma.data
{
	import mx.collections.ArrayCollection;
	
	import roma.common.constants.BuildingConstant;
	import roma.common.constants.TroopForConstants;
	import roma.common.valueObject.ManufactureBean;
	import roma.logic.GameContext;
	import roma.logic.object.castle.CastleResourceManager;
	import roma.logic.object.castle.TroopManager;
	import roma.logic.rule.BuildingRule;
	import roma.logic.rule.ForticationRule;
	import roma.logic.rule.GameRuleHelper;
	import roma.logic.rule.TroopRule;
	import roma.logic.rule.WorkerRule;
	import roma.logic.rule.ruleCheck.RuleCheckResult;
	import roma.util.MultiLang;
	
	[Bindable]
	public class ProduceResourceData
	{
        private var foodResBean:ProduceResourceDataUint 	= new ProduceResourceDataUint();
        private var woodResBean:ProduceResourceDataUint	= new ProduceResourceDataUint();
        private var ironResBean:ProduceResourceDataUint	= new ProduceResourceDataUint();
        private var stoneResBean:ProduceResourceDataUint	= new ProduceResourceDataUint();
		private var result:RuleCheckResult;
		
		private var fortTotalSpace:int;
		private var fortUseSpace:int;
		private var fortLeftSpace:int;
		
		public var dataArr:ArrayCollection;
		
		public function ProduceResourceData()
		{
		}

		public function set ruleResult(result:RuleCheckResult):void{
			this.result = result;
			this.refreshDataArray();
		}
		
		/**
		 *更新资源 
		 */
		public function updateResource():void{
			var res:CastleResourceManager = GameContext.instance.getPlayerObj().getCurCastleObj().resourceManager;

			foodResBean.curAmount = int(res.food.curAmount);
			woodResBean.curAmount	= int(res.wood.curAmount);
			stoneResBean.curAmount= int(res.stone.curAmount);
			ironResBean.curAmount = int(res.iron.curAmount);
		}
		
		private function refreshDataArray():void {
			dataArr = new ArrayCollection();
			var res:CastleResourceManager = GameContext.instance.getPlayerObj().getCurCastleObj().resourceManager;

			if (result.food.reqNum>0) {
				foodResBean.typeName      = MultiLang.msg("public.get.food");
				foodResBean.curAmount = int(res.food.curAmount);
				dataArr.addItem(foodResBean);
			}
			
			if (result.wood.reqNum>0) {
				woodResBean.typeName       = MultiLang.msg("public.get.wood");
				woodResBean.curAmount	= int(res.wood.curAmount);
				dataArr.addItem(woodResBean);
			}

			if (result.stone.reqNum>0) {
				stoneResBean.typeName     = MultiLang.msg("public.get.stone");
				stoneResBean.curAmount= int(res.stone.curAmount);
				dataArr.addItem(stoneResBean);
			}
			
			if( result.iron.reqNum > 0){
				ironResBean.typeName      = MultiLang.msg("public.get.iron");
				ironResBean.curAmount = int(res.iron.curAmount);
				dataArr.addItem(ironResBean);
			}
		}
		
		public function reCalcDataArray(value:int):void {
			if(value == 0)value =1;
			
			this.foodResBean.requestAmount = value * result.food.reqNum;
			this.woodResBean.requestAmount = value * result.wood.reqNum;
			this.stoneResBean.requestAmount= value * result.stone.reqNum;
			this.ironResBean.requestAmount = value * result.iron.reqNum;
		}

		public function reCalcDataArrayForDisband(value:int):void {
			if(value ==0) value =1;

			this.foodResBean.requestAmount = int(value * result.food.reqNum*0.3);
			this.woodResBean.requestAmount = int(value * result.wood.reqNum*0.3);
			this.stoneResBean.requestAmount= int(value * result.stone.reqNum*0.3);
			this.ironResBean.requestAmount = int(value * result.iron.reqNum*0.3);
		}
		
		
		/**
		 * 计算当前可建筑兵种或者武器数量
		 * @param rule
		 * @return 
		 */
		private function calcMaxProduction():int {
			var foodNum:int = result.food.reqNum;
			var woodNum:int = result.wood.reqNum;
			var stoneNum:int= result.stone.reqNum;
			var ironNum:int = result.iron.reqNum;
			var goldsNum:int = result.golds.reqNum;
			
			var res:CastleResourceManager = GameContext.instance.getPlayerObj().getCurCastleObj().resourceManager;

	        var min:Number = Number.MAX_VALUE;
			if (foodNum>0){
				min = Math.min(min, res.food.curAmount/foodNum);
			}
			if (woodNum>0){
				min = Math.min(min, res.wood.curAmount/woodNum);
			}
			if (stoneNum>0){
				min = Math.min(min, res.stone.curAmount/stoneNum);
			}
			if (ironNum>0){
				min = Math.min(min, res.iron.curAmount/ironNum);
			}
			if(goldsNum>0){
				min = Math.min(min, res.golds.curAmount/goldsNum);
			}
			
	     	return min;
		}
		
		/**
		 * 计算可生产兵种或者武器数量
		 * @param rule
		 * @return 
		 */
		public function calcTroopMaxProduce(rule:TroopRule):int{
			var res:CastleResourceManager = GameContext.instance.getPlayerObj().getCurCastleObj().resourceManager;
			//把空闲人口改为当前人口
			var np:int = res.curPopulation/rule.population;
			
			return Math.min(this.calcMaxProduction(),np);			
		}

		/**
		 *根据资、人口计、等级算可训练的最大工人数量 
		 * @param rule
		 * @return 
		 * 
		 */		
		public function calcMaxWorkerTrainning(rule:WorkerRule,rule1:BuildingRule):int{
			var min:int = Math.min(this.calcMaxProduction(),rule1.buff1);
			return min;
		}
		
		/**
		 * 计算可生产城防数量
		 * @return 
		 */
		public function calcFortMaxProduce(level:int,rule:ForticationRule,queueAry:ArrayCollection):int{
			//城防总空间
			if (level>0) {
				//城防剩余空间可建造城防数
				var fortNum:int = int(this.caleFortLeftSpace(level,queueAry)/rule.fortSpace);
				
				return Math.min(fortNum,calcMaxProduction())>0?Math.min(fortNum,calcMaxProduction()):0;
			} else {
				return 0;
			}
		}
		
		/**
		 * 已用城防空间
		 * @return 
		 */
		private function calcFortUseSpace(queueAry:ArrayCollection):int{
			var useSpace:int=0;
			var troopManager:TroopManager = GameContext.instance.getPlayerObj().getCurCastleObj().troopManager;
			
			useSpace += troopManager.getFortificationByTypeId(TroopForConstants.F_TRAPS).value * 1;
			useSpace += troopManager.getFortificationByTypeId(TroopForConstants.F_TOWER).value * 3;
			useSpace += troopManager.getFortificationByTypeId(TroopForConstants.F_FALLROCK).value * 5;
			
			
			if(queueAry!=null){
				return useSpace + this.calcFortQueueSpace(queueAry);
			}else{
				return useSpace;
			}
		}
		
		/**
		 *计算城防 队列空间
		 * @param queueAry
		 * @return 
		 * 
		 */
		private function calcFortQueueSpace(queueAry:ArrayCollection):int{
			var useSpace:int =0;
			if(queueAry.length>0){
				for each(var bean:ManufactureBean in queueAry){
					if(bean.type== TroopForConstants.F_TRAPS){
						useSpace+= bean.number*1;
					}else if(bean.type== TroopForConstants.F_TOWER){
						useSpace+= bean.number*3;
					}else if(bean.type== TroopForConstants.F_FALLROCK){
						useSpace+= bean.number*5;
					}
				}
				/* 	with(bean){
						if(type == TroopForConstants.F_TRAP){
							useSpace+= number*1;
						}else if(type == TroopForConstants.F_ARROWTOWER){
							useSpace+= number*3;
						}else{
							useSpace+= number*5;
						}
					} */
			}
			
			return useSpace;
		}
		
		/**
		 *城防剩余空间 
		 * @param level
		 * @return 
		 * 
		 */
		private function caleFortLeftSpace(level:int,queueAry:ArrayCollection):int{
			this.fortTotalSpace =GameRuleHelper.instance.getBuildingRule(BuildingConstant.TYPE_WALL_BUILDING,level).buff1;
			this.fortUseSpace = this.calcFortUseSpace(queueAry);
			this.fortLeftSpace =this.fortTotalSpace - this.fortUseSpace;
			
			return this.fortLeftSpace;
		}
		
		/**
		 *返回城防总空间 
		 * @return 
		 * 
		 */
		public function getFortTotalSpace():int{
			return this.fortTotalSpace;
		}

		/**
		 *返回城防已经空间 
		 * @return 
		 * 
		 */
		public function getFortUseSpace():int{
			return this.fortUseSpace;
		}

		/**
		 *返回城防剩余空间 
		 * @return 
		 * 
		 */
		public function getFortLeftSpace():int{
			return this.fortLeftSpace;
		}
	}
}
