package roma.logic.rule
{
	import roma.common.constants.GeneralConstants;
	import roma.logic.object.building.BaseBuilding;
	import roma.logic.rule.ruleCheck.PlayerTitleCheck;
	import roma.logic.rule.ruleCheck.RuleCheckResult;
	
	public class NewCastleRule extends BaseRule
	{

		public var playerTitleCheck:PlayerTitleCheck = new PlayerTitleCheck();

		public function NewCastleRule()
		{
			super(GeneralConstants.CASTLE_CONSTRUCTING_FOOD,
				GeneralConstants.CASTLE_CONSTRUCTING_WOOD,
				GeneralConstants.CASTLE_CONSTRUCTING_GOLD,
				GeneralConstants.CASTLE_CONSTRUCTING_IRON,
				GeneralConstants.CASTLE_CONSTRUCTING_STONE,
				GeneralConstants.CASTLE_CONSTRUCTING_TIME*60);
		}

		override public function check(buildingObj:BaseBuilding=null):RuleCheckResult {
			var res:RuleCheckResult = super.check();
			res.addExtendCheck(this.playerTitleCheck);
			return res;
		}
	}
}