package views
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import mx.containers.Canvas;
	import mx.core.UIComponent;
	
	import roma.common.action.ControllerFactory;
	import roma.common.constants.BuildingConstant;
	import roma.common.controller.CommonResponse;
	import roma.common.controller.army.FreshBattleFieldResponse;
	import roma.common.controller.shop.UseMaterialResultResponse;
	import roma.logic.GameContext;
	import roma.logic.object.building.BaseBuilding;
	import roma.logic.object.hero.HeroObj;
	import roma.logic.object.player.ItemResManager;
	import roma.logic.rule.GameRuleHelper;
	import roma.logic.rule.ItemRule;
	import roma.message.EvtDispacther;
	import roma.message.events.PublicEvent;
	import roma.resource.ImgManager;
	import roma.util.JavaScriptHelper;
	import roma.util.MultiLang;
	
	import views.mainFrame.ToggleButton;
	import views.mainModules.map.diamond2.DiamondWorldMap2;
	import views.spreadUI.MyAlert;
	import views.spreadUI.beginnerGuide.CloseBtnArea;
	import views.spreadUI.beginnerGuide.CommonBtnArea;
	import views.spreadUI.beginnerGuide.FarmArea;
	import views.spreadUI.beginnerGuide.GuideTip;
	import views.spreadUI.beginnerGuide.GuideTip1;
	import views.spreadUI.beginnerGuide.GuideTip2;
	import views.spreadUI.beginnerGuide.GuideTip3;
	import views.spreadUI.beginnerGuide.HomePanel;
	import views.spreadUI.beginnerGuide.ItemSelectWin;
	import views.spreadUI.beginnerGuide.LootBtnArea;
	import views.spreadUI.beginnerGuide.MyAlert1;
	import views.spreadUI.beginnerGuide.RecArea;
	import views.spreadUI.beginnerGuide.ShieldPanel;
	import views.spreadUI.beginnerGuide.SpaceArea;
	import views.spreadUI.beginnerGuide.SwithBtnArea;
	import views.spreadUI.beginnerGuide.TagBtnArea;
	import views.windows.buildings.resBuilding.ResUnityWin;
	import views.windows.functionWins.hero.HeroHelper;
	import views.windows.functionWins.hero.HerosMansionWin;
	import views.windows.functionWins.myItem.MyItemsWin;
	import views.windows.functionWins.task.TaskWin;
	
	/**
	 * @author Administrator
	 * 新手指引
	 */
	public class BeginnerGuide extends Canvas
	{
		public static const AWARD_QUEST:String ="领取完成任务";
		public static const USE_INCBUILDFORMATION60H_ITEM:String ="使用小型动员演讲物品"; 
		public static const CREAT_FARMER_POST:String ="创建农民职位，默认10个";
		
		public static const CLICK_NEWPLAYER_PACKAGE:String = "点击新手礼包";
		public static const CLICK_HERO_PACKAGE:String = "点击英雄包";
		public static const CLICK_TROOP_PACKAGE:String = "点击小队降军包";
		
		public static const USE_NEWPLAYER_PACKAGE:String ="使用新手礼包";
		public static const CLOSE_GET_ITEM_WIN:String ="关闭解包后获取物品的界面";
		
		public static const SELECT_HERO_TAG:String = "切换到英雄标签";  
		
		public static const OPEN_MAPFIELD_WIN:String = "弹出地图野地界面"; 
		
		public static const BEGINNER_GUIDE:String ="用于判断是否是新手引导";
		
		public static const LOOT_FIELD:String ="掠夺级野地";
		
		public static const IS_SURE_LOOT:String = "确认对野地掠夺";
		
		public static const START_LOOT:String = "开始对野地进行掠夺";

		public static const SELECT_RES_TAG:String = "切换到资源标签";

		public static const GUIDENUM:int =55;
		
		private static var housePosition:int =9;
		private static var wareHousePosition:int =18;
		private static var trainingFieldPositon:int=14;
				
		private var _areaAry:Array;
		private var _funAry:Array;									
		private var _stepNum:int;
		private var _guideIndex:int;
		private var _buildTFIndex:int;
		
		public static const TIP:String ="tip";
		public static const TIP_ONE:String ="tip1";
		public static const TIP_TWO:String ="tip2";
		public static const TIP_THREE:String ="tip3";
		
		private var _timer:Timer = new Timer(1000);
		
		//下面三个数组都是按顺序对应的
		
		//区域坐标
		private var posAry:Array =[[220,145],[103,172],[220,145],[751,90],[460,351],[822,63],[354,282],[264,172],
									[661,3],[549,406],[553,198],[559,95],[415,351],[549,406],[812,70],[0,315],
									[655,385],[822,62],[576,230],[265,397],[125,130],[460,351],[9,420],[138,106],
									[558,329],[588,83],[334,106],[558,329],[334,106],[558,329],[812,70],[809,418],
									[739,459],[652,386],[813,67],[931,373],[320,313],[666,393],[415,351],[932,376],
									[751,418]];
		//点击区域大小
		private var sizeAry:Array =[[0,0],[150,22],[0,0],[111,45],[80,22],[51,19],[0,0],[150,22],
									[0,0],[150,23],[140,21],[87,21],[80,22],[150,23],[51,19],[0,0],
									[119,21],[51,19],[0,0],[150,22],[20,20],[80,22],[41,42],[139,71],
									[110,22],[51,20],[139,71],[110,22],[139,71],[110,22],[51,19],[53,29],
									[72,36],[80,22],[51,18],[0,0],[40,40],[110,22],[80,22],[0,0],
									[54,29]];
		//提示坐标
		private var tipPosAry:Array=[[289,214,TIP],[255,197,TIP],[289,214,TIP],[574,134,TIP_ONE],[500,372,TIP],[649,92,TIP_ONE],[421,347,TIP],[336,195,TIP],
									[696,55,TIP],[613,434,TIP],[628,230,TIP],[622,138,TIP],[449,383,TIP],[615,432,TIP],[649,92,TIP_ONE],[105,392,TIP],
									[663,410,TIP],[649,92,TIP_ONE],[652,302,TIP],[349,424,TIP],[155,144,TIP],[504,376,TIP],[46,436,TIP],[213,200,TIP],
									[608,358,TIP],[620,120,TIP],[421,200,TIP],[614,360,TIP],[403,200,TIP],[609,360,TIP],[649,92,TIP_ONE],[620,290,TIP_THREE],
									[540,310,TIP_THREE],[693,410,TIP],[655,80,TIP_ONE],[730,240,TIP_THREE],[343,360,TIP],[696,430,TIP],[440,377,TIP],[730,280,TIP_THREE],
									[553,310,TIP_THREE]];
		
		public function BeginnerGuide()
		{	
			super();

					   
			this.width =1000;
			this.height =600;

			addItemSelectWin();
			addAlertWin();

			addSp();
			addTip();
			addHp();
			addSpArea();
			addReaArea();
			addFramArea();
			addLootArea();
			addCloBtnArea();
			addComBtnArea();
			addSwiBtnArea();
			addTagBtnArea();
			addAssignSoldierMc();
			
			
			_areaAry = [_spArea,_coArea,_spArea,_coArea,_coArea,_clArea,_spArea,_coArea,
						_loArea,_coArea,_coArea,_coArea,_coArea,_coArea,_clArea,_faArea,
						_coArea,_clArea,_spArea,_coArea,_coArea,_coArea,_loArea,_reArea,
						_coArea,_clArea,_reArea,_coArea,_reArea,_coArea,_clArea,_coArea,
						_coArea,_coArea,_clArea,_swArea,_loArea,_coArea,_coArea,_swArea,_coArea];
						
			_funAry = [clickSpace,buildHouse,clickHouse,speedHouse,sure,close,clickSpace1,buildWareHouse,
						openTaskWin,getAwardQuest,useBuildingProcess,isUseProcessItem,useBuildProcessItem,getAwardQuest,close,openFramWin,
						createFarmerPost,close,clickSpace3,buildTrainingField,speedTrainingField,sure,openMyItemWin,clickNewPp,
					   useNewPp,closeGetItemWin,clickHeroPp,useNewPp,clickTroopPp,useNewPp,close,selectedHeroTag,
					   openHeroManagerWin,openAssignTroopWin,close,goToMap,lootField,isSureLoot,startLoot,goToTown,
					   selectResPanelTag];

			_timer.addEventListener(TimerEvent.TIMER,timerHandler);	
		}
		
		private var count:int;
		private function timerHandler(evt:TimerEvent):void{
			count++;
			if(count>=1){
				
				if(isHomePanel()){
					_homepanel.visible = true;
				}else{
					_areaAry[_stepNum-1].visible = true;
				
					var str:String = MultiLang.msg("beginnerGuide.desc."+_guideIndex)
					shouGuideTip(str,tipPosAry[_stepNum-1]);
					
					if(_stepNum ==35)
						_assignSoldierMc.visible = true;
						
				}
				
				count =0;
				_timer.stop();			
			}
		}
		
		private function addSp():void{
			var sp:ShieldPanel = new ShieldPanel();
			this.addChild(sp);
		}
		
		private var _homepanel:HomePanel; 
		private function addHp():void{
			_homepanel = new HomePanel();
			_homepanel.x = (1000-_homepanel.width)/2;
			_homepanel.y = (600-_homepanel.height)/2-6;
			_homepanel.fun = guideStart;
			this.addChild(_homepanel);
		}
		
		private var _tip:GuideTip;
		private var _tip1:GuideTip1;
		private var _tip2:GuideTip2;
		private var _tip3:GuideTip3;
		private function addTip():void{
			_tip = new GuideTip();
			_tip.visible = false;
			this.addChild(_tip);

			_tip1 = new GuideTip1();
			_tip1.visible = false;
			this.addChild(_tip1);

			_tip2 = new GuideTip2();
			_tip2.visible = false;
			this.addChild(_tip2);

			_tip3 = new GuideTip3();
			_tip3.visible = false;
			this.addChild(_tip3);
		}
		
		private var _spArea:SpaceArea;
		private function addSpArea():void{
			_spArea = new SpaceArea();
			_spArea.fun = clickSpace;
			_spArea.visible = false;
			this.addChild(_spArea);
		}
		
		private var _clArea:CloseBtnArea;
		private function addCloBtnArea():void{
			_clArea = new CloseBtnArea();
			_clArea.visible = false;
			this.addChild(_clArea);
		}
		
		private var _coArea:CommonBtnArea;
		private function addComBtnArea():void{
			_coArea = new CommonBtnArea();
			_coArea.visible = false;
			this.addChild(_coArea);
		}
		
		private var _faArea:FarmArea;
		private function addFramArea():void{
			_faArea = new FarmArea();
			_faArea.visible = false;
			this.addChild(_faArea);
		}
		
		private var _loArea:LootBtnArea;
		private function addLootArea():void{
			_loArea = new LootBtnArea();
			_loArea.visible = false;
			this.addChild(_loArea);
		}
		
		private var _swArea:SwithBtnArea;
		private function addSwiBtnArea():void{
			_swArea = new SwithBtnArea();
			_swArea.visible = false;
			this.addChild(_swArea);
		}
		
		private var _reArea:RecArea;
		private function addReaArea():void{
			_reArea = new RecArea();
			_reArea.visible = false;
			this.addChild(_reArea);
		}
		
		private var _tgArea:TagBtnArea;
		private function addTagBtnArea():void{
			_tgArea= new TagBtnArea();
			_tgArea.visible = false;
			this.addChild(_tgArea);		
		}
				
		private var _assignSoldierMc:MovieClip;
		private function addAssignSoldierMc():void{
			var cl:Class = ImgManager.clazz("assignSoldierAni");
			_assignSoldierMc = new cl() as MovieClip;
			_assignSoldierMc.x = _assignSoldierMc.width/2+341;
			_assignSoldierMc.y = _assignSoldierMc.height/2+207;
			_assignSoldierMc.visible=true;

			var comp:UIComponent = new UIComponent();
			comp.addChild(_assignSoldierMc);
			this.addChild(comp);
		}
		
		private function addAlertWin():void{
			var win:MyAlert1 = new MyAlert1();
			win.visible = false;
			this.addChild(win);
		}
		
		private function addItemSelectWin():void{
			var win:ItemSelectWin = new ItemSelectWin();
			win.visible = false;
			this.addChild(win);
		}
		
		private function guideStart():void{
			setMcVis();
		}
		
		private function shouGuideTip(str:String,ary:Array):void{
			switch(ary[2]){
				case TIP:
					_tip.visible = true;
					_tip.setValue(str);
					_tip.x = ary[0];					
					_tip.y = ary[1];
					break;			
				case TIP_ONE:
					_tip1.visible = true;
					_tip1.setValue(str);
					_tip1.x = ary[0];					
					_tip1.y = ary[1];
					break;			
				case TIP_TWO:
					_tip2.visible = true;
					_tip2.setValue(str);
					_tip2.x = ary[0];					
					_tip2.y = ary[1];
					break;			
				case TIP_THREE:
					_tip3.visible = true;
					_tip3.setValue(str);
					_tip3.x = ary[0];					
					_tip3.y = ary[1];
					break;			
			}
		}
		
		private function setMcVis():void{ 
			_tip.visible = false;
			_tip1.visible = false;
			_tip2.visible = false;
			_tip3.visible = false;
			
			_clArea.visible= false;
			_coArea.visible = false;
			_faArea.visible = false;
			_loArea.visible = false;
			_reArea.visible = false;
			_spArea.visible = false;
			_swArea.visible = false;
			_tgArea.visible = false;
			_homepanel.visible = false;
			
			_assignSoldierMc.visible = false;
			
			if(_guideIndex <GUIDENUM)
				_guideIndex++;
			
			
			if(isHomePanel()){
				var guideStr:String = MultiLang.msg("beginnerGuide.desc."+_guideIndex);
				_homepanel.setValue(guideStr,_guideIndex);
				
			}else{
				if(_stepNum <_areaAry.length){
					
					//建造房子没有加速自动完成的时候，
					if(_stepNum == 2 || _stepNum == 3){
						if(isHouseBuilding())
							addListener();
					
					}
					
					//建造广场没有加速自动完成的时候，
					if(_stepNum == _buildTFIndex+2){
						if(isTraniningFieldBuilding())
							addListener();

					}
					
					_areaAry[_stepNum].fun = _funAry[_stepNum];
					_areaAry[_stepNum].step =_stepNum;
					
					if(sizeAry[_stepNum][0] !=0 && sizeAry[_stepNum][1] !=0)
						_areaAry[_stepNum].setSize(sizeAry[_stepNum][0],sizeAry[_stepNum][1]);
					
					_areaAry[_stepNum].setPosition(posAry[_stepNum][0],posAry[_stepNum][1]);
										
					_stepNum++;
				}
			}
			
			if(!_timer.running)
				_timer.start();
				
			trace("_guideIndex: "+_guideIndex +"_stepNum: "+_stepNum);
		}
		
		private function isHomePanel():Boolean{
			return (_guideIndex ==1 || _guideIndex ==2 || _guideIndex ==9 ||_guideIndex ==12 ||_guideIndex ==20 
			||_guideIndex ==24 ||_guideIndex ==29 || _guideIndex ==39 ||_guideIndex ==44 ||_guideIndex ==49 
			||_guideIndex ==52||_guideIndex ==53||_guideIndex ==54||_guideIndex ==55);
		}
		
		private var _isHouseSpeed:String =null;
		private var _isTrainingFieldSpeed:String =null;
		private function frameHandler(evt:Event):void{
			if(_stepNum>15){
				if(!isTraniningFieldBuilding() && _isTrainingFieldSpeed==null){
					_stepNum+=1;
					_guideIndex+=1;

					removeListener();

					setMcVis();
				}else{
					if(isWareHouseBuilding()){
						_areaAry[_buildTFIndex+2].x = posAry[_buildTFIndex+2][0];
						_areaAry[_buildTFIndex+2].y = posAry[_buildTFIndex+2][1];
					}else{
						_areaAry[_buildTFIndex+2].x = posAry[_buildTFIndex+2][0];
						_areaAry[_buildTFIndex+2].y = posAry[_buildTFIndex+2][1]-34;
					}
				}	
			}else{
				if(!isHouseBuilding() && _isHouseSpeed ==null){
					if(_stepNum ==3){
						_stepNum+=3;
						_guideIndex+=3;
					}
					
					if(_stepNum ==4){
						_stepNum+=2;
						_guideIndex+=2;
						
						PopupWindows.closeAll();
					}
					
					//trace("_stepNum"+"\t"+_stepNum+"\t"+"_guideIndex:"+_guideIndex);
					
					removeListener();
					setMcVis();
				}		
			}
		}
		
		private function removeListener():void{
			this.removeEventListener(Event.ENTER_FRAME,frameHandler);
		}
		
		private function addListener():void{
			if(!this.hasEventListener(Event.ENTER_FRAME))
				this.addEventListener(Event.ENTER_FRAME,frameHandler);
		}
		
		private function isHouseBuilding():Boolean{
			var buildObj:BaseBuilding = GameContext.instance.getPlayerObj().getCurCastleObj().buildingManager.getBuildingObjAtPosition(housePosition);
			return buildObj.isConstructing();
		}
		
		private function isTraniningFieldBuilding():Boolean{
			var buildObj:BaseBuilding = GameContext.instance.getPlayerObj().getCurCastleObj().buildingManager.getBuildingObjAtPosition(trainingFieldPositon);
			
			if(buildObj ==null) return false;
				
			return buildObj.isConstructing();
		}
		
		private function isWareHouseBuilding():Boolean{
			var buildObj:BaseBuilding = GameContext.instance.getPlayerObj().getCurCastleObj().buildingManager.getBuildingObjAtPosition(wareHousePosition);

			if(buildObj ==null) return false;

			return buildObj.isConstructing();
		}
		
		private function eventdispatch(str:String):void{
			EvtDispacther.instance.dispatchEvent(new Event(str));

			setMcVis();
		}
		
		private function clickSpace(index:int):void{
			PopupWindows.openNewBuildingWinAtPosition(housePosition);
			setMcVis();
		}
		
		private function buildHouse(index:int):void{
			var cityId:int = GameContext.instance.getPlayerObj().getCurCastleObj().getCityId();
			ControllerFactory.getInstance().getBuildingController().consNewBuilding(cityId,housePosition,BuildingConstant.TYPE_HOUSE_BUILDING,onBuildResponse);
			PopupWindows.closeAll();
			
			function onBuildResponse(event:CommonResponse):void {
				if (event.isSuccess()) {
					setMcVis();
				}
			}
		}
		
		private function clickHouse(index:int):void{
			var buildingObj:BaseBuilding =GameContext.instance.getPlayerObj().getCurCastleObj().buildingManager.getBuildingObjAtPosition(housePosition);
			if(buildingObj !=null)
				buildingObj.onClick();		

			removeListener();
			
			setMcVis();
		}
		
		private function speedHouse(index:int):void{
			var buildingObj:BaseBuilding =GameContext.instance.getPlayerObj().getCurCastleObj().buildingManager.getBuildingObjAtPosition(housePosition);
			if(buildingObj !=null)
				buildingObj.speedUp(BEGINNER_GUIDE);		

			_isHouseSpeed = BEGINNER_GUIDE;
			
			removeListener();
			
			setMcVis();
		}
		
		private function sure(index:int):void{
			MyAlert1.instance.close();
			setMcVis();
		}
		
		private function close():void{
			PopupWindows.closeAll();
			setMcVis();
		}		
		
		private function clickSpace1(index:int):void{
			PopupWindows.openNewBuildingWinAtPosition(wareHousePosition);
			setMcVis();
		}
		
		private function buildWareHouse(index:int):void{
			var cityId:int = GameContext.instance.getPlayerObj().getCurCastleObj().getCityId();
			ControllerFactory.getInstance().getBuildingController().consNewBuilding(cityId,wareHousePosition,BuildingConstant.TYPE_WAREHOUSES,onBuildResponse);
			PopupWindows.closeAll();
			
			function onBuildResponse(event:CommonResponse):void {
				if (event.isSuccess()) {
					setMcVis();
				}
			}
		}
		
		private function openTaskWin():void{
			PopupWindows.openFuncWin(TaskWin.WINDOW_SHOW);			
			setMcVis();
		}
		
		private function getAwardQuest(index:int):void{
			eventdispatch(AWARD_QUEST);
		}
		
		private function useBuildingProcess(index:int):void{
			ItemSelectWin.instance.show(ItemResManager.prolongBuildingProcessItemArrayCollection);
			setMcVis();
		}
		
		private function isUseProcessItem(index:int):void{
			var rule:ItemRule = GameRuleHelper.instance.getItemRuleById("incBuildFormation60h");
			MyAlert1.instance.show(MultiLang.msg("myItems.sureToUseItem{0}",rule.name),sure);

			setMcVis();
			
			function sure():void{
			}
		}
		
		private function useBuildProcessItem(index:int):void{
			var itemId:String ="incBuildFormation60h";
			ControllerFactory.getInstance().getShopController().usePlayerItem(GameContext.instance.getPlayerObj().getCurCastleObj().cityId,itemId,onUseItemBackHandle);
		
			function onUseItemBackHandle(event:UseMaterialResultResponse):void {
				if (event.isSuccess()) {
					MyAlert1.instance.close();
					ItemSelectWin.instance.closeWin();	
					eventdispatch(USE_INCBUILDFORMATION60H_ITEM);
					var rule:ItemRule = GameRuleHelper.instance.getItemRuleById(itemId);
					JavaScriptHelper.instance.addItemLog(1 , rule , itemId);
				} else {
					MyAlert.show(MyAlert.msg(event.errorMsg));
				}
			}
			
		}
		
		private function openFramWin():void{
			var buildingObj:BaseBuilding =GameContext.instance.getPlayerObj().getCurCastleObj().buildingManager.getBuildingObjAtPosition(BuildingConstant.POSITION_FARM);
			PopupWindows.openBuildingInfoWin(ResUnityWin.WINDOW_SHOW ,buildingObj,BEGINNER_GUIDE);
			setMcVis();
		}
		
		private function createFarmerPost(index:int):void{
			eventdispatch(CREAT_FARMER_POST);
		}
		
		private function clickSpace3(index:int):void{
			PopupWindows.openNewBuildingWinAtPosition(trainingFieldPositon);
			_buildTFIndex = index;
			
			setMcVis();
		}
		
		private function buildTrainingField(index:int):void{
			var cityId:int = GameContext.instance.getPlayerObj().getCurCastleObj().getCityId();
			ControllerFactory.getInstance().getBuildingController().consNewBuilding(cityId,trainingFieldPositon,BuildingConstant.TYPE_TRAINNINGS,onBuildResponse);
			PopupWindows.closeAll();
			
			function onBuildResponse(event:CommonResponse):void {
				if (event.isSuccess()) {
					setMcVis();
				}
			}
		}
		
		private function speedTrainingField(index:int):void{
			var buildingObj:BaseBuilding =GameContext.instance.getPlayerObj().getCurCastleObj().buildingManager.getBuildingObjAtPosition(trainingFieldPositon);
			if(buildingObj !=null)
				buildingObj.speedUp(BEGINNER_GUIDE);		

			_isTrainingFieldSpeed = BEGINNER_GUIDE;
						
			removeListener();
			
			setMcVis();
		}
		
		private function openMyItemWin():void{
			PopupWindows.openFuncWin(MyItemsWin.WINDOW_SHOW);			
			setMcVis();
		}
		
		private function clickNewPp():void{
			eventdispatch(CLICK_NEWPLAYER_PACKAGE);		
		}
		
		private function useNewPp(index:int):void{
			eventdispatch(USE_NEWPLAYER_PACKAGE);
		}
		
		private function closeGetItemWin():void{
			eventdispatch(CLOSE_GET_ITEM_WIN);	
		}
		
		private function clickHeroPp():void{
			eventdispatch(CLICK_HERO_PACKAGE);	
		}
		
		private function clickTroopPp():void{
			eventdispatch(CLICK_TROOP_PACKAGE);	
		}
		
		private function selectedHeroTag(index:int):void{
			eventdispatch(SELECT_HERO_TAG);
		}
		
		private function openHeroManagerWin(index:int):void{
			var hero:HeroObj =GameContext.instance.getPlayerObj().getCurCastleObj().heroManager.heroArray.getItemAt(0) as HeroObj;
			PopupWindows.openFuncWin(HerosMansionWin.WINDOW_SHOW ,hero);
			setMcVis();
		}
		
		private function openAssignTroopWin(index:int):void{
			var cityId:int =GameContext.instance.getPlayerObj().getCurCastleObj().cityId;
			var hero:HeroObj =GameContext.instance.getPlayerObj().getCurCastleObj().heroManager.heroArray.getItemAt(0) as HeroObj;

			ControllerFactory.getInstance().getArmyController().contrTroopForHero(cityId,hero.heroInfo.id,onCommonresponse);
			function onCommonresponse(evt:CommonResponse):void{
				if(evt.isSuccess()){
					//PopupWindows.openFuncWin(AssignTroopWin.WINDOW_SHOW , new HeroData(hero,true));
					HeroHelper.instance.curSelectHero=hero;
					PopupWindows.openFuncWin(HerosMansionWin.WINDOW_SHOW_WEAVE,hero);
					setMcVis();
				}
			}
		}
		
		private function goToMap():void{
			ToggleButton.instance.switchHandler(true);
			var cityId:int =GameContext.instance.getPlayerObj().getCurCastleObj().cityId;
			ControllerFactory.getInstance().getArmyController().getFreshManBattleField(cityId,onFreshBattleFieldResponse);
			
			function onFreshBattleFieldResponse(event:FreshBattleFieldResponse):void{
				if(event.isSuccess()){
					
					var fx:int = event.fieldId/10000;
					var fy:int = event.fieldId%10000;
					DiamondWorldMap2.instance.goPoint(fx,fy);
					
					EvtDispacther.instance.dispatchEvent(new PublicEvent(OPEN_MAPFIELD_WIN,event));
					setMcVis();
				}			
			} 
		}
		
		private function lootField():void{
			eventdispatch(LOOT_FIELD);
		}
		
		private function isSureLoot(index:int):void{
			eventdispatch(IS_SURE_LOOT);
		}
		
		private function startLoot(index:int):void{
			eventdispatch(START_LOOT);
		}
		
		private function goToTown():void{
			ToggleButton.instance.switchHandler(false);
			setMcVis();
		}
		
		private function selectResPanelTag(index:int):void{
			eventdispatch(SELECT_RES_TAG);
		}
	}
}