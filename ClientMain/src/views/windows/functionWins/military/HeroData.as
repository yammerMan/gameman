package views.windows.functionWins.military
{
	import roma.logic.object.hero.HeroObj;
	
	public class HeroData
	{
		public var isFromHero:Boolean;
		public var heroObj:HeroObj;
		
		public function HeroData(hero:HeroObj,bl:Boolean)
		{
			this.heroObj = hero;
			this.isFromHero =bl;
		}

	}
}