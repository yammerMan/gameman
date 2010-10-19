package views.spreadUI.tips
{
	import mx.managers.PopUpManager;
	
	import roma.logic.rule.ItemRule;
	
	import views.MainContainer;

	/**
	 *保证弹出的界面最顶上，所以用 PopUpManager;
	 */	
	public class SpeedUpItemTooltip extends ItemOrigintip
	{
		public static var instance:SpeedUpItemTooltip = new SpeedUpItemTooltip();
		
		public function SpeedUpItemTooltip() {
			super();
		}
		
		public static function show(itemRule:ItemRule):void{
			instance.setRule(itemRule);
			if(instance.isPopUp){
				PopUpManager.bringToFront(instance);
			} else {
				PopUpManager.addPopUp(instance ,MainContainer.instance);
			}
		}
		
		public static function setItemRule(itemRule:ItemRule):void{
			instance.setRule(itemRule);
		}
 	}
}