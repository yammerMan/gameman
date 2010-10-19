package views.windows.functionWins.hero
{
	import mx.controls.Label;
	
	import roma.common.constants.BuffConstants;
	import roma.logic.object.buff.BuffFactory;
	import roma.util.MultiLang;

	public class BuffNameLabel extends Label
	{
		public function BuffNameLabel()
		{
			super();
		}
		
		public function set buffName(id:int):void{
				var str:String = "";
				switch(id){
					case BuffConstants.HERO_AWARD_COOL_DOWN:
						str = MultiLang.msg('buff.moveCity.coolDown');
						break;
					case BuffConstants.HERO_INC_ATTACK:
						str = BuffFactory.newInstance(BuffConstants.HERO_INC_ATTACK).desc;
						break;
					case BuffConstants.HERO_INC_INTELLIGENCE:
						str = BuffFactory.newInstance(BuffConstants.HERO_INC_INTELLIGENCE).desc;
						break;
					case BuffConstants.HERO_INC_POLITICS:
						str = BuffFactory.newInstance(BuffConstants.HERO_INC_POLITICS).desc;
						break;
					case BuffConstants.HERO_INC_LEADERSHIP:
//						str = BuffFactory.newInstance(BuffConstants.HERO_INC_LEADERSHIP).desc;
						str = MultiLang.msg("buff.HeroIncLeaderShip.shortDesc");
						break;
				}
				this.text = str;
		}
		
/* 		public function set statusName(t:int):void{
			switch(t){
				case HeroManConstants.STATUS_CHIEF:
					text = Lang.msg("info.status.chief");
					break;
				case HeroManConstants.STATUS_FREE:
					text = Lang.msg("info.status.free");
					break;
				case HeroManConstants.STATUS_GUARD:
					text = Lang.msg("info.status.guard");
					break;
				case HeroManConstants.STATUS_SEIZED:
					text = Lang.msg("info.status.seized");
					break;
				case HeroManConstants.STATUS_BACKWARD:
					text = Lang.msg("info.status.backward");
					break;
	 			case HeroManConstants.STATUS_FORWARD:
					text = Lang.msg("info.status.forward");
					break;
				case HeroManConstants.STATUS_IN_BATTLE:
					text = Lang.msg("info.status.battle");
					break;
				case HeroManConstants.STATUS_GROWTH:
					text = Lang.msg('hero.temper.btnLabel');
				break;
			}
		} */
		
	}
}