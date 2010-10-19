package roma.war.resource
{
	import mx.resources.ResourceManager;
	import mx.utils.StringUtil;
	
	public class BaseLang
	{
		protected function getBunlderName():String {
			return "replay";
		}
		
		public function msg(key:String,paramArray:Array):String{
			var value:String = ResourceManager.getInstance().getString(getBunlderName(), key);
			if (value==null) {
				value = "!!!!" + key;
			} 

			if (paramArray==null || paramArray.length==0) {
				return StringUtil.trim(value);
			} else {
				var str:String = StringUtil.substitute(value,paramArray);
				return StringUtil.trim(str);
			}
		}
	}
}