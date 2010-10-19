package roma.logic.object.building.impl
{
	import animation.AnimationManager;
	
	import flash.display.BitmapData;
	
	import mx.logging.ILogger;
	import mx.logging.Log;
	
	import roma.common.action.ControllerFactory;
	import roma.common.controller.CommonResponse;
	import roma.common.controller.troop.MayFinishAllResponse;
	import roma.common.valueObject.ArchitectureBean;
	import roma.logic.object.building.BaseBuilding;
	import roma.util.MultiLang;
	
	import views.PopupWindows;
	import views.spreadUI.MyAlert;
	import views.windows.buildings.wall.WallWin;

	/**
	 * 
	 * 城墙
	 * 
	 */
	public class Wall extends BaseBuilding
	{
		private static var log:ILogger = Log.getLogger("roma.logic.building.impl.Wall");
		
		public function Wall(bean:ArchitectureBean)
		{
			super(bean);
		}
		
		/**
		 * 重写父类的方法
		 * 点击弹出界面
		 **/
		override public function onClick():void {
			PopupWindows.openBuildingInfoWin(WallWin.WINDOW_SHOW ,this);
		}

		override protected function initAni():void {
			this.addConstructingAni(AnimationManager.buildings.workingPeople1 , 12 ,135);
			this.addConstructingAni(AnimationManager.buildings.workingPeople1 , 52 ,155);
			this.addConstructingAni(AnimationManager.buildings.workingPeople1 , 204 , 237);
			this.addConstructingAni(AnimationManager.buildings.workingPeople1 , 244 , 257);
		
			this.levelBgPlayer.sceneX=210;
			this.levelBgPlayer.sceneY=217;
			this.levelDigitalPlayer3.sceneX =this.levelDigitalPlayer1.sceneX =217; 
			this.levelDigitalPlayer3.sceneY =this.levelDigitalPlayer1.sceneY=224;
			this.levelDigitalPlayer4.sceneX =this.levelDigitalPlayer2.sceneX =222; 
			this.levelDigitalPlayer4.sceneY =this.levelDigitalPlayer2.sceneY=224;
		}

		/** 可以覆盖的方法 */
		override public function drawToBitmapData(screen:BitmapData, x:int, y:int):void{
			if (this.isConstructing()) {
				this.drawWorkingPeopleToSecne(screen,x,y);
			}
			this.drawLevel(screen , x , y);
		}
		
		public function produceFortification(type:int,num:int):void{
			ControllerFactory.getInstance().getFortificationsController().produceFortification(this.castle.cityId,type,num,onProduceResPonse);
			
			function onProduceResPonse(event:CommonResponse):void{
				if(!event.isSuccess()){
					MyAlert.showError(event);
				}
			}
		}

		public function speedFortificationProduce(queue:int,itemId:String):void{
			ControllerFactory.getInstance().getFortificationsController().speedFortificationProduce(this.castle.cityId,queue,itemId,onSpeedResPonse);
			
			function onSpeedResPonse(event:MayFinishAllResponse):void{
				if(!event.isSuccess()){
					MyAlert.showError(event);
				}else{
					if(event.finishAll){
						MyAlert.show(MultiLang.msg("public.speedUp.fortificationAllDone"));
					}
				}
			}
		}

		public function cancelFortificationProduce(queue:int):void{
			ControllerFactory.getInstance().getFortificationsController().cancelProduce(this.castle.cityId,queue,onCancelResPonse);
			
			function onCancelResPonse(event:CommonResponse):void{
				if(!event.isSuccess()){
					MyAlert.showError(event);
				}
			}
		}

		public function destructFortification(type:int,num:int,fun:Function =null):void{
			ControllerFactory.getInstance().getFortificationsController().destructFortification(this.castle.cityId,type,num,onDestructResPonse);
			
			function onDestructResPonse(event:CommonResponse):void{
				if(event.isSuccess()){
					if(fun !=null){
						fun.apply(this);
					}
				}else{
					MyAlert.showError(event);
				}
			}
		}
		
	}
}