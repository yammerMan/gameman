package roma.logic.object.player
{	
	/**
	 *领导能力、学习技巧 
	 */	

	[Bindable]
	public class HeroAssistObj
	{
		/**英雄领导能力加成，增加率领部队人数的百分比*/
		public var heroLeadAddPercent:int;
		
		/**英雄可率领的部队人数*/
		public var leadPeopleNum:int;
		
		/**英雄学习能力加成,经验值增加的百分比*/
		public var heroLearnAddPercent:int;
		
		/**英雄升级所需经验值*/
		public var needEmpValue:Number;
		
		public function HeroAssistObj()
		{
		}
		
		/**
		 *计算英雄带领的部队人数 
		 */
		public function reCalLeadPeoNum():void{
			//TODO
		}
		
		/**
		 *计算英雄升级所需的经验值 
		 */
		public function reCalNeedEepVal():void{
			//TODO
		}
	}
}