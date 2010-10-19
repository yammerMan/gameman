package views.spreadUI.castleStatus
{
	import flash.events.MouseEvent;
	
	import roma.common.constants.BattleConstants;
	import roma.logic.GameContext;
	import roma.logic.object.player.OtherArmyObj;
	import roma.message.EvtDispacther;
	import roma.message.events.ShowOtherArmyTipEvent;
	import roma.resource.ImgManager;
	
	import views.windows.functionWins.hero.HeroHelper;
	
	public class OtherArmyActionStatusUI extends ArmyActionStatusUI
	{
		private var otherArmyObj:OtherArmyObj
		public function OtherArmyActionStatusUI()
		{
		}
		public function setOtherArmyObj(otherArmyObj:OtherArmyObj):void
		{
			this.otherArmyObj=otherArmyObj;
			this.timeNeed=(this.otherArmyObj.bean.arriveTime- new Date().valueOf()+GameContext.instance.getTimeDis())/1000;
		}
		override public function remainingTime():void
		{
			this.otherArmyObj.resetRemainTimeStr();
			this.remainTimeStr=this.otherArmyObj.remainTimeStr;
			this.drawProgressBar(this.otherArmyObj.bean.arriveTime,this.timeNeed);
		}
		override public function getSituation():void
		{
			if(this.otherArmyObj.bean.attacker){
				this.armyTpye=2;
			}else{
				this.armyTpye=1;
			}
			
			if(this.otherArmyObj!=null){
				this.curAction=this.getArmyAction();
				this.curStateStr = this.otherArmyObj.getheroStatus();
				if (this.otherArmyObj.bean.mission) {
					this.iconPath = HeroHelper.getBeanIcons(otherArmyObj.bean.mission);
				}
			}	
		}
		override public function getArmyAction():String{
			var action:String="";
			if(this.otherArmyObj!=null){
				action=this.otherArmyObj.misstionStr;
			}
			return action;
		}
		
		override public function showTip(event:MouseEvent):void{
			EvtDispacther.instance.dispatchEvent(new ShowOtherArmyTipEvent(ShowOtherArmyTipEvent.SHOWO_THERARMYTIP,this.otherArmyObj,event));
		}
	}
}