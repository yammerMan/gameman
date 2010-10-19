package views.windows.functionWins.mail.bean
{
	import mx.utils.ObjectProxy;
	
	import roma.common.constants.BattleConstants;
	import roma.common.constants.LetterConstant;
	
	[Bindable]
	public class RoundType
	{
		public var ack:ObjectProxy = new ObjectProxy();
		public var armyMove:ObjectProxy = new ObjectProxy();
		public var armyQuit:ObjectProxy = new ObjectProxy();
		public var armyRetreat:ObjectProxy = new ObjectProxy();
		public var trapAttack:ObjectProxy = new ObjectProxy();
		public var unitWait:ObjectProxy = new ObjectProxy();
		public var trapWork:ObjectProxy = new ObjectProxy();
		public var rockfallMiss:ObjectProxy = new ObjectProxy();
		public var rockfallConsume:ObjectProxy = new ObjectProxy();
		
		public function RoundType(s:String)
		{
			initType();
			setRoundProperty(s);
		}
		
		private function initType():void{
			ack = null;
			armyMove = null;
			armyQuit = null;
			armyRetreat = null;
			trapAttack = null;
			unitWait = null;
			trapWork = null;
			rockfallMiss = null;
		}
		
		private function setRoundProperty(s:String):void{
			var a:Array = s.split(LetterConstant.SPR_INT);
			a.pop();
			var i:int = int(a[0]);	
			switch(i){
				case BattleConstants.ROUND_ACK:
					ack = new ObjectProxy();
					ack.k1 = a[1];
					ack.p1 = a[2];
					ack.k2 = a[3];
					ack.p2 = a[4];
					ack.mode = a[5];
					ack.dmg = a[6];
				break;
				case BattleConstants.ROUND_ARMY_MOVE:
					armyMove = new ObjectProxy();
					armyMove.key = a[1];
					armyMove.pos = a[2]
				break;
				case BattleConstants.ROUND_ARMY_QUIT:
					armyQuit = new ObjectProxy();
					armyQuit.key = a[1];
					armyQuit.pos = a[2];
				break;
				case BattleConstants.ROUND_ARMY_RETREAT:
					armyRetreat = new ObjectProxy();
					armyRetreat.key = a[1];
					armyRetreat.pos = a[2];
				break;
				case BattleConstants.ROUND_ROCK_CONSUME:
					rockfallConsume = new ObjectProxy();
					rockfallConsume.count = a[1];
				break;
				case BattleConstants.ROUND_ROCK_MISS:
					rockfallMiss = new ObjectProxy();
					rockfallMiss.key = a[1];
					rockfallMiss.pos = a[2];
				break;
				case BattleConstants.ROUND_TRAP_ACK:
					trapAttack = new ObjectProxy();
					trapAttack.key = a[1];
					trapAttack.pos = a[2];
					trapAttack.count = a[3];
				break;
				case BattleConstants.ROUND_TRAP_WORK:
					trapWork = new ObjectProxy();
					trapWork.trapCount = a[1];
					trapWork.hitCount = a[2];
				break;
				case BattleConstants.ROUND_WAIT:
					unitWait = new ObjectProxy();
					unitWait.key = a[1];
					unitWait.pos = a[2];
				break;
			}
		}
		
	}
}