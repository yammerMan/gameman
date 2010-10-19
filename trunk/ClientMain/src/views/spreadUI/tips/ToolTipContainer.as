package views.spreadUI.tips
{
	import flash.utils.Dictionary;
	
	import mx.containers.Canvas;
	import mx.managers.ToolTipManager;

	public class ToolTipContainer extends Canvas
	{
		public static var instance:ToolTipContainer =new ToolTipContainer();
//		public static function get instance():ToolTipContainer {
//			if (_instance ==null) {
//				_instance = new ToolTipContainer();
//			} 
//			return _instance;
//		}
		
		private var toolTipMap:Dictionary = new Dictionary();
		
		public var buildingToolTip:BuildingTip = new BuildingTip();
		public var conditionTooltip:ConditionTip = new ConditionTip();
		public var supportTooltip:MoraleTip = new MoraleTip();
		public var populationTooltip:PeopleTip = new PeopleTip();
		public var goldsToolTip:GoldTip = new GoldTip();
		public var commonTooltip:CommonTooltip=new CommonTooltip();
		public var resTooltip:ResTooltip = new ResTooltip();
		public var itemDescTooptip:ItemDescTooptip = new ItemDescTooptip();
		public var equipDescTooptip:EquipDescTooptip = new EquipDescTooptip();
		public var playerBuffTooptip:PlayerBuffTip = new PlayerBuffTip();
		public var worldMapTooltip:MapTip = new MapTip();
		public var heroTips:HeroTips = new HeroTips();
		public var fieldTooltip:FieldTooltip = new FieldTooltip();
		public var armyTooltip:ArmyTooltip = new ArmyTooltip();
		public var newWallTooltip:NewWallTooltip = new NewWallTooltip();
		public var itemOrigintip:ItemOrigintip = new ItemOrigintip();
		public var skillTooltip:SkillTooltip = new SkillTooltip();
		public var fortificationToolTip:FortificationTooltip = new FortificationTooltip();
		public var techConditionTooltip:TechConditionTooltip = new TechConditionTooltip();
		public var playerStatusTootip:PlayerStutasTips = new PlayerStutasTips();
		public var playerInfoTip:PlayerInfoTip = new PlayerInfoTip();
		public var playerCastleTip:PlayerCastleTip = new PlayerCastleTip();
		
		public var troopPropToolTip:TroopPropTooltip = new TroopPropTooltip();
		public var fortPropTooltip:FortPropTooltip = new FortPropTooltip();
		
		public var castleInfoTooltip:CastleInfoTooltip = new CastleInfoTooltip();
		
		public var garrisonTip:GarrisonTip = new GarrisonTip();	
		
		public var myArmyGarrisonTip:MyArmyGarrisonTip= new MyArmyGarrisonTip();

		public var fieldInfoTooltip:FieldInfoToolTip = new FieldInfoToolTip();
		
		public var tfproptooltip:TFPropTooltip = new TFPropTooltip();
		
		public var bugBtnTip:BugBtnTip=new BugBtnTip();
		
		public var trainingRoomWarBtnTip:TrainingRoomWarBtnTip=new TrainingRoomWarBtnTip();
		
		public var equipToolTip:EquipToolTip=new EquipToolTip();
		
		/** 地图拥挤度的提示 **/
		public var cityCrowRatToolTip:CityCrowRateTooltip = new CityCrowRateTooltip();
					
		public function ToolTipContainer()
		{
			super();
			this.alpha = 1.0;
			
			ToolTipManager.hideDelay = 120000;
			
			this.addTooltip(this.buildingToolTip);
			this.addTooltip(this.conditionTooltip);
			this.addTooltip(this.supportTooltip);
			this.addTooltip(this.populationTooltip);
			this.addTooltip(this.goldsToolTip);
			this.addTooltip(this.commonTooltip);
			this.addTooltip(this.resTooltip);
			this.addTooltip(this.itemDescTooptip);
			this.addTooltip(this.equipDescTooptip);
			this.addTooltip(this.playerBuffTooptip);
			this.addTooltip(this.worldMapTooltip);
			this.addTooltip(this.heroTips);
			this.addTooltip(this.fieldTooltip);
			this.addTooltip(this.armyTooltip);
			this.addTooltip(this.newWallTooltip);
			this.addTooltip(this.itemOrigintip);
			this.addTooltip(this.skillTooltip);
			this.addTooltip(this.fortificationToolTip);
			this.addTooltip(this.techConditionTooltip);
			this.addTooltip(this.playerStatusTootip);
			this.addTooltip(this.playerInfoTip);
			this.addTooltip(this.playerCastleTip);
			this.addTooltip(this.troopPropToolTip);
			this.addTooltip(this.fortPropTooltip);
			this.addTooltip(this.castleInfoTooltip);
			this.addTooltip(this.garrisonTip);
			this.addTooltip(this.myArmyGarrisonTip);
			this.addTooltip(this.fieldInfoTooltip);
			this.addTooltip(this.tfproptooltip);
			this.addTooltip(this.bugBtnTip);
			this.addTooltip(this.trainingRoomWarBtnTip);
			this.addTooltip(this.cityCrowRatToolTip);
			this.addTooltip(this.equipToolTip);
		}
		
		private function addTooltip(tt:BaseTip):void {
			tt.visible = false;
			this.addChild(tt);
		}
	}
}