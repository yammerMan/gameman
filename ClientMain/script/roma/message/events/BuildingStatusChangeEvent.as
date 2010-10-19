package roma.message.events
{
	import flash.events.Event;
	
	import roma.logic.object.building.BaseBuilding;

	/**
	 * 当服务器发送建筑更新的时候，如果建筑的状态发生了变化，就产生这个事件，用于通知生产队列显示界面更新
	 */
	public class BuildingStatusChangeEvent extends Event
	{
		
		public static const EVENT_NAME:String = "BuildingStatusChangeEvent.name";
		
		public var buildingObj:BaseBuilding;
		
		public function BuildingStatusChangeEvent(obj:BaseBuilding, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(EVENT_NAME, bubbles, cancelable);
			this.buildingObj = obj;
		}
		
	}
}