package roma.logic.object.player
{
	import roma.common.valueObject.BattleFieldBean;
	
	[Bindable]
	public class BattleFieldObj
	{
		public var isAttack:Boolean = false;
		public var isDefend:Boolean = false;
		public var isMid:Boolean = false;
		public var isInSelected:Boolean = false;
		public var battleWildBean:BattleFieldBean;
		public var battleTime:Number = 0;
		public function BattleFieldObj(battleBean:BattleFieldBean)
		{
			this.battleWildBean = battleBean;
			this.battleTime = battleBean.battleTime;	
		}

	}
}