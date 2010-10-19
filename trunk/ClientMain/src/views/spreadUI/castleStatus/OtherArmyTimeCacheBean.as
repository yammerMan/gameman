package views.spreadUI.castleStatus
{
	import roma.logic.object.player.OtherArmyObj;
	
	public class OtherArmyTimeCacheBean
	{
		public var arriveTime:Number;
		public var dataObj:OtherArmyObj;
		public function OtherArmyTimeCacheBean(arriveTime:Number,dataObj:OtherArmyObj)
		{
			this.arriveTime=arriveTime;
			this.dataObj=dataObj;
		}
	}
}