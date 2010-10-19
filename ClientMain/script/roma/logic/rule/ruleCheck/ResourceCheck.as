package roma.logic.rule.ruleCheck
{
	import roma.logic.GameContext;
	import roma.logic.RomaConstants;
	import roma.logic.object.castle.CastleResourceManager;
	import roma.util.MultiLang;
	
	[Bindable]
	public class ResourceCheck extends BaseCheck
	{
		public var type:int;
		public var reqNum:int;
		
		public function ResourceCheck($reqNum:int, $type:int) {
			super($reqNum);
			this.reqNum = $reqNum;
			this.type = $type;
			
			this.dispCur = "0";
			this.dispReq = String($reqNum);
			
			switch(type) {
				case RomaConstants.RES_TYPE_FOOD:
					this.dispName = MultiLang.msg("label.food");
					break;
				case RomaConstants.RES_TYPE_GOLD:
					this.dispName = MultiLang.msg("label.gold");
					break;
				case RomaConstants.RES_TYPE_WOOD:
					this.dispName = MultiLang.msg("label.wood");
					break;
				case RomaConstants.RES_TYPE_STONE:
					this.dispName = MultiLang.msg("label.stone");
					break;
				case RomaConstants.RES_TYPE_IRON:
					this.dispName = MultiLang.msg("label.iron");
					break;
			}
		}
		
		override public function check():void {
			var res:CastleResourceManager = GameContext.instance.getPlayerObj().getCurCastleObj().resourceManager;
			var curNum:int = 0;
			switch(type) {
				case RomaConstants.RES_TYPE_FOOD:
					curNum =res.food.curAmount;
					break;
				case RomaConstants.RES_TYPE_GOLD:
					curNum =res.golds.curAmount;
					break;
				case RomaConstants.RES_TYPE_WOOD:
					curNum =res.wood.curAmount;
					break;
				case RomaConstants.RES_TYPE_STONE:
					curNum =res.stone.curAmount;
					break;
				case RomaConstants.RES_TYPE_IRON:
					curNum =res.iron.curAmount;
					break;
			}
			
			this.isMatch = (this.reqNum <= curNum);
			this.dispCur = String(curNum);			
		}
	}
}