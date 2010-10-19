package roma.war.data
{
	import flash.geom.Point;
	import flash.xml.XMLDocument;
	
	import mx.collections.ArrayCollection;
	
	import roma.common.constants.BattleConstants;
	import roma.common.constants.FieldConstant;
	import roma.war.constants.ReportConstants;
	import roma.war.data.actions.ActionATK;
	import roma.war.data.actions.ActionItem;
	import roma.war.data.bean.BattleReportType;
	import roma.war.data.bean.Frames;
	import roma.war.render.WarDataBuffer;
	import roma.war.ui.DisplayConfig;
	import roma.war.util.SimpleXMLDecoder;
	
	
	public class ReportManager
	{
		public static var instance:ReportManager = new ReportManager();
		
		public var battleReportType:BattleReportType;
		public var wallRemoveId:int = 0;
		
		public var attHeros:ArrayCollection = new ArrayCollection();
		public var defHeros:ArrayCollection = new ArrayCollection();
		public var wallObj:Object = {};
		
		public var warData:WarDataBuffer;
		
		public var battleFieldPosArr:Array = []; 
		
		public function ReportManager()
		{
			warData = new WarDataBuffer();
			
			battleFieldPosArr = [];
			setFieldPos();
			
		}
		
		public function setBattleType(o:Object):void{
			var obj:Object = {};
			var xd:XMLDocument = new XMLDocument(String(o));
			var decoder:SimpleXMLDecoder = new SimpleXMLDecoder(true);
			obj = decoder.decodeXML(xd);
			if(obj.hasOwnProperty("reportData"))
			battleReportType = new BattleReportType(obj.reportData.battleReport);
			
			wallRemoveId = getWallRemove();
			
			warData.initWarData();
			roundArr = ReportManager.instance.battleReportType.battle.frames.getRoundAction();
		}
		
		public function isInCastle():Boolean{
			return battleReportType.battle.battleFieldType == FieldConstant.TYPE_CITY;
		}
		
		/**
		 *  遍历所有战斗过程，找出攻破城墙的回合。 
		 */ 
		public function getWallRemove():int{
			var count:int = 0;
			var f:Frames = battleReportType.battle.frames;
		 	for(var i:Number = 0;i<f.action.length;i++){
		 		var ai:ActionItem = f.getActionItem(i);
		 		if(ai.type == BattleConstants.ROUND_ACK){
					if(ActionATK(ai).isATKWall){
						count += ActionATK(ai).dmg;
						if(count >= battleReportType.battle.wall.totalLife){
							return i;
						}
					}else{continue;}
		 		}else{continue;}
		 	}
		 	return -1;
		}
		
		public function getRoundByAction(p:int):int{
			var act:ActionItem = battleReportType.battle.frames.getActionItem(p); 
			if(act != null){
				return act.round;
			}else{return -1;}
		}
		
		private function setFieldPos():void{
			this.battleFieldPosArr = DisplayConfig.getFieldArray(ReportConstants.RED).concat(DisplayConfig.getFieldArray(ReportConstants.BLUE));
		}
		
		/**
		 * 英雄的军队位置坐标
		 */ 
		private var point:Point = new Point(0,0);
		private var basePoint:Point = new Point(0,0);
		private var targetPoint:Point = new Point(0,0);
		public function getArmyLocation(heroLocation:int,troopLocation:int,group:int):Point{
			basePoint = battleFieldPosArr[heroLocation];
			targetPoint = DisplayConfig["BATTLEFIELD_AMRY_POINT_"+group][troopLocation];
			point = new Point(basePoint.x+targetPoint.x,basePoint.y+targetPoint.y);
			if(point.x<0 || point.y <0){
				trace("isthe Erro"+heroLocation+" , "+troopLocation);
			}
			return point;
		}
		
		private var roundArr:Array = [];
		/**
		 * 每一个回合的临界点
		 */ 
		private var i:int = 0;
		public function checkIsRoundAction(id:int):Boolean{
			for each(i in roundArr){
				if(id == i)return true;
			}
			return false;
		} 
		
	}
}