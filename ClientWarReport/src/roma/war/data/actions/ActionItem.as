package roma.war.data.actions
{
	public class ActionItem
	{
		
		public var actionId:int = 0;
		private var _round:int;
		private var _type:int;
		private var _contents:Array;
		
		public function ActionItem(r:int = -1)
		{
			_round = r;
			_contents = new Array();
		}
		
		public function get round():int{
			return _round;
		}
		
		public function get type():int{
			return _type;
		}
		
		public function get contents():Array{
			return _contents;
		}
		
		public function set type(t:int):void{
			_type = t;
		}
		
		public function set contents(a:Array):void{
			this._contents = a;
		}
		
		public function toString():String{
			return "[TurnItem] type[" + _type +"]" + " length[" + _contents.length + "] " + "data[" + _contents.toString() + "]";
		}
	}
}