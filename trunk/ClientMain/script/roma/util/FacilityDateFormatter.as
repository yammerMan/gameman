package roma.util
{
	import mx.formatters.DateFormatter;
	
	public class FacilityDateFormatter extends DateFormatter
	{
		public function FacilityDateFormatter()
		{
			super();
			this.formatString = MultiLang.msg("date.facility.format");
		}

	}
}