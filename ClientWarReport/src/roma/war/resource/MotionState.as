package roma.war.resource
{
	public class MotionState
	{	
		
		public function MotionState(name:String,frames:Array,canLoop:Boolean = true)
		{
			this.name = name;
			this.frames = frames;
			this.canLoop = canLoop;
		}
		
		public var name:String;
		public var frames:Array;
		public var canLoop:Boolean;

	}
}