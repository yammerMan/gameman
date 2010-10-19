package views.spreadUI.tips
{
	import mx.controls.Label;

	public class ConditionColorLabel extends Label
	{
		public function ConditionColorLabel()
		{
			super();
		}
		
		public function set isMatch(match:Boolean):void {
			if (match) {
				this.setStyle("color", "#000000");
			} else {
				this.setStyle("color", "#ff0000");
			}
		}
	}
}