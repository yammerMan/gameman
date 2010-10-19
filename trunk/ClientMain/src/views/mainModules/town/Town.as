package views.mainModules.town
{
	import animation.PenstockNullahAni;
	import animation.RoleWalkingAniLayer;
	import animation.RoleWorkAniLayer;
	import animation.WorkerTalkShowLayer;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import mx.containers.Canvas;
	import mx.core.UIComponent;
	import mx.logging.ILogger;
	import mx.logging.Log;
	import mx.managers.CursorManager;
	
	import roma.common.constants.BuildingConstant;
	import roma.interfaces.IModuleInterface;
	import roma.logic.GameContext;
	import roma.logic.object.building.BaseBuilding;
	import roma.message.EvtDispacther;
	import roma.message.events.MsgEvent;
	import roma.resource.ImgManager;
	
	import views.mainFrame.RollTextBar;
	import views.mainModules.map.diamond2.DiamondWorldMap2;
	import views.mainModules.town.resDomain.FarmDomain;
	import views.mainModules.town.resDomain.IronMineDomain;
	import views.mainModules.town.resDomain.QuarryDomain;
	import views.mainModules.town.resDomain.ResourceIncreashShowLayer;
	import views.mainModules.town.resDomain.SawmillDomain;
	import views.spreadUI.tips.BuildingTip;
	import views.spreadUI.tips.ToolTipContainer;

	public class Town extends Canvas implements IModuleInterface
	{
		public static const TOWN_ID:String ="town.module";

		private static var log:ILogger = Log.getLogger("views.mainModules.town.Town");
		
		public static const SCREEN_WIDTH:int = 994;
		public static const SCREEN_HEIGHT:int = 400;
		
		/** 存放政府大厅 */
		private var townhallBuilding:TownhalllBuilding ;

		/** 左上部分城墙 */
		private var wallBuilding:WallBuilding ;
		
		/** 右下部分城墙*/
		private var wallBuilding1:WallBuilding1;
		
		/** 存放所有的空间 */
		private var spaceArray:Array = new Array(BuildingConstant.BUILDING_LIMIT);

		/** 存放四种资源*/
		private var resDomainAry:Array = new Array();

		/** 屏幕缓冲区 */
		private var screenBitmap:Bitmap = new Bitmap();

		/** 是否在显示状态 */
		private var isShowing:Boolean = false;

		private var spaceMcUi:UIComponent = new UIComponent();
		private var spaceMc:MovieClip;
		private var _buildingTooltip:BuildingTip;
		
		/**	4个等级城镇的背景图	 */ 
		private var backgroundDataArray:Array = new Array(4);
		
		/**角色劳动动画层*/
		private var roleWorkAniLayer:RoleWorkAniLayer = new RoleWorkAniLayer();
		
		private var increaseLayer:ResourceIncreashShowLayer = new ResourceIncreashShowLayer();
		
		/**角色走动动画层*/
		private var roleWalkingAniLayer:RoleWalkingAniLayer;
		
		private var workerTalkShowLayer:WorkerTalkShowLayer;
		
		/**飘动的云*/
		private var cloud:Bitmap;
		private var cloudX:int =-150;
		private var cloudY:int =0;
		
		private var river:MovieClip;
		
		private static var positionArray:Array = new Array(
		//1行
			{x:685 ,y:80 , p:7, l:0},//x 72
			{x:745 ,y:112, p:8, l:0},//x 36
		//2行		
			{x:320 ,y:0 , p:5, l:0},
			{x:384 ,y:32 , p:2, l:0},
			
			{x:640 ,y:160 , p:13, l:0},
			{x:704 ,y:192 , p:15, l:0},
			{x:768 ,y:224 , p:28, l:3},//3级			
		//3 行
			{x:256 ,y:32 , p:1, l:0},		
			{x:320 ,y:64 , p:3, l:0},
			
			{x:576 ,y:192 , p:14, l:0},
			{x:640 ,y:224 , p:16, l:0},
			{x:704 ,y:256 , p:29, l:3},//3级			
		//4行	
			{x:160 ,y:80 , p:4, l:0},
			{x:224 ,y:112, p:9, l:0},			
			{x:288 ,y:144, p:11, l:0},	
				
			{x:416 ,y:208 , p:17, l:0},
			{x:480 ,y:240 , p:19, l:0},
			{x:544 ,y:272 , p:26, l:2},//2级
			{x:608 ,y:304 , p:30, l:3},//3级			
		//5行	
			{x:96 ,y:112 , p:6, l:0},		
			{x:160 ,y:144, p:10, l:0},
			{x:224 ,y:176, p:12, l:0},
			
			{x:352 ,y:240 , p:18, l:0},
			{x:416 ,y:272 , p:0, l:0},
			{x:480 ,y:304 , p:27, l:2},//2级
			{x:544 ,y:336 , p:31, l:3}, //3级			
		//6行			
			{x:32  ,y:144, p:21, l:1},//1级						
			{x:96  ,y:176, p:22, l:1},//1级
			{x:160 ,y:208, p:23, l:1},//1级
			
			{x:288  ,y:272, p:20, l:1},//1级
			{x:352 ,y:304 , p:25, l:2},//2级
			{x:416 ,y:336 , p:24, l:2}//2级
		);


		public function Town() {
			super();
			this.horizontalScrollPolicy = "off";
			this.verticalScrollPolicy = "off";
			this.width = SCREEN_WIDTH;
			this.height = SCREEN_HEIGHT;
			
			var bgUi:UIComponent = new UIComponent()
			bgUi.addChild(this.screenBitmap);//加屏幕缓冲区
			//this.screenBitmap.smoothing = true;
			this.addChild(bgUi);
			
			this.addRiver();
			this.initBackgroundData();//初始化背景
			this.initResDomain();//4种资源
			this.addWall();
			this.initRoleWalkingPlayer();//走动的工人
			this.addTown();
			this.addWall1();
			this.addSpace();//加上建筑鼠标触发区
			this.initRoleWorkPlayer();//劳动的工人
			this.addSpaceMc();//初始化建筑空地上的动画
			this.initIncreaseLayer();
			this.addTalkLayer();
			this.initCloud();//飘动的云
			
			this.addEventListener(Event.ENTER_FRAME , onEnterFrameHandle);
			
			EvtDispacther.instance.addEventListener(EvtDispacther.EXTEND_SUCCESS,onHandler);
			
			EvtDispacther.instance.addEventListener(EvtDispacther.CUR_CASTLE_CHANGE_EVENT,castleChange);
			function castleChange(event:MsgEvent):void{
				onHandler();
			}
		}
		
		private function initBackgroundData():void {
			for (var i:int=0; i<4; i++) {
				var bgClass:Class = ImgManager.clazz("background.town" + i);
				var bgBitmap:Bitmap = new bgClass as Bitmap;
				this.backgroundDataArray[i] = bgBitmap.bitmapData;
			}
		}

		/**
		 * 设定建筑空间的位置，根据改空间的position设置。
		 * 
		 * TODO 目前是随便搞个算法，以后要改
		 */
		private static function setSpacePosition(space:BuildingSpace , index:int):void {
			var obj:Object = positionArray[index]; 
			space.x = obj.x;
			space.y = obj.y;
			space.requestLevel = obj.l;
			space.position = obj.p;
		}

		private function addSpace():void {
			for (var i:int=0; i<this.spaceArray.length; i++) {
				var space:BuildingSpace = new BuildingSpace(this); 
				setSpacePosition(space , i);
				this.spaceArray[space.position] = space;//其他建筑空间
				this.addChild(space);
			}
		}

		private function addRiver():void{
			var cl:Class = ImgManager.clazz("town.river");
			river = new cl() as MovieClip;
			river.x = SCREEN_WIDTH-river.width-130;
			river.y = SCREEN_HEIGHT-river.height-90;
			var c:UIComponent = new UIComponent();
			c.addChild(river);
			this.addChild(c);
			onHandler();
		}
		
		private function onHandler(evt:MsgEvent=null):void{
 			var level:int = GameContext.instance.getPlayerObj().getCurCastleObj().level;
			if(level<=2){
				river.gotoAndStop(2);
			}else{
				river.gotoAndStop(3);
			} 
		}
		
		private function addTown():void{
			this.townhallBuilding = new TownhalllBuilding(this);
			this.addChild(this.townhallBuilding);//官府
		}
		
		private function addWall():void{
			this.wallBuilding = new WallBuilding(this);
			this.addChild(this.wallBuilding);//城墙
		}
		
		private function addWall1():void{
			this.wallBuilding1 = new WallBuilding1(this);
			this.addChild(this.wallBuilding1);
		}
		
		/**4种劳动的工人*/	
		private function initRoleWorkPlayer():void{
			this.roleWorkAniLayer.width =SCREEN_WIDTH;
			this.roleWorkAniLayer.height = SCREEN_HEIGHT; 
			this.roleWorkAniLayer.mouseEnabled = false;
			this.roleWorkAniLayer.mouseChildren = false;
			this.addChild(this.roleWorkAniLayer);
		}
		
		/**走动的工人*/	
		private function initRoleWalkingPlayer():void{
			this.roleWalkingAniLayer = RoleWalkingAniLayer.getInstance();
			this.roleWalkingAniLayer.width =SCREEN_WIDTH;
			this.roleWalkingAniLayer.height = SCREEN_HEIGHT; 
			//this.roleWalkingAniLayer.mouseEnabled = false;
			//this.roleWalkingAniLayer.mouseChildren = false;
			this.addChild(this.roleWalkingAniLayer);
		}
		
		
		/**4种资源*/	
		private function initResDomain():void{
			var fd:FarmDomain = new FarmDomain(this);
			this.addChild(fd);
			this.resDomainAry.push(fd);

			var qd:QuarryDomain = new QuarryDomain(this);
			this.addChild(qd);
			this.resDomainAry.push(qd);

			var id:IronMineDomain= new IronMineDomain(this);
			this.addChild(id);
			this.resDomainAry.push(id);

			var sd:SawmillDomain= new SawmillDomain(this);
			this.addChild(sd);
			this.resDomainAry.push(sd);
		}
				
		private function addSpaceMc():void{
			var mcClass:Class = ImgManager.clazz("movieClip.space");
			this.spaceMc = new mcClass as MovieClip;
			this.spaceMcUi.addChild(this.spaceMc);
			this.spaceMcUi.visible = false;
			this.spaceMcUi.mouseChildren = false;
			this.spaceMcUi.mouseEnabled = false;

			this.addChild(this.spaceMcUi);
		}
		
		private function initIncreaseLayer():void{
			this.increaseLayer.width =SCREEN_WIDTH;
			this.increaseLayer.height = SCREEN_HEIGHT; 
			this.increaseLayer.mouseEnabled = false;
			this.increaseLayer.mouseChildren = false;
			this.addChild(this.increaseLayer);
		}
		
		private function addTalkLayer():void{
            this.workerTalkShowLayer= new WorkerTalkShowLayer();		
			this.workerTalkShowLayer.width = SCREEN_WIDTH;
			this.workerTalkShowLayer.height = SCREEN_HEIGHT;
			this.workerTalkShowLayer.mouseChildren = false;
			this.workerTalkShowLayer.mouseEnabled = false;
			this.addChild(this.workerTalkShowLayer);
		}
		
		private function initCloud():void{
			var c:Class = ImgManager.clazz("city.cloud");
			this.cloud = new c as Bitmap;
			this.cloud.x =this.cloudX;
			this.cloud.y =this.randRange(this.cloudY,SCREEN_HEIGHT-this.cloud.height);

			var comp:UIComponent = new UIComponent;
			comp.mouseEnabled = false;
			comp.mouseChildren = false;
			comp.addChild(this.cloud);
			this.addChild(comp);
		}

		private var lastCastleLevel:int = -1;
		
		private function drawCastleBackground():void {
			var castleLevel:int = GameContext.instance.getPlayerObj().getCurCastleObj().level;
			if (castleLevel != this.lastCastleLevel) {
				log.debug("重新画城堡背景");
				var sourceData:BitmapData = this.backgroundDataArray[castleLevel] as BitmapData;
				var screen:BitmapData = sourceData.clone();
				PenstockNullahAni.getInstance().aniPlay(screen,castleLevel);
				var old:BitmapData = this.screenBitmap.bitmapData;
				this.screenBitmap.bitmapData = screen;
				if (old!=null) {
					old.dispose();
				}
				this.lastCastleLevel = castleLevel;
			}
		}

		private var skipFrame:Boolean = false;
		private function onEnterFrameHandle(event:Event):void {
			this.skipFrame = !this.skipFrame;
			if (skipFrame) {
				return;
			}
			if (!this.isShowing) {
				return;
			}
			
			//画背景
			this.drawCastleBackground();			
			
			this.roleWorkAniLayer.roleAniPlay();
			
			this.roleWalkingAniLayer.roleWalkingPlay();
			//需要考虑画的顺序问题
			for (var i:int=0; i<6; i++) {
				 BuildingSpace(this.spaceArray[i]).drawToBitmapData();
			}
			
			this.townhallBuilding.drawToBitmapData();
			this.wallBuilding.drawToBitmapData();
			this.wallBuilding1.drawToBitmapData();
			this.increaseLayer.aniPlay();
			this.workerTalkShowLayer.moveFrame();
			
			for (var i1:int=6; i1<this.spaceArray.length; i1++) {
				 BuildingSpace(this.spaceArray[i1]).drawToBitmapData();
			}

			for(var r:int =0;r<this.resDomainAry.length;r++){
				this.resDomainAry[r].drawToBitmapData();
			}
			
			
			if(this.cloud.x>SCREEN_WIDTH){
				this.cloud.x = this.cloudX;
				this.cloud.y = this.randRange(this.cloudY,SCREEN_HEIGHT-this.cloud.height);
			}else{
				this.cloud.x+=1;
			}
		}
		
		private function randRange(min:Number, max:Number):Number {
			var randomNum:Number = Math.floor(Math.random() * (max - min + 1)) + min;
			return randomNum;
		}

		/**
		 * 当鼠标在一块空间上面的时候
		 */
		public function onMouseOverSpace(buildingSpace:BuildingSpace, event:MouseEvent):void {
			var obj:BaseBuilding = buildingSpace.getBuildingObject();
			if (obj == null) {
				this.spaceMcUi.move(buildingSpace.x , buildingSpace.y-32);
				this.spaceMc.gotoAndStop(2);
				this.spaceMcUi.visible = true;
			} else {
				this.buildingTooltip.setBuildingObj(obj);
				this.buildingTooltip.onMouseOver(event);
			}
		}
		
		public function onMouseMoveOnSpace(event:MouseEvent):void {
			if (this.buildingTooltip.visible) {
				this.buildingTooltip.onMouseMove(event);
			}			
		}
		
		/**
		 * 当鼠标离开一块空间的时候
		 */
		public function onMouseOutSpace():void {
			this.spaceMc.gotoAndStop(1);
			this.spaceMcUi.visible = false;
			this.buildingTooltip.onMouseOut();
		}
		
		/**
		 * IModuleInterface 定义的析构方法
		 */
		public function refresh():void {
			log.debug("refresh()");
			this.isShowing = true;
			
			EvtDispacther.instance.dispatchEvent(new Event(RollTextBar.ROLLTEXT_SHOW));
			
			//如果切换到城市，不是系统光标就删除自定义光标			
			if(this.cursorManager.currentCursorID != CursorManager.NO_CURSOR){
				DiamondWorldMap2.instance.removeCursorId();
			}
		}
		
		/**
		 * IModuleInterface定义的程序入口
		 */
		public function destroy():void {
			log.debug("destroy()");
			this.isShowing = false;
			if(this.cursorManager.currentCursorID == CursorManager.NO_CURSOR){
			
			}
		}
		
		public function update():void{
		
		}
		
		public function getTopWallingBuilding():WallBuilding{
			return this.wallBuilding;
		}
		
		public function getBottonWallingBuilding():WallBuilding1{
			return this.wallBuilding1;
		}
		
		public function get buildingTooltip():BuildingTip {
			if (this._buildingTooltip==null) {
				this._buildingTooltip = ToolTipContainer.instance.buildingToolTip; 
			}
			return this._buildingTooltip;
		}
	}
}