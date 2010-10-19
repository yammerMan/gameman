package views.spreadUI.castleStatus
{
	import flash.events.MouseEvent;
	
	import roma.logic.GameContext;
	import roma.logic.object.player.ScoutTeamObj;
	import roma.resource.ImgManager;
	
	public class ScoutActionStatusUI extends ArmyActionStatusUI
	{
		private var scoutObj:ScoutTeamObj;
		
		public function ScoutActionStatusUI()
		{
			this.addEventListener(MouseEvent.MOUSE_OVER,onMouseOver);
		}
		
		public function setSoutObj(s:ScoutTeamObj):void{
			this.scoutObj = s;
			this.timeNeed = (this.scoutObj.bean.arriveTime - new Date().valueOf()+GameContext.instance.getTimeDis())/1000;
		}
		
		override public function remainingTime():void{
			this.scoutObj.resetRemainTimeStr();
			this.remainTimeStr=this.scoutObj.remainTimeStr;
			this.drawProgressBar(this.scoutObj.bean.arriveTime,this.timeNeed);
		}
		
		override public function getSituation():void{
			this.curAction=this.getArmyAction();
			this.iconPath = ImgManager.clazz("buffer.status.spy.icon");
		}
		
		override public function getArmyAction():String{
			var action:String="";
			if(this.scoutObj!=null){
				action=this.scoutObj.missionStr;
			}
			return action;
		}
		
		override public function showTip(event:MouseEvent):void{
		}
		
		private function onMouseOver(e:MouseEvent):void{
			this.isOver = false;
		}
		
	}
}