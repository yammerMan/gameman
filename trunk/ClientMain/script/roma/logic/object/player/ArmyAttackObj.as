package roma.logic.object.player
{
	/**
	 * 骑兵技巧、制造技术、步兵技巧
	 */	

	[Bindable]
	public class ArmyAttackObj
	{
		/**骑兵技巧加成攻击能力百分比 */
		public var techEquAddAttackPercent:int;
		
		/** 骑兵攻击能力 */		
		public var cavalryAttaAbi:Number;
		
		/** 斥候攻击能力 */
		public var scoutAttaAbi:Number;
		
		/**制造技术加成攻击能力百分比*/
		public var techFabAddAttackPercent:int;
		
		/**弩炮攻击能力*/
		public var ballistasAttaAbi:Number; 
		
		/**投石器攻击能力*/
		public var onagersAttaAbi:Number; 	
	
		/**箭塔攻击能力*/
		public var arrowTowerAttaAbi:Number; 
		
		/**落石攻击能力*/
		public var rockfallAttaAbi:Number; 

		/**步兵技巧加成攻击能力百分比*/
		public var techInfAddAttackPercent:int;
		
		/**步兵攻击能力*/
		public var triariiAttaAbi:Number;
		
		public function ArmyAttackObj()
		{
			
		}
		
		/**
		 *计算骑兵技术百分比加成后的攻击值 
		 */
		public function reCalculateEquAttaAbi():void{
			//TODO
		}
		
		/**
		 *计算建造技术 百分比加成后的攻击值
		 */
		public function reCalculateFabAttaAbi():void{
			//TODO
		}
		
		/**
		 *计算步兵技巧百分比加成后的攻击值 
		 */
		public function reCalculateInfAttaAbi():void{
			//TODO
		}
	}
}