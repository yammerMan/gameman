package roma.war.data.bean
{
	import mx.collections.ArrayCollection;
	
	import roma.common.constants.BattleConstants;
	import roma.common.constants.LetterConstant;
	import roma.war.data.actions.ActionATK;
	import roma.war.data.actions.ActionItem;
	import roma.war.data.actions.ActionMove;
	import roma.war.data.actions.ActionQuit;
	import roma.war.data.actions.ActionRetreat;
	import roma.war.data.actions.ActionRockConsume;
	import roma.war.data.actions.ActionRockMiss;
	import roma.war.data.actions.ActionTrapATK;
	import roma.war.data.actions.ActionTrapWork;
	import roma.war.data.actions.ActionWait;
	
	public class Frames
	{
		public var round:ArrayCollection;//RoundNode
		public var action:ArrayCollection;//TurnItem
		
		public function Frames()
		{
			round = new ArrayCollection();
			action = new ArrayCollection();
		}
		
		public function addRound(s:String):void{
			parse(s);
		}
		
		private function parse(s:String):void{
			var rn:RoundNode = new RoundNode();
			rn.id = round.length;
			var id:int = rn.startIndex = action.length;
			//round
			round.addItem(rn);
			
			//parse replay child
			var ra:Array = s.split(LetterConstant.SPR_MSG);
			ra.pop();
			for(var i:int=0;i<ra.length;i++){
				var aa:Array = String(ra[i]).split(LetterConstant.SPR_INT);
				var ai:ActionItem;
				var a:int = aa[0]
				switch(a){
					case BattleConstants.ROUND_ACK:
						ai = new ActionATK(rn.id);
						break;
					case BattleConstants.ROUND_ARMY_MOVE:
						ai = new ActionMove(rn.id);
						break;
					case BattleConstants.ROUND_ARMY_QUIT:
						ai = new ActionQuit(rn.id);
						break;
					case BattleConstants.ROUND_ARMY_RETREAT:
						ai = new ActionRetreat(rn.id);
						break;
					case BattleConstants.ROUND_ROCK_CONSUME:
						ai = new ActionRockConsume(rn.id);
						break;
					case BattleConstants.ROUND_ROCK_MISS:
						ai = new ActionRockMiss(rn.id);
						break;
					case BattleConstants.ROUND_TRAP_ACK:
						ai = new ActionTrapATK(rn.id);
						break;
					case BattleConstants.ROUND_TRAP_WORK:
						ai = new ActionTrapWork(rn.id);
						break;
					case BattleConstants.ROUND_WAIT:
						ai = new ActionWait(rn.id);
						break;
				}
				ai.actionId = id;
				ai.type = aa[0];
				ai.contents = aa;
				action.addItem(ai);
				id ++;
				ai = null;
			}
			rn.endIndex = action.length-1;
		}
		
		public function getActionItem(i:int):ActionItem{
			if(i>=action.length){trace("action is over");return null;}
			return action[i];
		}
		
		private var arr:Array = [];
		private var r:RoundNode;
		public function getRoundAction():Array{
			arr = [];
			for each(r in round){
				arr.push(r.endIndex);
			}
			return arr;
		}
		
	}
}