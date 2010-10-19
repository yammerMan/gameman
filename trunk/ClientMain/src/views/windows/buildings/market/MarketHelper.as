package views.windows.buildings.market
{
	import roma.common.constants.ResourceConstant;
	import roma.util.MultiLang;
	
	public class MarketHelper
	{
		public static var instance:MarketHelper=new MarketHelper();
		public function MarketHelper()
		{
		}
		public function getResourceType(type:int):String{
			var typeString:String="";
			switch(type){
				case ResourceConstant.TYPE_FOOD:
					typeString=MultiLang.msg("label.food");
				break;
				case ResourceConstant.TYPE_WOOD:
					typeString=MultiLang.msg("label.wood");
				break;
				case ResourceConstant.RESOURCE_TYPE_STONES:
					typeString=MultiLang.msg("label.stone");
				break;
				case ResourceConstant.TYPE_IRON:
					typeString = MultiLang.msg("label.iron");
				break;
				case ResourceConstant.RESOURCE_TYPE_MONEY:
					typeString = MultiLang.msg("label.gold");
				break;
				default:
			}
			return typeString;
		}

	}
}