package views.mainModules.map
{
	import flash.display.DisplayObjectContainer;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	import mx.controls.Menu;
	import mx.events.MenuEvent;
	
	import roma.logic.GameContext;
	import roma.message.events.FavoriteEvent;
	import roma.util.MultiLang;
	
	import views.mainFrame.ChatPanel;
	import views.mainModules.map.diamond2.DiamondWorldMap2;
	import views.spreadUI.MyAlert;
	import views.spreadUI.favorite.FieldFavorite;
	
	public class MapAddLabelHelper
	{
		public static var instance:MapAddLabelHelper=new MapAddLabelHelper();
		
		private var myMenuData:XML;
			
		private var myMenu:Menu;
						
		private var point1:Point = new Point();	
		
		private var idField:int;	
		private var field_name:String;
			
		public function MapAddLabelHelper()
		{
			creatXml();
		}
		
		private function creatXml():void{
        	var dataString:String="<root>";
        	
        	dataString+="<menuitem label="+"\""+MultiLang.msg("favorite.goto")+"\""+" data="+"\""+"favorite.goto"+"\"/>";
        	
        	
        	dataString+="<menuitem label="+"\""+MultiLang.msg("public.label.sentToChat")+"\""+" data="+"\""+"public.label.sentToChat"+"\"/>";
        	
        	
			dataString+="<menuitem label="+"\""+MultiLang.msg("public.label.favorites")+"\""+" data="+"\""+"public.label.favorites"+"\"/>";
        	
        	dataString+="</root>";
        	myMenuData=XML(dataString);
        }
        
         public function showMenu(containerevent:DisplayObjectContainer,event:MouseEvent,idField:int,field_name:String):void {
			 	
			 	this.idField=idField;
			 	this.field_name=field_name;
                myMenu= Menu.createMenu(containerevent, myMenuData, false);
                myMenu.labelField="@label";
                myMenu.addEventListener("itemClick", menuHandler);
                
                // Calculate position of Menu in Application's coordinates. 
                point1.x=event.currentTarget.mouseX;
                point1.y=event.currentTarget.mouseY;                
                point1=event.currentTarget.localToGlobal(point1);
                myMenu.show(point1.x - 25, point1.y + 25);
		 	
        }
        
          private function menuHandler(event:MenuEvent):void  {
				var str:String=String(event.item.@data);
				switch(str){
					case "favorite.goto"://跳转
						gotoCenterPoint();
					break;
					
					case "public.label.sentToChat"://发送到聊天栏
						ChatPanel.instance.chatTextInput.text="["+GameContext.getFieldPostionX(this.idField)+","+GameContext.getFieldPostionY(this.idField)+"]";
					break;
					
					case "public.label.favorites"://收藏
						addFavorite();
						
					break;
					
					default:
						MyAlert.show(event.item.@data);

				}
          }
          
          private function gotoCenterPoint():void{
				DiamondWorldMap2.instance.goPoint(GameContext.getFieldPostionX(this.idField),GameContext.getFieldPostionY(this.idField));
		  }
		  
		  /**
			 * 增加到收藏夹
			 */
			private function addFavorite():void {
				FieldFavorite.instance.addListener();				
				FavoriteEvent.addFavorite(FieldFavorite.ADD_FAVORITE,this.idField,this.field_name);
			}

	}
}