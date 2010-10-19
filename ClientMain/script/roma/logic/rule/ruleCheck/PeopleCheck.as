package roma.logic.rule.ruleCheck
{
	import roma.logic.GameContext;
	import roma.util.MultiLang;
	
	
	[Bindable]
	public class PeopleCheck extends BaseCheck
	{
		public var reqNum:int;

		public function PeopleCheck(reqNum:int)
		{
			super(reqNum);
			this.reqNum = reqNum;
			this.dispReq = "\n"+MultiLang.msg('label.population.current')+" "+this.reqNum;
		}
		
		override public function check():void{
			var curNum:int = GameContext.instance.getPlayerObj().getCurCastleObj().resourceManager.curPopulation;
			
			this.isMatch = (curNum >= this.reqNum);
			this.dispCur = MultiLang.msg('label.population.current')+" "+curNum;
		}
	}
}