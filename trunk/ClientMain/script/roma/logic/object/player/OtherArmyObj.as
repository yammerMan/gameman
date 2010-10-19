package roma.logic.object.player
{
	import roma.common.constants.BattleConstants;
	import roma.common.constants.FieldConstant;
	import roma.common.constants.HeroManConstants;
	import roma.common.valueObject.HeroInfoBean;
	import roma.common.valueObject.HeroTroopBean;
	import roma.common.valueObject.OtherArmyBean;
	import roma.logic.GameContext;
	import roma.logic.object.field.FieldHelper;
	import roma.logic.rule.GameRuleHelper;
	import roma.logic.rule.TroopRule;
	import roma.util.MultiLang;
	
	[Bindable]
	public class OtherArmyObj
	{
		private var isEnemy:Boolean = false;
		private var viewLevel:int; 
		
		public var bean:OtherArmyBean
		
		public var heroManId:int; 
		
		public var belongCastle:String;
		public var arriveTimeStr:String;
		public var remainTimeStr:String;

		public var curAction:String;
		
		public var target:String;
		public var misstionStr:String;
		
		public var heroInfoBean:HeroInfoBean;
		public var leagueName:String;
		public var king:String;
		
		public function OtherArmyObj(bean:OtherArmyBean){
			this.bean = bean;
			this.heroManId = bean.heroInfo.id;
			this.heroInfoBean=bean.heroInfo;
			this.leagueName=bean.leagueName;
			this.king=bean.king;
		}
		
		public function update(bean:OtherArmyBean):void {
			//TODO 
			this.bean = bean;			
		}
		
		/**
		 * 获得盟军的状态
		 */
		public function resetForAlliance():void {
			this.isEnemy = false;
			
			this.belongCastle = bean.castleName + GameContext.getFieldPostionString(bean.castleFieldId);
			this.curAction = this.getCurAction();
			this.arriveTimeStr = GameContext.toLocalTimeStr(bean.arriveTime);
			this.resetRemainTimeStr();
		}

		/**
		 * 获得剩余时间的字符串
		 */
		public function resetRemainTimeStr():void {
			this.remainTimeStr = GameContext.getRemainTimeStr(this.bean.arriveTime);
		}

		public function refresh():void {
			if (this.isEnemy) {
				
			} else {
				this.curAction = this.getCurAction();
			}
		}
		
		/**
		 * 当前英雄状态
		 */ 
		public function getheroStatus():String {
			switch(bean.status){
				case HeroManConstants.STATUS_GUARD:
					return MultiLang.msg("info.status.guard");
				case HeroManConstants.STATUS_SEIZED:
					return MultiLang.msg("info.status.seized");
				case HeroManConstants.STATUS_BACKWARD:
					return MultiLang.msg("info.status.backward");
	 			case HeroManConstants.STATUS_FORWARD:
					return MultiLang.msg("info.status.forward");
				case HeroManConstants.STATUS_GROWTH:
					return MultiLang.msg('hero.temper.btnLabel');
				case HeroManConstants.STATUS_IN_BATTLE_FIELD:
					return MultiLang.msg('info.status.battle');
				default:
					return "doing nothing";
			}
	   }

		/**
		 * 设置英雄当前行为
		 */
		private function getCurAction():String {
			switch (bean.status) {
				case HeroManConstants.STATUS_FORWARD:
					return MultiLang.msg("hero.action.forwardTo{0}" , this.getTargetName());
				case HeroManConstants.STATUS_GUARD:
					return MultiLang.msg("hero.action.guardAt{0}" , this.getTargetName());
				case HeroManConstants.STATUS_IN_BATTLE_FIELD:
					return MultiLang.msg("hero.action.forwardTo{0}" , this.getTargetName());
			}
			return "";
		}

		/**
		 * 获得目的地的名字，如果是城堡就返回城堡名，否则就返回地形名
		 */
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
		

		/**
		 * 按照当前的集结地的级别生成军队信息
		 */
		public function resetForEnemy(level:int):void {
			this.isEnemy = true;
			this.viewLevel = level;
			
			// TODO 临时代码，不管集结点的级别，显示敌人的信息 
			this.belongCastle = bean.castleName + GameContext.getFieldPostionString(bean.castleFieldId);
			this.arriveTimeStr = GameContext.toLocalTimeStr(bean.arriveTime);
			this.resetRemainTimeStr();
			this.target = this.getTargetName();
			
			if (bean.mission == BattleConstants.ARMY_MISSION_ATTACK){
				this.misstionStr = MultiLang.msg("military.mission.attack");
			} else {
				this.misstionStr = MultiLang.msg("military.mission.loot");
			}
		}
		
		/**
		 * 计算军队的军力（消耗的统帅力）
		 */
		public function calcTroopStrength():int {
			var total:int = 0;
			for (var i:int=0; i<bean.troopsArray.length; i++) {
				var b:HeroTroopBean = HeroTroopBean(bean.troopsArray[i]);
				if (b!=null && b.count>0) {
					var rule:TroopRule = GameRuleHelper.instance.getTroopRule(b.troopType);
					total += rule.population * b.count;
				}
			}
			return total;
		} 
		
	}
}