package views.windows.buildings.amphitheater
{
	import roma.common.valueObject.HeroInfoBean;
	
	public class HeroInfoBeanInOrder extends HeroInfoBean
	{
		public var order:int=0;
		public function HeroInfoBeanInOrder(hero:HeroInfoBean)
		{
			super(hero);
		}

	}
}