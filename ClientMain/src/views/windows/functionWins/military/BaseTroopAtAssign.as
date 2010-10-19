package views.windows.functionWins.military
{
	import mx.containers.Canvas;
	import mx.controls.Image;
	import mx.logging.ILogger;
	import mx.logging.Log;
	
	import roma.resource.ImgManager;
	
	public class BaseTroopAtAssign extends Canvas
	{
		private static var log:ILogger = Log.getLogger("views.windows.functionWins.military.BaseTroopAtAssign");
		private var stopIcon:Image=new Image();
		protected var canEnter:Boolean;
		
		public function BaseTroopAtAssign()
		{
			this.width = 72;
			this.height = 39;
			this.styleName = "heroArmyBG";
			this.stopIcon.source=ImgManager.clazz("background.troopStopBg");
			this.stopIcon.x=14;
			this.stopIcon.y=14;
			this.stopIcon.visible=false;
			this.addChild(this.stopIcon);
						
		}
		
		/**
		 * 需要覆盖的方法
		 */
		public function isCanDrag():Boolean {
			return false;
		} 

		/**
		 * 需要覆盖的方法
		 */
		protected function dropHandler():void {
		}

		/**
		 * 需要覆盖的方法
		 */
		protected function isCanEnter(obj:BaseTroopAtAssign):Boolean {
			return true;
		}

		public function onStartDrag(obj:BaseTroopAtAssign):void {
			this.canEnter = isCanEnter(obj);
			if (!this.canEnter) {
				this.stopIcon.visible=true;
				this.setChildIndex(this.stopIcon,this.getChildren().length-1);
			}
			this.mouseChildren=this.canEnter;
			this.mouseEnabled=this.canEnter;
			this.mouseFocusEnabled=this.canEnter;
		}
		
		public function isHitTest(drag:DragUIComponent):Boolean{
			if(this.hitTestObject(drag) && this.isCanEnter(drag.getTroopAttssign()) && (this.x -this.width/2)<drag.x && drag.x <(this.x+this.width/2) && (this.y-this.height/2+10)< drag.y && drag.y <(this.y+this.height/2)){
				return true;
			}
			return false;
		}

		public function onDragComplete(drag:DragUIComponent):void {
			this.mouseChildren=true;
			this.mouseEnabled=true;
			this.mouseFocusEnabled=true;
			this.stopIcon.visible=false;
			
			if(this.hitTestObject(drag) && (this.x -this.width/2)<drag.x && drag.x <(this.x+this.width/2) && (this.y-this.height/2+10)< drag.y && drag.y <(this.y+this.height/2)){
				var canEnter:Boolean = this.isCanEnter(drag.getTroopAttssign());
				if(canEnter){
					this.dropHandler();
				}
				drag.setCoordinate(this);
			}
		}
	}
}