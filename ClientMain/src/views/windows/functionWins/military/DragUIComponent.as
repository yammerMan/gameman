package views.windows.functionWins.military
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import mx.core.UIComponent;
	import roma.resource.ImgManager;
	import views.spreadUI.tips.ArmyTooltip;
	import views.spreadUI.tips.ToolTipContainer;

	public class DragUIComponent extends UIComponent
	{

		private var _isCanDrag:Boolean;
		private var _isDraging:Boolean = false;
		
		private var _bitMap:Bitmap;
		private var _troopAtAssign:BaseTroopAtAssign;
		private var _armyTooltip:ArmyTooltip = ToolTipContainer.instance.armyTooltip;
		
		public function DragUIComponent()
		{
			super();
		
			this.addChild(this.getDragSprite());
			this.addbitMap();
			
			this.addEventListener(MouseEvent.MOUSE_DOWN,mouseDownHandler);
			this.addEventListener(MouseEvent.MOUSE_UP,mouseUpHandler);
			this.addEventListener(MouseEvent.MOUSE_OVER,mouseOverHandler);
			this.addEventListener(MouseEvent.MOUSE_OUT,mouseOutHandler);
			this.addEventListener(MouseEvent.MOUSE_MOVE,mouseMoveHandler);			
		}
		
		private function addbitMap():void{
			var cl:Class = ImgManager.clazz("troopType.notCompliant");
			_bitMap = new cl as Bitmap;
			_bitMap.width =15;
			_bitMap.height = 15;
			_bitMap.x = 0;
			_bitMap.y = 0;
			_bitMap.alpha = 0.8;
			_bitMap.visible = false;
			this.addChild(_bitMap);
		}
		
		private function mouseDownHandler(event:MouseEvent):void{
			if(_troopAtAssign.isCanDrag()){
				this.startDrag();
				this.alpha =1.0;

				_isDraging = true;

				AssignHelper.instance.startDrag(_troopAtAssign);
				
				this.addEventListener(Event.ENTER_FRAME,enterFrameHandler);
			}
		}
		
		private function mouseUpHandler(event:MouseEvent):void{
			if(this.hasEventListener(Event.ENTER_FRAME)){
				this.removeEventListener(Event.ENTER_FRAME,enterFrameHandler);
			}

			if(_troopAtAssign.isCanDrag()){
				this.stopDrag();
				this.alpha = 0.0;
	
				_isDraging = false;
	
				AssignHelper.instance.dragComplete(this);

				setCoordinate(_troopAtAssign);
			}
		}
		
		private function enterFrameHandler(event:Event):void{
			_bitMap.visible = true;
			if(AssignHelper.instance.isDragCanEnter(this)){
				_bitMap.visible = false;
			}	
		}
		
		private function mouseOverHandler(event:MouseEvent):void{
			if(_troopAtAssign is TroopInHero && !_troopAtAssign.isCanDrag()){
				return;
			}
			
			var type:int;
			var count:int;
			if(_troopAtAssign is TroopInCastle){
				count =TroopInCastle(_troopAtAssign).value.value;
				type = TroopInCastle(_troopAtAssign).value.typeId;
			}else{
				count = TroopInHero(_troopAtAssign).value.count;
				type = TroopInHero(_troopAtAssign).value.troopType;
				if(count <=0) return;
			}
			
			_armyTooltip.setTroopType(type);
			_armyTooltip.onMouseOver(event);
		}
		
		private function mouseOutHandler(event:MouseEvent):void{
			if(_armyTooltip.getVisible()){
				_armyTooltip.onMouseOut();
			}
		}
		
		private function mouseMoveHandler(event:MouseEvent):void{
			if(_armyTooltip.getVisible()){
				_armyTooltip.onMouseMove(event);
			}
		}
		
		public function setTroopAttssign(troopUi:BaseTroopAtAssign):void{
			this.alpha = 0.0;
			_troopAtAssign = troopUi;
			setCoordinate(_troopAtAssign);
		}
		
		public function getTroopAttssign():BaseTroopAtAssign{
			return _troopAtAssign;
		}
		
		public function isDraging():Boolean{
			return _isDraging;
		}		
		
		public function  setCoordinate(ui:BaseTroopAtAssign):void{
			this.x = ui.x +(ui.width-58)/2;
			this.y = ui.y +(ui.height-26)/2;
		}

		private function getDragSprite():Sprite{
			var sp:Sprite = new Sprite();
			sp.graphics.beginFill(0xffff00,0.5);
			sp.graphics.drawRect(0,0,58,26);
			sp.graphics.endFill();
			return sp;			
		}
	}
}