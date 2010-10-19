package roma.util
{
	import flash.display.DisplayObject;
	
	import mx.core.Application;
	import mx.core.IFlexDisplayObject;
	import mx.core.UIComponent;
	import mx.managers.PopUpManager;
	
	public class PopupWinManager
	{
		public static var instance:PopupWinManager = new PopupWinManager();

		private var curPopupObject:IFlexDisplayObject = null;

		public function addPopup(windowObject:IFlexDisplayObject, modal:Boolean=true, parent:DisplayObject=null):void{
            if ( curPopupObject!=null ) {
            	PopUpManager.removePopUp(curPopupObject);
            }
            
            if (parent == null) {
            	parent = UIComponent(Application.application);
            }
            
            if (!UIComponent(windowObject).isPopUp){
				PopUpManager.addPopUp(windowObject,parent,modal);
            }else {
			    PopUpManager.bringToFront(windowObject);                    
			}
			
			PopUpManager.centerPopUp(windowObject);
			 
			this.curPopupObject = windowObject;
		}
		
		public function removePopup(popup:IFlexDisplayObject = null):void {
			if (popup!=null) {
				PopUpManager.removePopUp(popup);
				if (popup == this.curPopupObject) {
					this.curPopupObject == null;
				}
			} else if (curPopupObject){
				PopUpManager.removePopUp(this.curPopupObject);
			}
		}

		public function centerPopUp():void{
			PopUpManager.centerPopUp(curPopupObject);
		}
	}
}