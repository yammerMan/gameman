package roma.war.resource
{
	import mx.resources.ResourceBundle;
	import mx.resources.ResourceManager;
	import mx.utils.StringUtil;
	
	public class LanguageResource
	{
		
		public function LanguageResource()
		{
		}
		public static function load(obj:Object):void{
			var a:Array = String(obj).split("\r\n");
			ResourceManager.getInstance().localeChain = ["lan"];
			var wareplayLang:ResourceBundle;
			wareplayLang = new ResourceBundle("lan","wareplayLang");
			var str:String = "";
			var s:String = "";
			var arr:Array = new Array();
			for each(s in a){
				str = StringUtil.trim(s);
				if(str.indexOf("=")>-1){
					arr = str.split("=");
					wareplayLang.contents[arr[0]] = arr[1];
				}
			}
			ResourceManager.getInstance().addResourceBundle(wareplayLang); 
		}
		
	}
}