package views.spreadUI.troop
{
	import mx.controls.Label;
	
	import roma.util.FiltersUtil;
	
	public class TroopCountLabel extends Label
	{
		public function TroopCountLabel()
		{
			super();
		}
		override public function set text(value:String):void{
			super.text=value;
			super.filters=[FiltersUtil.glowFilter];
			if(int(value)<1000){
				this.styleName="soldier1000Lable";
				return;
			}
			if(int(value)<10000){
				this.styleName="soldier10000Lable";
				return;
			}
			if(int(value)<100000){
				this.styleName="soldier100000Lable";
				return;
			}
			if(int(value)>=100000){
				this.styleName="soldierMaxLable";
				return;
			}
		}
	}
}