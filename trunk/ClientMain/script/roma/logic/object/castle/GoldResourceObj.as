package roma.logic.object.castle
{
	import roma.logic.GameContext;
	import roma.logic.object.building.BuildingHelper;
	
	[Bindable]
	public class GoldResourceObj
	{
		/** 总产量*/
		public var totalProduce:Number;
		
		/** 军队消耗 */
		public var heroSalary:int = 0;
		
		/** 当前资源量 */
		public var curAmount:Number = 0;

		private var resManager:CastleResourceManager;
		
		public var isFull:Boolean=false;
		
		public var maxCap:Number;
		
		public function GoldResourceObj(resManager:CastleResourceManager)
		{
			this.resManager = resManager;
		}
		
		/**
		 * 重新计算产量
		 */
		public function reCalcTotalProduce(time:Number):void {
			if(GameContext.instance.getPlayerObj()==null)return;
			if(GameContext.instance.getPlayerObj().getCurCastleObj()==null)return;
			if(GameContext.instance.getPlayerObj().getCurCastleObj().buildingManager==null)return;
			if(GameContext.instance.getPlayerObj().getCurCastleObj().buildingManager.getTownHall()==null)return;

			this.maxCap=BuildingHelper.protectLimitArray[GameContext.instance.getPlayerObj().getCurCastleObj().buildingManager.getTownHall().level-1];
			
			if(this.curAmount<this.maxCap){
				isFull=false;
				this.curAmount += this.totalProduce * time ;
				if (this.curAmount > this.maxCap) {
					this.curAmount = this.maxCap;
					isFull=true;
				} else if (this.curAmount<0) {
					this.curAmount = 0;
				}
			}else{
				isFull=true;
				if(this.totalProduce<0){
					this.curAmount += this.totalProduce * time ;
					if(this.curAmount<0) {
						this.curAmount = 0;
					}
				}
			}
		}
	}
}