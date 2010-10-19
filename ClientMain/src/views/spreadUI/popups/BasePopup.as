package views.spreadUI.popups
{
	import mx.containers.Canvas;

	public class BasePopup extends Canvas
	{
		public function BasePopup()
		{
			super();
		}
		
		public function refresh():void{
		}
		
		public function setPos(posX:int,posY:int):void{
			this.x = posX;
			this.y = posY;
			this.refresh();
		}
	}
}