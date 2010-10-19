package views.windows.buildings.temple
{
	import flash.utils.Dictionary;
	
	import roma.common.constants.TempleConstant;
	import roma.resource.ImgManager;
	import roma.util.MultiLang;
	
	public class TempleHelper
	{
		public static var instance:TempleHelper = new TempleHelper();
		
		private var templeMap:Dictionary = new Dictionary();
		
		public function TempleHelper()
		{
			templeMap[TempleConstant.MARS_GOD]     = "mars";
			templeMap[TempleConstant.JUPITER_GOD]  = "jupiter";
			templeMap[TempleConstant.JUNEAU_GOD]   = "junon";
		}
		
		public function getName(type:int):String{
			var key:String = templeMap[type];
			return MultiLang.msg("temple."+key+".name");
		}
		
		public function getIcon(type:int):String{
			var key:String = templeMap[type];
			return ImgManager.clazz("temple."+key+".icon");
		}
		
		public function getDesc(type:int):String{
			var key:String = templeMap[type];
			return MultiLang.msg("temple."+key+".desc");
		}
		
		public function getSelectedIcon(type:int):String{
			var key:String = templeMap[type];
			return ImgManager.clazz("temple."+key+".selected");
		}
	}
}