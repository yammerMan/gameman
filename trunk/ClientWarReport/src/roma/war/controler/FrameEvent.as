package roma.war.controler
{
	import flash.events.Event;
	
	public class FrameEvent extends Event
	{
		//player state
		public static const PLAYER_PLAYING:String = "player_playing";
		public static const PLAYER_PLAY:String = "player_play";
		public static const PLAYER_STOP:String = "player_stop";
		public static const PLAYER_PAUSE:String = "player_pause";
		public static const PLAYER_RESUME:String = "player_resume";
		public static const PLAYER_COMPLETE:String = "player_complete";
		
		//place state
		public static const PLACE_STATE_OUTSIDE:String = "place_outside";
		public static const PLACE_STATE_INSIDE:String = "place_inside";
		public static const PLACE_STATE_FIELD:String = "placeStateField";
		public static const PLACE_STATE_NOWALL:String = "placeNoWall";
		
		
		public function FrameEvent(type:String,value:Object = null)
		{
			super(type);
			_value = value;
		}
		
		private var _value:Object;
		public function get value():Object{
			return _value;
		}
		
	}
}