package views.spreadUI.castleStatus
{
	import roma.logic.object.hero.HeroObj;
	
	public class MyArmyTimeCacheBean
	{
		public var arriveTime:Number;
		public var dataObj:HeroObj;
		public function MyArmyTimeCacheBean(arriveTime:Number,dataObj:HeroObj)
		{
			this.arriveTime=arriveTime;
			this.dataObj=dataObj;
		}
	}
}