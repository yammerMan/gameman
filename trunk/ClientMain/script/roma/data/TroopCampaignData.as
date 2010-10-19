package roma.data
{
	import roma.common.constants.BattleConstants;
	import roma.logic.GameContext;
	import roma.util.MultiLang;
	
	public class TroopCampaignData
	{
		public var playerName:String;
		public var fieldX:int;
		public var fieldY:int;
		public var fieldName:String;
		public var canAttack:Boolean;
		public var canTransport:Boolean;
		public var canReinforce:Boolean;
		public var missionType:int;
		public var arrivedTime:Number;
		
		public function TroopCampaignData()
		{
		}
		
		public function getTargetName():String {
			return this.fieldName + "[" + this.fieldX + "," + this.fieldY + "]";
		}
		
		public function getFieldId():int {
			return GameContext.getFieldId(this.fieldX,this.fieldY);
		}
		
		public function getMapTileData():MapTileData{
			var mapTileData:MapTileData=new MapTileData();
			mapTileData.fieldX=this.fieldX;
			mapTileData.fieldY=this.fieldY;
			mapTileData.fieldName=this.fieldName;
			mapTileData.canAttack=this.canAttack;
			mapTileData.canTransport=this.canTransport;
			mapTileData.canReinforce=this.canReinforce;
			mapTileData.missionType=this.missionType;
			return mapTileData;
		}
		public function getMissionName():String{
			var missionName:String="";
			if (this.missionType == BattleConstants.ARMY_MISSION_ATTACK) {
				missionName = MultiLang.msg("military.mission.attack");
			} else if(this.missionType == BattleConstants.ARMY_MISSION_REINFORCE){
				missionName = MultiLang.msg("military.mission.reinforce");
			}else{
			    missionName = MultiLang.msg("military.mission.loot");
			}
			return missionName;
		}

	}
}