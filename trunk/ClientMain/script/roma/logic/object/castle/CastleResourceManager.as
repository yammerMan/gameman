package roma.logic.object.castle
{
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import mx.logging.ILogger;
	import mx.logging.Log;
	
	import roma.common.constants.ResourceConstant;
	import roma.common.constants.TechConstant;
	import roma.common.controller.castle.ResourceStaticResponse;
	import roma.common.valueObject.CastlePopulationBean;
	import roma.common.valueObject.CityResourceBean;
	import roma.common.valueObject.ResourceStaticBean;
	import roma.logic.GameContext;
	import roma.util.MultiLang;
	
	[Bindable]
	public class CastleResourceManager
	{
		private static const log:ILogger = Log.getLogger("roma.logic.object.castle.CastleResourceManager");
		
		private var _castle:CastleObj;
		
		/** 最大人口数 */
		public var maxPopulation:int;

		/** 当前人口数 */
		public var curPopulation:int;
		
		/** 劳动人口 */
		public var workingPopulation:int;
		
		/** 实际劳动人口 */
		public var workingPopulationInFact:int;
		
		
		/** 空闲人口 */
		public var freePopulation:int;
		
		/** 人口变化方向 */
		public var populationChangeDir:String;
		
		/** 科技加成后的仓库容量 */
		public var maxCap:Number = 0;
		
		/** 粮食仓库容量 */
		public var foodStorePer:int;
		
		/** 木材仓库容量 */
		public var woodStorePer:int;
		
		/** 石头仓库容量 */
		public var stoneStorePer:int;
		
		/** 铁矿仓库容量 */
		public var ironStorePer:int;

		/** 民怨 */
		public var complaint:int;

		/** 民心 */
		public var support:int;

		/** 税率 */
		public var texRate:int;
		
		/** 民心变化方向 -1 ， 0 ，1 */
		public var supportDir:String;
		
		/** 工作效率 */
		public var workerEfficiency:Number;
		
		/** 工作需要的人口 */
		public var workerInRate:int;
		
		
		
		public var food:ResourceObj;
		public var wood:ResourceObj;
		public var stone:ResourceObj;
		public var iron:ResourceObj;
		public var golds:GoldResourceObj;
		
		private var lastCalcTime:Number;
		
		public function CastleResourceManager(castle:CastleObj , resBean:CityResourceBean , populationBean:CastlePopulationBean)
		{
			_castle = castle;
			
			this.food = new ResourceObj(this);
			this.wood = new ResourceObj(this);
			this.stone = new ResourceObj(this);
			this.iron = new ResourceObj(this);
			this.golds = new GoldResourceObj(this);
			
			this.setCityResourceBean(resBean);
			this.setCastlePopulation(populationBean);
			this.lastCalcTime = new Date().valueOf();
			this.refresh();
			
			var timerHandle:Function = function (event:TimerEvent):void {
				refresh();
			}
			var timer:Timer = new Timer(1000);
			timer.addEventListener(TimerEvent.TIMER , timerHandle);
			timer.start();
		}
		
		public function setCityResourceBean(bean:CityResourceBean):void {
			log.debug("food:{0} wood:{1} stone:{2} iron{3} golds{4}",
				bean.foods - food.curAmount , bean.woods - wood.curAmount , bean.stones - stone.curAmount, bean.irons-iron.curAmount, bean.golds - golds.curAmount);
			
			food.curAmount = bean.foods;
			food.totalProduce = bean.foodIncRate;
			
			var curTechLv:int = GameContext.instance.getPlayerObj().techManager.getTechObjById(TechConstant.SUPPLY_SKILL_TYPE).getCurCastleTechLevel(_castle);  
			food.troopConsume = bean.troopConsumeFood;
			
			wood.curAmount = bean.woods;
			wood.totalProduce = bean.woodIncRate;
			
			stone.curAmount = bean.stones;
			stone.totalProduce = bean.stoneIncRate;
			
			iron.curAmount = bean.irons;
			iron.totalProduce = bean.ironIncRate;
			
			golds.curAmount = bean.golds;
			golds.totalProduce = bean.goldIncRate;
			golds.heroSalary = bean.heroSalary;
			
			this.maxCap = bean.warehouseCap;
			this.foodStorePer=bean.foodStorePer;
			this.woodStorePer=bean.woodStorePer;
			this.stoneStorePer=bean.stoneStorePer;
			this.ironStorePer=bean.ironStorePer;
		}

		public function setCastlePopulation(bean:CastlePopulationBean):void {
			curPopulation=bean.curentPop;
			food.worker = bean.foodWorker;
			food.workRate=bean.foodRate;
			wood.worker = bean.woodWorker;
			wood.workRate=bean.woodRate;
			stone.worker = bean.stoneWorker;
			stone.workRate= bean.stoneRate;
			iron.worker = bean.ironWorker;
			iron.workRate=bean.ironRate;
			
			this.workingPopulation = bean.foodWorker + bean.woodWorker + bean.stoneWorker + bean.ironWorker;
			this.workerInRate=int(bean.foodWorker*bean.foodRate/100)+int(bean.woodWorker*bean.woodRate/100)+int(bean.stoneWorker*bean.stoneRate/100)+int(bean.ironWorker*bean.ironRate/100);
			this.workingPopulationInFact=this.curPopulation>workerInRate?workerInRate:this.curPopulation;
			this.freePopulation = this.curPopulation - this.workingPopulationInFact>0?this.curPopulation - this.workingPopulationInFact:0;
			this.maxPopulation = bean.maxPopu;
			
			this.complaint = bean.popComp;
			this.support = bean.popSupp;
			this.texRate = bean.tax;
			
			change();			
		}

		public function refresh():void {
			//计算资源增长
			var now:Number = new Date().valueOf();
			var time:Number = (now - this.lastCalcTime) / (60*60*1000); //增长率 = 时间差/小时
			
			this.food.reCalcTotalProduce(time,ResourceConstant.TYPE_FOOD);
			this.wood.reCalcTotalProduce(time,ResourceConstant.TYPE_WOOD);
			this.stone.reCalcTotalProduce(time,ResourceConstant.RESOURCE_TYPE_STONES);
			this.iron.reCalcTotalProduce(time,ResourceConstant.TYPE_IRON);
			this.golds.reCalcTotalProduce(time);
			this.lastCalcTime = now;
		}
		
		/**修改开工率之后的更新*/
		public function refreshResource(event:ResourceStaticResponse):void{	
			var foodResourceStaticBean:ResourceStaticBean=event.foodBean;
			var woodResourceStaticBean:ResourceStaticBean=event.woodBean;
			var stoneResourceStaticBean:ResourceStaticBean=event.stoneBean;
			var ironResourceStaticBean:ResourceStaticBean=event.ironBean;

			food.workRate=foodResourceStaticBean.operRate;
			wood.workRate=woodResourceStaticBean.operRate;
			stone.workRate=stoneResourceStaticBean.operRate;
			iron.workRate=ironResourceStaticBean.operRate;
			
			food.totalProduce=foodResourceStaticBean.totoalProduce;
			wood.totalProduce=woodResourceStaticBean.totoalProduce;
			stone.totalProduce=stoneResourceStaticBean.totoalProduce;
			iron.totalProduce=ironResourceStaticBean.totoalProduce;
			
			this.workerInRate=int(food.worker*food.workRate/100)+int(wood.worker*wood.workRate/100)+int(stone.worker*stone.workRate/100)+int(iron.worker*iron.workRate/100);
			this.workingPopulationInFact=this.curPopulation>workerInRate?workerInRate:this.curPopulation;
			this.freePopulation = this.curPopulation - this.workingPopulationInFact>0?this.curPopulation - this.workingPopulationInFact:0;
			
			change();			
		}
		
		private function change():void{
			this.workerEfficiency=int(this.workingPopulationInFact/this.workerInRate*100)/100;
			
			var dir:int = 100 - this.support - this.complaint - this.texRate;
			if (dir >0) {
				this.supportDir = MultiLang.msg("support.change.increase");
			} else if (dir < 0) {
				this.supportDir = MultiLang.msg("support.change.decrease");
			} else {
				this.supportDir = MultiLang.msg("support.change.balance");
			}

			var pop:Number= this.maxPopulation * this.support/ 100 - this.curPopulation;
			if (pop>=1) {
				this.populationChangeDir = MultiLang.msg("support.change.increase");
			} else if (pop<=-1) {
				this.populationChangeDir = MultiLang.msg("support.change.decrease");
			} else {
				this.populationChangeDir = MultiLang.msg("support.change.balance");
			}
		}
	}
}