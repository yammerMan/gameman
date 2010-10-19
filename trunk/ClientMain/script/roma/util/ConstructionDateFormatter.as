package roma.util
{
	import mx.formatters.DateFormatter;
	public class ConstructionDateFormatter extends DateFormatter
	{
		public function ConstructionDateFormatter()
		{
			super();
			this.formatString = MultiLang.msg("date.Construction.format");
		}

	}
}