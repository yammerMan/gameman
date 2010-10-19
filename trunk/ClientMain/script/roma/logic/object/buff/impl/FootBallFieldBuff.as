package roma.logic.object.buff.impl
{
	import roma.logic.object.buff.BaseBuffObj;
	
	public class FootBallFieldBuff extends BaseBuffObj
	{
		public var typeId:int;
		public function FootBallFieldBuff(type:int)
		{
			super();
			typeId=type;
		}
		
		override protected function getClassName():String {
			return "footBallFieldBuff";
		}

		override public function isShow():Boolean {
			return true;
		}

	}
}