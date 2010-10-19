package roma.logic.object.castle
{
	import mx.collections.ArrayCollection;
	
	import roma.common.events.ArmyUpdate;
	import roma.common.events.OtherArmyUpdate;
	import roma.logic.object.IChangeResource;
	
	public class ArmyManager implements IChangeResource
	{
		public function ArmyManager(castle:CastleObj , armyArray:ArrayCollection , otherArmyArray:ArrayCollection)
		{
		}
		
		/**
		 * 自己的军队更新
		 */
		public function updateSelfArmy(event:ArmyUpdate):void {
			//TODO
		}
		
		/**
		 * 别人的军队更新
		 */
		public function updateOtherArmy(event:OtherArmyUpdate):void {
			//TODO
		}

		/**
		 * 军队消耗粮食
		 */
		public function effect(resourceManager:CastleResourceManager):void {
			//TODO
		}

	}
}