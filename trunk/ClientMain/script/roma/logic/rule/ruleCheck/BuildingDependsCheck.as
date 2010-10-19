package roma.logic.rule.ruleCheck
{
	import roma.common.constants.BuildingConstant;
	import roma.logic.GameContext;
	import roma.logic.object.building.BaseBuilding;
	import roma.logic.object.building.BuildingHelper;
	import roma.logic.object.castle.CastleBuildingManager;
	import roma.util.MultiLang;
	
	[Bindable]
	public class BuildingDependsCheck extends BaseCheck
	{
		public var type:int;
		public var reqLevel:int;
		
		public function BuildingDependsCheck(type:int ,reqLevel:int )
		{
			super(reqLevel);
			this.type = type;
			this.reqLevel = reqLevel;
			this.dispName = MultiLang.msg("condition.building");
			this.dispReq =  BuildingHelper.instance.getName(type) + " " + MultiLang.msg("public.label.level") +" "+ this.reqLevel;
		}
		
		override public function check():void {
			var bm:CastleBuildingManager = GameContext.instance.getPlayerObj().getCurCastleObj().buildingManager;
			var curlevel:int = 0;
			if (this.type == BuildingConstant.TYPE_WALL_BUILDING) {
				//如果是城墙
				if (bm.getWall()!=null) {
					curlevel = bm.getWall().level;
				}						
			} else if (this.type == BuildingConstant.TYPE_TOWN_HALLS) {
				//如果是官府
				curlevel = bm.getTownHall().level;
			} else {
				var buildingObj:BaseBuilding = bm.getUniqueBuildingByType(this.type);
				if (buildingObj!=null) {
					//如果是唯一性建筑
					curlevel = buildingObj.level;
				} else {
					var array:Array = bm.getMultipleBuildingArrayByType(this.type);
					if (array!=null && array.length >0) {
						//如果是可重复的建筑
						for each(var bo:BaseBuilding in array) {
							if (curlevel < bo.level) {
								curlevel = bo.level;
							}
						}
					}
				}
			}
			
			this.isMatch = (curlevel >= this.reqLevel);
			this.dispCur = MultiLang.msg("public.label.level") +" "+ curlevel;
		}
	}
}