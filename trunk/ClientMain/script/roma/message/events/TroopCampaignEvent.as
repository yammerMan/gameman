package roma.message.events
{
	import flash.events.Event;
	
	import roma.data.MapTileData;
	
	public class TroopCampaignEvent extends Event
	{
		public var troopCampaignData:MapTileData;
		public static var TROOP_CAMPAIGN:String = "troop.campaign";
		public var showType:int;
		public function TroopCampaignEvent(type:String,obj:MapTileData,showType:int, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.troopCampaignData = obj;
			this.showType=showType;
		}

	}
}