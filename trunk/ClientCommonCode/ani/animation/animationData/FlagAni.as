package animation.animationData
{
	import animation.BaseAnimationData;
	import animation.animationData.flag.EnemyFlagAniData;
	import animation.animationData.flag.FriendFlagAniData;
	import animation.animationData.flag.NeutralFlagAniData;
	import animation.animationData.flag.NpcFlagAniData;
	import animation.animationData.flag.SameAllianceFlagAniData;
	import animation.animationData.flag.SelfFlagAniData;
	
	import roma.common.constants.AllianceConstant;
	
	public class FlagAni
	{
		public function getFlagAniByRelation(relation:int):BaseAnimationData {
			switch (relation) {
				case AllianceConstant.ALLIANCE_RELATION_HOSTILE:
					return this.enemyFlag;
				case AllianceConstant.ALLIANCE_RELATION_FRIENDLY:
					return this.friendFlag;
				case AllianceConstant.ALLIANCE_RELATION_SAME:
					return this.sameAllianceFlag;
				case AllianceConstant.ALLIANCE_RELATION_NEUTRAL:
					return this.neutralFlag;
				default:
					return this.selfFlag;
			}
		}
		
		/** npc 城的旗号 **/
		private var _npcFlag:NpcFlagAniData;
		public function get npcFlag():NpcFlagAniData{
			if(_npcFlag == null)
				_npcFlag = new NpcFlagAniData();
			return _npcFlag;
		}
		
		/** 中立的旗号 **/
		private var _neutralFlag:NeutralFlagAniData;
		public function get neutralFlag():NeutralFlagAniData{
			if(_neutralFlag == null)
				_neutralFlag = new NeutralFlagAniData();
			return _neutralFlag;
		}

		/** 敌盟的旗号 **/
		private var _enemyFlag:EnemyFlagAniData;
		public function get enemyFlag():EnemyFlagAniData{
			if(_enemyFlag == null)
				_enemyFlag = new EnemyFlagAniData();
			return _enemyFlag;
		}

		/** 友盟的旗号 **/
		private var _friendFlag:FriendFlagAniData;
		public function get friendFlag():FriendFlagAniData{
			if(_friendFlag == null)
				_friendFlag = new FriendFlagAniData();
			return _friendFlag;
		}
		
		/** 同盟的旗号 **/
		private var _sameAllianceFlag:SameAllianceFlagAniData;
		public function get sameAllianceFlag():SameAllianceFlagAniData{
			if(_sameAllianceFlag == null)
				_sameAllianceFlag = new SameAllianceFlagAniData();
			return _sameAllianceFlag;
		}
		
		/** 自己的旗号 **/
		private var _selfFlag:SelfFlagAniData;
		public function get selfFlag():SelfFlagAniData{
			if(_selfFlag == null)
				_selfFlag = new SelfFlagAniData();
			return _selfFlag;
		}
		
	}
}