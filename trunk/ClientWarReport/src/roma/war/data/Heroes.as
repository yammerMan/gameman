package roma.war.data
{
	import mx.collections.ArrayCollection;
	
	public class Heroes
	{
		
		public function Heroes()
		{
			items = new Array();
		}
		
		public var items:Array;
		
		public function addHero(hn:HeroNode):HeroNode{
			items[hn.key] = hn;
			return hn;
		}
	}
}