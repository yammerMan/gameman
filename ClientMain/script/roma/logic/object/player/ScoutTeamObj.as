package roma.logic.object.player
{
	import roma.common.constants.FieldConstant;
	import roma.common.constants.ScoutConstants;
	import roma.common.valueObject.ScoutBean;
	import roma.logic.GameContext;
	import roma.logic.object.castle.CastleObj;
	import roma.logic.object.field.FieldHelper;
	import roma.util.MultiLang;
	
	[Bindable]
	public class ScoutTeamObj
	{
		public var missionStr:String;
		public var belongCastle:String;
		public var target:String;
		public var arriveTimeStr:String;
		public var remainTimeStr:String;
		
		public var bean:ScoutBean;
		
		public function ScoutTeamObj(castle:CastleObj, bean:ScoutBean){
			this.bean = bean;
			this.belongCastle = castle.name + GameContext.getFieldPostionString(castle.idField);
			this.arriveTimeStr = GameContext.toLocalTimeStr(bean.arriveTime);
			this.target = this.getTargetName();
			this.resetRemainTimeStr();
			
			if (bean.mission == ScoutConstants.MISSION_SCOUT) {
				this.missionStr = MultiLang.msg('military.mission.scout');
			} else {
				this.missionStr = MultiLang.msg('military.mission.attack');
			}
		}
		
		public function resetRemainTimeStr():void {
			this.remainTimeStr = GameContext.getRemainTimeStr(this.bean.arriveTime);
		}

		private function getTargetName():String {
			var res:String;
			if (this.bean.targetFieldType == FieldConstant.TYPE_CITY) {
				res = this.bean.targetFieldName;
			} else {
				res = FieldHelper.getFieldName(this.bean.targetFieldType);
			}
			res += GameContext.getFieldPostionString(this.bean.targetFieldId);
			return res;
		}

	}
}