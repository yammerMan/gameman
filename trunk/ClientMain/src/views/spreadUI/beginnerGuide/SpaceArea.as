package views.spreadUI.beginnerGuide
{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	import mx.core.UIComponent;
	
	import roma.resource.ImgManager;

	public class SpaceArea extends UIComponent
	{
		public var fun:Function;
		public var step:int;
		
		public function SpaceArea()
		{
			super();
			
			this.buttonMode = true;
			this.useHandCursor = true;
			this.addEventListener(MouseEvent.MOUSE_DOWN,clickHandler);
			
			addSpMc();
		}
		
		private var mc:MovieClip;
		private function addSpMc():void{
			var cl:Class = ImgManager.clazz("space.area");
			mc = new cl() as MovieClip;
			this.addChild(mc);
		}
		
		private function clickHandler(event:MouseEvent):void{
			this.visible = false;
			
			if(fun !=null)
				fun.apply(this,[step]);
		}
		
		public function setPosition(px:int,py:int):void{
			this.x = px;
			this.y = py;	
		}
		
		public function setSize(w:int,h:int):void{
			this.mc.width =w;
			this.mc.height = h;
		}
	}
}