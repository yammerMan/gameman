package views.spreadUI.castleStatus
{
	import roma.logic.object.player.ScoutTeamObj;
	
	public class MyScoutTimeCacheBean
	{
		public var arriveTime:Number;
		public var scoutObj:ScoutTeamObj;
		public function MyScoutTimeCacheBean(t:Number,obj:ScoutTeamObj)
		{
			this.arriveTime = t;
			this.scoutObj = obj;
		}

	}
}