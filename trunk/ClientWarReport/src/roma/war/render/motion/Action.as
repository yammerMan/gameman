package roma.war.render.motion
{	
	public class Action
	{
		public function Action(state:String,actionLength:Number,actionPosition:Number = 0)
		{
			this.state = state;
			this.actionLength = actionLength;
			this.actionPosition = actionPosition;
		}
		public var state:String;
		public var readyState:String;
		public var actionPosition:Number;
		public var actionLength:Number;
		public var loop:Boolean = false;

	}
}