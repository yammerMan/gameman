package roma.logic.object.player
{
	/**
	 *后勤学、行军技巧、救援技术
	 */
	 
	[Bindable]	
	public class ArmyAssistObj
	{
		/**后勤学加成，军队负重能力提升的百分比*/
		public var armyLoadAddPercent:int
		
		/**加成后军队负重*/
		public var armyLoad:Number;
		
		/**行军技巧加成，军队大地图移动速度增加的百分比*/
		public var armyMovSpeAddPercent:int;
		
		/**军队大地图移动速度*/
		public var armyMoveSpeed:Number;
		
		/**救援技术加成，军队生命或耐久值增加的百分比*/
		public  var armyLifeOrWearAddPercent:int;
		
		/**军队的生命或耐久值*/
		public var armyLifeOrWear:Number;

		/**防御技巧加成，军队防御能力增加的百分比*/
		public var armyDefenceAddPercent:int;
		
		/**军队的防御能力*/
		public var armyDefence:Number;
		
		public function ArmyAssistObj()
		{
		}

		/**
		 *计算军队负重能力 
		 */
		public function reCalcArmyLoad():void{
			//TODO
		}
		
		/**
		 *计算军队地图移动速度 
		 */
		public function reCalcArmyMovSpeed():void{
			//TODO
		}

		/**
		 *计算军队生命或耐久值
		 */
		public function reCalcArmyLifeOrWear():void{
			//TODO
		}
		
		/**
		 *计算军队防御能力
		 */
		public function reCalcArmyDefence():void{
			//TODO
		}
	}
}