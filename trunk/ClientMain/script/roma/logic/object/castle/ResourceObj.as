package roma.logic.object.castle
{
	import roma.common.constants.ResourceConstant;
	
	[Bindable]
	public class ResourceObj
	{
		/** 劳动人口 ， 服务器更新*/
		public var worker:int;
		/**开工率*/
		public var workRate:int;
		
		/** 总产量*/
		public var totalProduce:Number;
		
		/** 军队消耗 */
		public var troopConsume:int = 0;
		
		/** 当前资源量 */
		public var curAmount:Number=0;
		
		/** 各种资源仓库上限*/
		public var capUpperlimit :Number;
		
		private var resManager:CastleResourceManager;
		
		public function ResourceObj(resManager:CastleResourceManager)
		{
			this.resManager = resManager;
		}
		
		/**
		 * 重新计算产量
		 */
		public function reCalcTotalProduce(time:Number,t:int=0):void {
			var resMaxCap:Number;
			switch(t){
				case ResourceConstant.TYPE_FOOD:
					resMaxCap = Math.ceil(this.resManager.maxCap*(this.resManager.foodStorePer/100));
					break;
				case ResourceConstant.RESOURCE_TYPE_STONES:
					resMaxCap = Math.ceil(this.resManager.maxCap*(this.resManager.stoneStorePer/100));
					break;
				case ResourceConstant.TYPE_WOOD:
					resMaxCap = Math.ceil(this.resManager.maxCap*(this.resManager.woodStorePer/100));
					break;
				case ResourceConstant.TYPE_IRON:
					resMaxCap = Math.ceil(this.resManager.maxCap*(this.resManager.ironStorePer/100));
					break;
			}
			
			capUpperlimit = resMaxCap;
			
			if (this.curAmount < resMaxCap) {
				this.curAmount += this.totalProduce * time ;
				if (this.curAmount > resMaxCap) {
					this.curAmount = resMaxCap;
				} else if (this.curAmount<0) {
					this.curAmount = 0;
				}
			}else{
				if(this.totalProduce<0){
					this.curAmount += this.totalProduce * time ;
					if(this.curAmount<0) {
						this.curAmount = 0;
					}
				}
			}
		}
		
		/**
		 * 仓库容量是否满
		 */ 
		public function isCapacityFull():Boolean{
			return this.curAmount>=this.capUpperlimit;
		}  
	}
}