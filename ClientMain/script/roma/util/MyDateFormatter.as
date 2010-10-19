package roma.util
{
	import mx.formatters.DateFormatter;

	public class MyDateFormatter extends DateFormatter
	{
		public function MyDateFormatter()
		{
			super();
			this.formatString = MultiLang.msg("date.format");
		}
		
		public static function parseDateString1(str:String):Date {
			return DateFormatter.parseDateString(str);
		}
	}
}