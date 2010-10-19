package views.spreadUI.popups
{
	import mx.containers.Canvas;
	
	import views.spreadUI.chat.ChatPopupBox;
	import views.windows.functionWins.alliance.AgreeOrNotPopupBox;
	import views.windows.functionWins.friendly.FriendsPopupBox;
	
	public class PopupContainer extends Canvas
	{
		public static var instance:PopupContainer = new PopupContainer();
		
		public var marketPosition:MarketPosition = new MarketPosition();
		public var chatPopupBox:ChatPopupBox = new ChatPopupBox();
		public var friendsPopupBox:FriendsPopupBox = new FriendsPopupBox();
		public var agreeOrNotPopupBox:AgreeOrNotPopupBox=new AgreeOrNotPopupBox();
		
		public function PopupContainer()
		{
			super();
			this.addPopupView(marketPosition);
			this.addPopupView(chatPopupBox);
			this.addPopupView(friendsPopupBox);
			this.addPopupView(agreeOrNotPopupBox);
		}

		private function addPopupView(v:BasePopup):void{
			this.addChild(v);
			v.visible = false;
		}
	}
}