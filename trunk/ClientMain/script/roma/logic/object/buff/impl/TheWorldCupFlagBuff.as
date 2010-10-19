package roma.logic.object.buff.impl
{
	import roma.logic.object.buff.BaseBuffObj;
	public class TheWorldCupFlagBuff extends BaseBuffObj
	{
		public var typeId:int;
		public function TheWorldCupFlagBuff(type:int)
		{
			super();
			typeId=type;
		}
		
		override protected function getClassName():String {
			return "theWorldCupFlagBuff";
		}
		
		override public function isShow():Boolean {
			return true;
		}
	}
}