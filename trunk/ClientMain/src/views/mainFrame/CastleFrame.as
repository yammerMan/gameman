package views.mainFrame
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import gs.TweenLite;
	import gs.easing.Back;
	
	import mx.core.UIComponent;
	
	import roma.logic.CaesaryConfig;
	import roma.message.EvtDispacther;
	import roma.resource.ImgManager;
	import roma.util.MultiLang;
	
	import views.mainModules.map.MapMod;
	import views.mainModules.map.smallMap.SmallMap;
	import views.mainModules.town.Town;
	import views.spreadUI.favorite.FieldSkip;
	import views.spreadUI.tips.CommonTooltip;
	import views.spreadUI.tips.ToolTipContainer;
	import views.windows.functionWins.task.TaskWin;
	import views.windows.functionWins.turntable.Turntable;

	public class CastleFrame extends UIComponent
	{
		public static var instance:CastleFrame;

		public var newTaskMc:MovieClip;
		
		private var townMod:Town = new Town();
		private var mapMod:MapMod = new MapMod();
		
		public function CastleFrame() {
			this.graphics.beginFill(0xF8E9C8,1);
			this.graphics.drawRect(0,0,994,400);
			this.graphics.endFill();

			this.addChild(this.townMod);
			this.addChild(this.mapMod);
			
			this.addNewTaskBtn();
			
			this.mapMod.visible = false;
			this.mapMod.alpha = 0;
			
			this.townMod.refresh();
			
			instance = this;
		}
		
		/**
		 * 模块切换
		 */ 
		public function switchModule(toTown:Boolean):void{
			if (toTown) {
				//this.mapMod.visible = false;
				this.mapMod.destroy();
				this.townMod.visible = true;
				this.townMod.refresh();
			} else {
				//this.townMod.visible = false;
				this.townMod.destroy();
				this.mapMod.visible = true;
				this.mapMod.refresh();
				//
				FieldSkip.instance.value = false;
			}
			
			changeAlphaAni(toTown);
		}
		
		private function changeAlphaAni(isTown:Boolean):void{
			if(isTown){
				TweenLite.to(this.mapMod,1.5,{alpha:0,ease:Back.easeOut,onComplete:onTownAlphaComplete});
				TweenLite.to(this.townMod,1.5,{alpha:1,ease:Back.easeOut});
			}else{
				TweenLite.to(this.townMod,1.5,{alpha:0,ease:Back.easeOut,onComplete:onMapAlphaComplete});
				TweenLite.to(this.mapMod,1.5,{alpha:1,ease:Back.easeOut});
			}
		}
		
		private function onTownAlphaComplete():void{
			this.mapMod.alpha =0;
			this.townMod.alpha =1.0;
			this.townMod.visible = true;
			this.mapMod.visible = false;
		}
		
		private function onMapAlphaComplete():void{
			this.townMod.alpha =0;
			this.mapMod.alpha =1.0;
			this.townMod.visible = false;
			this.mapMod.visible = true;
		}
		
		/**
		 *添加新任务按钮 
		 */	
		private function addNewTaskBtn():void{
			var newTaskClass:Class=ImgManager.clazz('task.newTaskButton');
			this.newTaskMc = new newTaskClass() as MovieClip;
			this.newTaskMc.buttonMode=true;
			this.newTaskMc.useHandCursor=true;
			this.newTaskMc.gotoAndStop(1);
			this.newTaskMc.x=482;
			this.newTaskMc.y=325;
			this.newTaskMc.addEventListener(MouseEvent.MOUSE_DOWN,showTaskWin);
			this.addChild(this.newTaskMc);
		}
		
		private function showTaskWin(event:MouseEvent):void{
			EvtDispacther.instance.eventDispatch(TaskWin.WINDOW_SHOW);
			newTaskHandle(false);
		}
		
		/**
		 * 处理新任务事件
		 */
		public function newTaskHandle(boo:Boolean):void{
			if(CaesaryConfig.instance.firstTimeLogin){
				return;
			}
			this.newTaskMc.visible=boo;
			if(boo){
				this.newTaskMc.gotoAndPlay(1);
				this.addEventListener(Event.ENTER_FRAME,newTaskMcControl);
			}else{
				if(this.hasEventListener(Event.ENTER_FRAME)){
					this.removeEventListener(Event.ENTER_FRAME,newTaskMcControl);
				}
				this.newTaskMc.gotoAndStop(1);
			}
		}
		
		private function newTaskMcControl(event:Event):void{
			if(this.newTaskMc.currentFrame==15){
				this.newTaskMc.gotoAndStop(16);
				this.removeEventListener(Event.ENTER_FRAME,newTaskMcControl);
			}
		}
		
		public function getTownMod():Town{
			return this.townMod;
		}
	}
}