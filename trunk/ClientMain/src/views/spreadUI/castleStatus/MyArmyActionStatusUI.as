package views.spreadUI.castleStatus
{
	import flash.events.MouseEvent;
	
	import roma.common.constants.HeroManConstants;
	import roma.logic.GameContext;
	import roma.logic.object.hero.HeroObj;
	import roma.message.EvtDispacther;
	import roma.message.events.ShowMyArmyTipEvent;
	
	import views.windows.functionWins.hero.HeroHelper;
	
	public class MyArmyActionStatusUI extends ArmyActionStatusUI
	{
		private var heroObj:HeroObj;
		public function MyArmyActionStatusUI() 
		{
		}
		public function setHeroObj(heroObj:HeroObj):void
		{
			this.heroObj=heroObj;
			if(heroObj.heroInfo.status == HeroManConstants.STATUS_GROWTH){
				this.timeNeed=(this.heroObj.heroInfo.growthEndTime- new Date().valueOf()+GameContext.instance.getTimeDis())/1000;
			}else{
				this.timeNeed=(this.heroObj.heroInfo.arriveTime- new Date().valueOf()+GameContext.instance.getTimeDis())/1000;
			}
		}
		override public function remainingTime():void
		{
			this.heroObj.resetRemainTimeStr();
			this.remainTimeStr=this.heroObj.remainTimeStr;
			if(heroObj.heroInfo.status == HeroManConstants.STATUS_GROWTH){
				this.drawProgressBar(this.heroObj.heroInfo.growthEndTime,this.timeNeed);
			}else{
				this.drawProgressBar(this.heroObj.heroInfo.arriveTime,this.timeNeed);
			}
			
		}
		override public function getSituation():void
		{
			this.armyTpye=0;
			if(this.heroObj!=null){
				this.curAction=this.getArmyAction();
				if(heroObj.heroInfo.status == HeroManConstants.STATUS_GROWTH){
					// 英雄锻炼的特殊处理
					this.curStateStr = "";
					this.iconPath = HeroHelper.getBeanIcons(heroObj.heroInfo.status);
				}else{
					this.curStateStr = this.heroObj.heroStatus;
					this.iconPath = HeroHelper.getBeanIcons(heroObj.heroInfo.mission);
				}
			}
		}
		
		override public function getArmyAction():String{
			var action:String="";
			if(this.heroObj!=null){
				action=this.heroObj.missionStr;
			}
			return action;
		}
		
		override public function showTip(event:MouseEvent):void{
			EvtDispacther.instance.dispatchEvent(new ShowMyArmyTipEvent(ShowMyArmyTipEvent.SHOW_MYARMYTIP,this.heroObj,event));
		}

	}
}