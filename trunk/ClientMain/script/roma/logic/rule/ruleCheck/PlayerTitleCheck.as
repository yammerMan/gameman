package roma.logic.rule.ruleCheck
{
	import roma.logic.GameContext;
	import roma.util.MultiLang;
	
	public class PlayerTitleCheck extends BaseCheck
	{
		
		public function PlayerTitleCheck()
		{
			super();
			this.dispName
		}
		
		override public function check():void {
			var titleId:int = GameContext.instance.getPlayerObj().getPlayerInfo().title;
			var cityCount:int = GameContext.instance.getPlayerObj().getCityCount();
			this.isMatch = cityCount<=9 && titleId >= cityCount ;
			this.dispCur = MultiLang.getPlayerTitle(titleId);
			this.dispReq = cityCount>=10?MultiLang.msg('player.title.full'):MultiLang.getPlayerTitle(cityCount);
		}
	}
}