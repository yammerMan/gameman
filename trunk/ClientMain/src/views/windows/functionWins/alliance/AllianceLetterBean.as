package views.windows.functionWins.alliance
{
	import roma.common.valueObject.LetterBean;
	[Bindable]
	public class AllianceLetterBean extends LetterBean
	{
		public var isAttack:Boolean;
		public function AllianceLetterBean(data:Object=null)
		{
			super(data);
		}
	}
}