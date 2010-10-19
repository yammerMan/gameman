package roma.war.resource
{
	public class MultiLang
	{
		public static var instance:MultiLang = new MultiLang();
		
		private var curLang:BaseLang = new LangEn();
			
		public function MultiLang()
		{
		}
		
		public function setCurLang(cur:BaseLang):void {
			this.curLang = cur;
		}

		private function _msg(key:String,paramArray:Array):String{
			return this.curLang.msg(key,paramArray	);
		}
		
		public static function msg(key:String,...paramArray):String{
			return instance._msg(key,paramArray);
		}
	}
}