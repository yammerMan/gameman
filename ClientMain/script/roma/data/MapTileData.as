package roma.data
{
	import roma.logic.GameContext;
	import roma.logic.object.castle.BattleHelper;
	
	[Bindable]
	public class MapTileData
	{
		public var fieldX:int;
		public var fieldY:int;
		public var fieldName:String;
		
		public var canAttack:Boolean;
		public var scoutable:Boolean;
		public var canTransport:Boolean;
		public var canReinforce:Boolean;
		
		public var missionType:int;
		public var isCastle:Boolean;
		public var isNpc:Boolean;
		
		public var status:int;
		
		/** 联盟关系，以及跟宗主国的联盟关系 **/
		public var relation:int;
		public var hostRelation:int;
		
		/** 宗主附庸关系 **/
		public var hostPlayer:String;
		public var hostFieldId:int;
		
		public var playerName:String;
		public var arrivedTime:Number;
		public var battleId:int;
		
		/** 是否战局已存在，可以加入战局 **/
		public var isJoin:Boolean;
		
		public var heroPhysicalRequest:int;
		
		public function MapTileData()
		{
		}
		
		public function getTargetName():String {
			return this.fieldName + " [" + this.fieldX + "," + this.fieldY + "]";
		}
		
		public function getFieldId():int {
			return GameContext.getFieldId(this.fieldX,this.fieldY);
		}
		
		public function getMissionName():String{
			return BattleHelper.getMissionString(missionType);
		}
		
	}
}