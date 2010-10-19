package roma.war.data
{
	import flash.display.BitmapData;
	
	import roma.common.constants.BattleConstants;
	import roma.common.constants.FieldConstant;
	import roma.common.constants.TroopForConstants;
	import roma.war.constants.ReportConstants;
	import roma.war.resource.EmbedResource;
	import roma.war.resource.MultiLang;
	import roma.war.ui.DisplayConfig;
	
	public class BattleHelper
	{
		public static var instance:BattleHelper = new BattleHelper();
		
		public function BattleHelper()
		{
			
		}
		
		/**
		 * 获得军队的位置点偏移值列表
		 */ 
		public static function getLineUp(tId:int,c:int,g:int):Array{
			var lineUps:Array;
			switch(tId){
				case TroopForConstants.T_ARCHERS:
					lineUps = DisplayConfig["HEROES_TROOPS_POINT_INFANTRY_"+g];
				break;
				case TroopForConstants.T_BALLISTAS:
					lineUps =  DisplayConfig["HEROES_TROOPS_POINT_MECHS_"+g];
				break;
				case TroopForConstants.T_ONAGERS:
					lineUps =  DisplayConfig["HEROES_TROOPS_POINT_MECHS_"+g];
				break;
				case TroopForConstants.T_CAVALRY:
					lineUps =  DisplayConfig["HEROES_TROOPS_POINT_CAVALRY_"+g];
				break;
				case TroopForConstants.T_TRIARII:
					lineUps =  DisplayConfig["HEROES_TROOPS_POINT_INFANTRY_"+g];
				break;
				case TroopForConstants.T_URBAN_COHORT:
					lineUps =  DisplayConfig["HEROES_TROOPS_POINT_INFANTRY_"+g];
				break;
			}
			if(lineUps){
				if(c>0){
					var i:int = instance.getLineState(c);
					return lineUps[i];
				}else{
					return new Array();
				}
			}
			else{
				return new Array();
			}
		}
		
		public static function getTroopScaleNum(c:int):Number{
			var s:int = instance.getLineState(c);
			return DisplayConfig.TROOP_SCALE_NUM[s];
		}
		
		/**
		 * 战争方式（征服、占领...）
		 */ 
		public function getBattleMission(t:int):String{
			switch(t){
				case BattleConstants.ARMY_MISSION_ATTACK:
					return MultiLang.msg('military.mission.attack');
				break;
				case BattleConstants.ARMY_MISSION_CONQUEST:
					return MultiLang.msg('diplomacy.conquest.label');
				break;
				case BattleConstants.ARMY_MISSION_INDEPENDENT:
					return MultiLang.msg('diplomacy.conquest.battle.label');
				break;
				case BattleConstants.ARMY_MISSION_LOOT:
					return MultiLang.msg('military.mission.loot');
				break;
				case BattleConstants.ARMY_MISSION_REINFORCE:
					return MultiLang.msg('military.mission.reinforce');
				break;
				default:
					return "";
			}
		}
		
		/**
		 * 野地名称
		 */ 
		public function getFieldName(fieldType:int, fieldLevel:int=0):String {
			switch (fieldType) {
				case FieldConstant.DESERT_TYPE :
					if(fieldLevel>=1 && fieldLevel<=4){
						return MultiLang.msg("field.desert.1");
					}else if(fieldLevel>=5 && fieldLevel<=8){
						return MultiLang.msg("field.desert.2");
					}else if(fieldLevel >=9 && fieldLevel<=10){
						return MultiLang.msg("field.desert.3");
					}else {
						return MultiLang.msg("field.desert.name");
					}
				case FieldConstant.TYPE_TREES :
					if(fieldLevel>=1 && fieldLevel<=4){
						return MultiLang.msg("field.forest.1");
					}else if(fieldLevel>=5 && fieldLevel<=8){
						return MultiLang.msg("field.forest.2");
					}else if(fieldLevel >=9 && fieldLevel<=10){
						return MultiLang.msg("field.forest.3");
					}else {
						return MultiLang.msg("field.forest.name");
					}

				case FieldConstant.HILL_TYPE :
					if(fieldLevel>=1 && fieldLevel<=4){
						return MultiLang.msg("field.hill.1");
					}else if(fieldLevel>=5 && fieldLevel<=8){
						return MultiLang.msg("field.hill.2");
					}else if(fieldLevel >=9 && fieldLevel<=10){
						return MultiLang.msg("field.hill.3");
					}else {
						return MultiLang.msg("field.hill.name");
					}

				case FieldConstant.LAKE_TYPE :
					if(fieldLevel>=1 && fieldLevel<=4){
						return MultiLang.msg("field.lake.1");
					}else if(fieldLevel>=5 && fieldLevel<=8){
						return MultiLang.msg("field.lake.2");
					}else if(fieldLevel >=9 && fieldLevel<=10){
						return MultiLang.msg("field.lake.3");
					}else {
						return MultiLang.msg("field.lake.name");
					}
				case FieldConstant.TYPE_NPC_FIELD :
					return MultiLang.msg("field.trainingRoom.name");
			}
			return String(fieldType);
		}
		
		/**
		 * 
		 */ 
		public function getAttackMode(t:int):String{
			switch(t){
				case BattleConstants.MELEE_TROOP_ATTACK_MODE_AGGRESSIVE:
					// 近战部队激进攻击
					return MultiLang.msg('troop.attack.aggressive');
				/* case BattleConstants.MELEE_TROOP_ATTACK_MODE_NORMAL
					// 普通攻击
					return Lang.msg();
				case BattleConstants.MELEE_TROOP_ATTACK_MODE_DEFENSE:
					// 防御
					return Lang.msg(); */
				case BattleConstants.MODE_CAVALRY_OVER_ATTACK:
					// 横扫
					return MultiLang.msg('troop.attack.cavalryOver');
				case BattleConstants.MODE_CAVALRY_CROSS_ATTACK:
					// 突袭
					return MultiLang.msg('troop.attack.cavalryCross');
				case BattleConstants.MODE_MELEE:
					// 肉搏
					return MultiLang.msg('troop.attack.melee');
				case BattleConstants.MODE_RANGE:
					// 远程攻击
					return MultiLang.msg('troop.attack.range');
				case BattleConstants.MODE_RANGE_AREA_ATTACK:
					// 散射
					return MultiLang.msg('troop.attack.rangeArea');
				case BattleConstants.MODE_ROCK:
					// 落石
					return MultiLang.msg('troop.attack.rock');
				case BattleConstants.MODE_TRAP:
					// 陷阱
					return MultiLang.msg('troop.attack.trap');
				case BattleConstants.MODE_SIDE:
					// 侧面
					return MultiLang.msg('troop.attack.side');
				case BattleConstants.MODE_BALLISTAS_PIERCS:
					// 弩车的穿透攻击 
					return MultiLang.msg('troop.attack.ballistasPiercs');
				default:
					// 普通攻击
					return MultiLang.msg('troop.attack.normal');
			}
		}
		
		public function getTFName(t:int):String{
			switch(t){
				case BattleConstants.KEY_WALL:
					return MultiLang.msg('tf.wall.name');
				case BattleConstants.KEY_ARROW_TOWER:
					return MultiLang.msg('tf.arrowtower.name');
				case BattleConstants.KEY_ROCK_FALL:
					return MultiLang.msg('tf.rockfall.name');
				case BattleConstants.KEY_TRAP:
					return MultiLang.msg('tf.trap.name');
				case TroopForConstants.T_ARCHERS:
					return MultiLang.msg('tf.archers.name');
				case TroopForConstants.T_BALLISTAS:
					return MultiLang.msg('tf.ballistas.name');
				case TroopForConstants.T_CAVALRY:
					return MultiLang.msg('tf.cavalry.name');
				case TroopForConstants.T_ONAGERS:
					return MultiLang.msg('tf.onagers.name');
				case TroopForConstants.T_TRIARII:
					return MultiLang.msg('tf.triarii.name');
				case TroopForConstants.T_URBAN_COHORT:
					return MultiLang.msg('tf.urban_cohort.name');
					
				default:
				return "";
			}
		}
		
		/**
		 * 英雄位置名称
		 */ 
		public function getBeanPos(p:Number,isAttack:Boolean):String{
			switch(p){
				case 0:
					return isAttack?MultiLang.msg('battle.leftWing.label'):MultiLang.msg('battle.rightWing.label');
				case 1:
					return MultiLang.msg('battle.center.label');
				case 2:
					return isAttack?MultiLang.msg('battle.rightWing.label'):MultiLang.msg('battle.leftWing.label');
				default:
					return "";
			}
		}
		
		/**
		 * 军队位置名称
		 */ 
		public function getArmyPos(p:Number,isAttack:Boolean):String{
			switch(p){
				case 0:
					return MultiLang.msg('battle.troopPos.frontLeft.label');
				case 1:
					return MultiLang.msg('battle.troopPos.frontCenter.label');
				case 2:
					return MultiLang.msg('battle.troopPos.frontRight.label');
				case 3:
					return MultiLang.msg('battle.troopPos.backLeft.label');
				case 4:
					return MultiLang.msg('battle.troopPos.backCenter.label');
				case 5:
					return MultiLang.msg('battle.troopPos.backRight.label');
				default:
					return "";
			}
		}
		
		/**
		 * 城防坐标
		 */ 
		public static function getDefensePoint(k:int):Array{
			switch(k){
				case BattleConstants.KEY_ARROW_TOWER:
					return DisplayConfig.ARROW_TOWER_POINTS;
				case BattleConstants.KEY_ROCK_FALL:
					return DisplayConfig.FALLROCK_POINTS;
				case BattleConstants.KEY_WALL:
					return DisplayConfig.WALL_HIT_POINT;
				default:
					return new Array();
			}
		}
		
		
		/**
		 * 兵种所处偏移位置
		 */ 
		public function getTroopsPoint(t:int,c:int):Array{
			return null;
		}
		
		/**
		 * 死兵
		 */ 
		private var frame:int = 0;
		public function getCorpseBMP(troopId:int,group:int):BitmapData{
			frame= 0;
			switch(troopId){
				case TroopForConstants.T_ARCHERS:
					frame = 1;
				break;
				case TroopForConstants.T_BALLISTAS:
					frame = 4;
				break;
				case TroopForConstants.T_CAVALRY:
					frame = 3;
				break;
				case TroopForConstants.T_ONAGERS:
					frame = 5;
				break;
				case TroopForConstants.T_TRIARII:
					frame = 0;
				break;
				case TroopForConstants.T_URBAN_COHORT:
					frame = 2;
				break;
			}
			if(group == ReportConstants.RED){
				return EmbedResource.instance.getCorpseBMP(frame*2+1);
			}else{
				return EmbedResource.instance.getCorpseBMP(frame*2);
			}
		}  
		
		private function getLineState(c:int):int{
			if(c < 10){
				return 0;
			}
			else if(c < 100){
				return 1;
			}
			else if(c < 1000){
				return 2;
			}
			else if(c < 10000){
				return 3;
			}
			else{
				return 4;
			}
		}
		
		public static function getCountColor(c:int):Number{
			if(c<100){
				return 0xffffff;
			}else if(c <1000){
				return 0xc8ff87;
			}else if(c <10000){
				return 0x00ff00;
			}else if(c <100000){
				return 0x01e9fe
			}else{
				return 0xc000ff;
			}
		}
		
	}
}