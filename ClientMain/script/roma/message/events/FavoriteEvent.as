package roma.message.events
{
	import flash.events.Event;
	import roma.message.EvtDispacther;

	public class FavoriteEvent extends Event
	{
		public var evtName:String;
		public var evtData:Object;
		public var remark:String;
		public var idField:int;
		
		public function FavoriteEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
		public static function addFavorite(name:String,id:int,str:String):void{
			var e:FavoriteEvent = new FavoriteEvent(name);
			e.idField = id;
			e.remark = str;
			EvtDispacther.instance.dispatchEvent(e);
		}
		
		public static function updateFavorite(name:String,data:Object,str:String):void{
			var e:FavoriteEvent = new FavoriteEvent(name);
			e.evtData = data;
			e.remark = str;
			EvtDispacther.instance.dispatchEvent(e);
		}
		
		public static function deleteFavorite(name:String,data:Object,str:String=null):void{
			var e:FavoriteEvent = new FavoriteEvent(name);
			e.evtData = data;
			EvtDispacther.instance.dispatchEvent(e);
		}
	}
}