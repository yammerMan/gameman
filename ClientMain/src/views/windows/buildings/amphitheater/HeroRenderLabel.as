package views.windows.buildings.amphitheater
{
	import mx.controls.Label;
	
	import roma.common.constants.HeroManConstants;
	import roma.common.constants.HeroGrowthConstant;
	import roma.util.MultiLang;

	public class HeroRenderLabel extends Label
	{
		public function HeroRenderLabel()
		{
			super();
		}
		
		public function set temperType(t:int):void{
			var str:String = "";
			switch(t){
				case HeroGrowthConstant.HERO_GROWTH_TYPE_FIGHTING:
					str = MultiLang.msg('hero.temper.temperDesc.fightLabel');
				break;
				case HeroGrowthConstant.HERO_GROWTH_TYPE_INSPECTING:
					str = MultiLang.msg('hero.temper.temperDesc.patrolLabel');
				break;
				case HeroGrowthConstant.HERO_GROWTH_TYPE_READING:
					str = MultiLang.msg('hero.temper.temperDesc.readLabel');
				break;
				case HeroGrowthConstant.HERO_GROWTH_TYPE_SCOUTING:
					str = MultiLang.msg('hero.temper.temperDesc.enterRearLabel');
				break;
				case HeroGrowthConstant.HERO_GROWTH_TYPE_TREASURING:
					str = MultiLang.msg('hero.temper.temperDesc.treasureHuntLabel');
				break;
				case HeroGrowthConstant.HERO_GROWTH_TYPE_VISITING:
					str = MultiLang.msg('hero.temper.temperDesc.interviewLabel');
				break;
				default:
					str = MultiLang.msg('chatType.none');
			}
			this.text = str;
		}
		
		public function set tStyle(isTrue:Boolean):void{
			if(isTrue){
				this.styleName = "chatUnionPlayer";
			}
			else{
				this.styleName = "";
			}
		}
/* 		public function set statusText(t:int):void {	
			var str:String = "";	
			switch(t){
				case HeroManConstants.STATUS_CHIEF:
					str=Lang.msg("player.title.8");
					break;
				case HeroManConstants.STATUS_FREE:
					str=Lang.msg("info.status.free");
					break;
				case HeroManConstants.STATUS_GUARD:
					str=Lang.msg("info.status.guard");
					break;
				case HeroManConstants.STATUS_SEIZED:
					str=Lang.msg("info.status.seized");
					break;
				case HeroManConstants.STATUS_BACKWARD:
					str=Lang.msg("info.status.backward");
					break;
	 			case HeroManConstants.STATUS_FORWARD:
					str=Lang.msg("info.status.forward");
					break;
				case HeroManConstants.STATUS_IN_BATTLE:
					str=Lang.msg("info.status.battle");
					break 
				case HeroManConstants.STATUS_GROWTH:
					str = Lang.msg('hero.temper.btnLabel');
					break;
			}
			this.text = str;
	   } */
	   
	}
}