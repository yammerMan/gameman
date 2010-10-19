	
	import flash.utils.Timer;
	
	import mx.events.ListEvent;
	
	import roma.common.action.ControllerFactory;
	import roma.common.constants.ScoutConstants;
	import roma.common.constants.TroopForConstants;
	import roma.common.constants.TechConstant;
	import roma.common.controller.CommonResponse;
	import roma.data.MapTileData;
	import roma.logic.GameContext;
	import roma.logic.object.castle.CastleObj;
	import roma.logic.object.tech.BaseTechObj;
	import roma.logic.rule.GameRuleHelper;
	import roma.logic.rule.TechRule;
	import roma.util.JavaScriptHelper;
	import roma.util.MultiLang;
	import roma.util.MyDateFormatter;
	
	import views.spreadUI.MyAlert;
	[Bindable]
	private var cityComData:Array=new Array();
	[Bindable]
	private var maxScoutNum:int = 0;//城堡内斥候数量
	
	[Bindable]
	private var sendBtnEnable:Boolean = false;//是否可以点击发送
	
	private var inputScoutNum:int;//输入的斥候数量
	
	private var tileDate:MapTileData;//地图数据
	
	[Bindable]
	private var missionName:String;//任务名称
	
	[Bindable]
	private var target:String;//目的地
	
	private var missionType:int = ScoutConstants.MISSION_SCOUT; //任务类型
	private var targetFieldId:int;//目标地点
	private var moveNeedTime:int=0;
	[Bindable]
	private var moveNeedTimeStr:String = "";
	[Bindable]
	private var arrivedTimeStr:String="";
	private var castle:CastleObj;
	private var dataformatter:MyDateFormatter = new MyDateFormatter();
	private var timer:Timer=new Timer(1000);
	
	private function init():void{
		timer.addEventListener(TimerEvent.TIMER, reCalcTime);
		this.numStepper.reSize(83); 
	}
	
	public function setMapTileData(data:MapTileData):void {
		trace(data.getTargetName());
		this.tileDate = data;
		this.castle=GameContext.instance.getPlayerObj().getCurCastleObj();
		this.maxScoutNum = this.castle.troopManager.getTroopByTypeId(TroopForConstants.T_SCOUT).value;
		this.target = data.getTargetName();
		this.targetFieldId = GameContext.getFieldId(this.tileDate.fieldX, this.tileDate.fieldY);
		
		if (GameContext.instance.getPlayerObj().getCastleByFieldId(this.targetFieldId)!=null) {
			this.missionType = ScoutConstants.MISSION_MOVE;
			this.missionName = MultiLang.msg('military.mission.attack');
		} else {
			this.missionType = ScoutConstants.MISSION_SCOUT;
			this.missionName = MultiLang.msg('military.mission.scout');
		}
		this.getCityArr();
		this.timer.start();
		this.countScout(this.maxScoutNum);
	}
	
	override protected function onCloseBtnClick():void {
		this.visible = false;
	}
	
	//获得城池列表
	private function getCityArr():void{
		this.cityComData=GameContext.instance.getPlayerObj().getAllCastle();
		for(var i:int=0;i<this.cityComData.length;i++){
			if (CastleObj(this.cityComData[i]).cityId==GameContext.instance.getPlayerObj().getCurCastleObj().cityId){
				this.cityCom.selectedIndex=i;
				this.castle = GameContext.instance.getPlayerObj().getCurCastleObj();
				break;
			}
		}
	}
	/*调整兵量*/
	private function countScout(num:int):void{
 		if(num>0){
 			this.sendBtnEnable=true;
 		}else{
 			this.sendBtnEnable=false;
 		}
	}
	/**
	 * 选择了城池
	 */
	public function onCitySelected(event:ListEvent):void {
		this.castle=this.cityComData[event.currentTarget.selectedIndex];
		this.maxScoutNum = this.castle.troopManager.getTroopByTypeId(TroopForConstants.T_SCOUT).value;
		this.reCalcTime();
		this.countScout(this.maxScoutNum);
	}
	
	
	
	/**
	 * 出发按钮被点击的时候
	 */
	private function onSendBtnClick():void {
		if (this.numStepper.curValue>0) {
			ControllerFactory.getInstance().getArmyController().newScout(
				this.castle.cityId,
				this.targetFieldId,
				this.numStepper.curValue,
				this.missionType,
				onSeverResponse);
		}
	}

	private function onSeverResponse(event:CommonResponse):void {
		if (!event.isSuccess()) {
			MyAlert.showError(event);
		} else {
			this.visible = false;
			if (this.tileDate.isCastle) {
				JavaScriptHelper.instance.trackEvent("militry", "Scout", "player" , this.inputScoutNum);
			} else {
				JavaScriptHelper.instance.trackEvent("militry", "Scout", this.tileDate.fieldName , this.inputScoutNum);
			} 
		}
	}
	//获取指定城侦察到达时间
	private function getMoveNeedTimeInSecond(fx:int , fy:int,castle:CastleObj):int {
		var cx:int = castle.idField / 10000;
		var cy:int = castle.idField % 10000;
		var dist:Number = GameContext.getDistance(cx, cy , fx, fy);//距离
		
		var speed:Number = GameRuleHelper.instance.getTroopRule(TroopForConstants.T_SCOUT).speed;//速度
		
		var techObj:BaseTechObj = GameContext.instance.getPlayerObj().techManager.getTechObjById(TechConstant.SCOUTING);
		if (techObj!=null) {
			var rule:TechRule = techObj.getCurCastleTechRule(castle);
			if (rule!=null) {
				speed = speed * (100 + rule.techEffect) / 100; 
			}
		}
		
		return int(dist/speed);
	}
	
	override public function destroy():void {
		this.timer.stop();
	}
	
	/**
	 * 重新计算到达时间和移动需要时间
	 */
	private function reCalcTime(event:Event=null):void {
		if(this.maxScoutNum!=0){
			this.moveNeedTime = this.getMoveNeedTimeInSecond(this.tileDate.fieldX , this.tileDate.fieldY,this.castle);
			this.moveNeedTimeStr = MultiLang.timeFormatToString(this.moveNeedTime);
			
			var now:Number = new Date().valueOf();
			var at:Date = new Date(now + this.moveNeedTime * 1000);
			this.arrivedTimeStr = this.dataformatter.format(at);
		}else{
			this.moveNeedTime = 0;
			this.moveNeedTimeStr = "";	
			this.arrivedTimeStr="";	
		}
	} 
	