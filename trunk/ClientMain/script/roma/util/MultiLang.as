package roma.util
{
	
	import mx.logging.ILogger;
	import mx.logging.Log;
	import mx.resources.ResourceManager;
	import mx.utils.StringUtil;
	
	public class MultiLang{
		
		private static var instance:MultiLang = new MultiLang();
		private static var log:ILogger = Log.getLogger("roma.util.Lang");
		
		public static function msg(key:String, ... arr):String {
			var value:String = ResourceManager.getInstance().getString("lang" , key);
			var s:String="";
			if (value==null) {
				log.error("翻译库找不到键值:" + key);
				value = "!!!!" + key;
			} 

			if (arr==null || arr.length==0) {
				s= StringUtil.trim(value);
			} else {
				var str:String = StringUtil.substitute(value,arr);
				s= StringUtil.trim(str);
			}
			return InputTextHelper.takeOutPunctuation(s);
		}
		
		public static function getEquipString(key:String):String {
			var value:String = ResourceManager.getInstance().getString("equip" , key);
			if (value==null) {
				log.error("翻译库找不到键值:" + key);
			} 
			return value;
		}
		
		public static function getPlayerTitle(id:int):String {
			return msg("player.title." + id);
		}
		
		public static function clazz(key:String):Class {
			var value:Class = ResourceManager.getInstance().getClass("langImg" , key);
			if (value==null) {
				log.error("翻译库找不到键值:" + key);
			} 
			return value;
		}

		/**
		 * 时间长度（秒） 变成 xx天xx日 xx:xx的格式
		 */
		public static function timeFormatToString(t:int):String{
			var str:String = "";
			var d:int = t / (24 * 60 * 60);
			if (d>0) {
				str += d + msg("date.day")+" ";
			}
			
			var h:int = (t / (60*60) )% 24 ;
			if (str.length>0 || h>0) {
				str += h + msg("date.hour")+" ";
			}
			
			var m:int = (t / 60) % 60;
			if (str.length>0 || m>0) {
				str += m + msg("date.min")+" ";
			}
			var s:int = t % 60;
//			if (s<10) {
//				str +="0";
//			}
			str += s + msg("date.sec")
			return str;
		}
		
	}

}