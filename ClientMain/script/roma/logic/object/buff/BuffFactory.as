package roma.logic.object.buff
{
	import roma.common.constants.BuffConstants;
	import roma.logic.object.buff.impl.CastleAdvMoveBuff;
	import roma.logic.object.buff.impl.CastleAntiBeConquestPeriodBuff;
	import roma.logic.object.buff.impl.CastleComfortingCoolDownBuff;
	import roma.logic.object.buff.impl.CastleConstructingBuff;
	import roma.logic.object.buff.impl.CastleLevyCoolDownBuff;
	import roma.logic.object.buff.impl.CastleMoveCooldownBuff;
	import roma.logic.object.buff.impl.CastleProcessBuff;
	import roma.logic.object.buff.impl.CastleTaxModifyCoolDownBuff;
	import roma.logic.object.buff.impl.FootBallFieldBuff;
	import roma.logic.object.buff.impl.HeroAwardCoolDownBuff;
	import roma.logic.object.buff.impl.HeroIncAttackBuff;
	import roma.logic.object.buff.impl.HeroIncIntelligenceBuff;
	import roma.logic.object.buff.impl.HeroIncLeaderShip;
	import roma.logic.object.buff.impl.HeroIncPoliticsBuff;
	import roma.logic.object.buff.impl.PlayerBeginnerBuff;
	import roma.logic.object.buff.impl.PlayerIncArmyAttackBuff;
	import roma.logic.object.buff.impl.PlayerIncArmyDefenceBuff;
	import roma.logic.object.buff.impl.PlayerIncFoodProduceBuff;
	import roma.logic.object.buff.impl.PlayerIncGoldProduceBuff;
	import roma.logic.object.buff.impl.PlayerIncGrowingHeroCountBuff;
	import roma.logic.object.buff.impl.PlayerIncIronProduceBuff;
	import roma.logic.object.buff.impl.PlayerIncStoneProduceBuff;
	import roma.logic.object.buff.impl.PlayerIncWoodProduceBuff;
	import roma.logic.object.buff.impl.PlayerKeepSilenceBuff;
	import roma.logic.object.buff.impl.PlayerPeaceBuff;
	import roma.logic.object.buff.impl.PlayerPeaceCooldownBuff;
	import roma.logic.object.buff.impl.PlayerTroopReliveBuff;
	import roma.logic.object.buff.impl.TheWorldCupFlagBuff;
	
	public class BuffFactory
	{
		public static var instance:BuffFactory = new BuffFactory();
		
		public function BuffFactory()
		{
		}
		
		public static function newInstance(typeId:int):BaseBuffObj {
			var res:BaseBuffObj;
			switch (typeId) {
				case BuffConstants.HERO_AWARD_COOL_DOWN :
					res = new HeroAwardCoolDownBuff();
					break;
				case BuffConstants.HERO_INC_ATTACK :
					res = new HeroIncAttackBuff();
					break;
				case BuffConstants.HERO_INC_INTELLIGENCE :
					res = new HeroIncIntelligenceBuff();
					break;
				case BuffConstants.HERO_INC_POLITICS :
					res = new HeroIncPoliticsBuff();
					break;
				case BuffConstants.HERO_INC_LEADERSHIP:
					res = new HeroIncLeaderShip();
					break;
				case BuffConstants.PLAYER_BEGINNER :
					res = new PlayerBeginnerBuff();
					break;
				case BuffConstants.PLAYER_INC_ARMY_ATTACK :
					res = new PlayerIncArmyAttackBuff();
					break;
				case BuffConstants.PLAYER_INC_ARMY_DEFENCE :
					res = new PlayerIncArmyDefenceBuff();
					break;
				case BuffConstants.PLAYER_INC_FOOD_PRODUCE :
					res = new PlayerIncFoodProduceBuff();
					break;
				case BuffConstants.PLAYER_INC_GOLD_PRODUCE :
					res = new PlayerIncGoldProduceBuff();
					break;
				case BuffConstants.PLAYER_INC_IRON_PRODUCE :
					res = new PlayerIncIronProduceBuff();
					break;
				case BuffConstants.PLAYER_INC_STONE_PRODUCE :
					res = new PlayerIncStoneProduceBuff();
					break;
				case BuffConstants.PLAYER_INC_WOOD_PRODUCE :
					res = new PlayerIncWoodProduceBuff();
					break;
				case BuffConstants.PLAYER_KEEP_SILENCE :
					res = new PlayerKeepSilenceBuff();
					break;
				case BuffConstants.PLAYER_PEACE :
					res = new PlayerPeaceBuff();
					break;
				case BuffConstants.PLAYER_PEACE_COOLDOWN :
					res = new PlayerPeaceCooldownBuff();
					break;
				case BuffConstants.PLAYER_TROOP_RELIVE :
					res = new PlayerTroopReliveBuff();
					break;
				case BuffConstants.CASTLE_ADV_MOVE :
					res = new CastleAdvMoveBuff();
					break;
				case BuffConstants.CASTLE_COMFORTING_COOL_DOWN :
					res = new CastleComfortingCoolDownBuff();
					break;
				case BuffConstants.CASTLE_LEVY_COOL_DOWN :
					res = new CastleLevyCoolDownBuff();
					break;
				case BuffConstants.CASTLE_MOVE_COOLDOWN :
					res = new CastleMoveCooldownBuff();
					break;
				case BuffConstants.CASTLE_CONSTRUCTING :
					res = new CastleConstructingBuff();
					break;
				case BuffConstants.PLAYER_INCREASE_CONSTRUCT_LIMIT:
					res = new CastleProcessBuff();
					break;
				case BuffConstants.PLAYER_INC_GROWING_HERO_COUNT:
					res = new PlayerIncGrowingHeroCountBuff();
					break;
				case BuffConstants.CASTLE_ANTI_BE_CONQUSET_PERIOD_BUFF:
					res = new CastleAntiBeConquestPeriodBuff();
					break;
				
				case BuffConstants.TAX_MODIFY_COOL_DOWN:
					res = new CastleTaxModifyCoolDownBuff();
					break;
					
				default:
					if(typeId>=101&&typeId<=142){
						res = new TheWorldCupFlagBuff(typeId);
					}
					if(typeId>=201&&typeId<=204){
						res = new FootBallFieldBuff(typeId);
					}
					
					
			}
			return res;
		}
		
	}
}