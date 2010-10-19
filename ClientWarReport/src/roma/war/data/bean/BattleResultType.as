package roma.war.data.bean
{
//	import mx.collections.ArrayCollection;
	import mx.collections.ArrayCollection;
	import mx.utils.ObjectProxy;
	
	public class BattleResultType
	{
		public var battleMission:int;
		public var battleFieldId:int;
		public var battleFieldType:int;
		public var battleFieldLevel:int;
		public var battleFieldName:String;
		public var battleFieldLogo:String;
		public var battleFieldPlayer:String;
		public var isAttackSuccess:Boolean;
		public var round:int;
		
 		public var defenderTroop:ArrayCollection = new ArrayCollection();
		public var attackerTroop:ArrayCollection = new ArrayCollection(); 
		public var wall:ObjectProxy = new ObjectProxy();
		
		public var replay:ArrayCollection = new ArrayCollection();
		
		public var frames:Frames = new Frames();
		
		public function BattleResultType(o:Object)
		{
			battleMission = o.battleMission;
			battleFieldId = o.battleFieldId;
			battleFieldType = o.battleFieldType;
			battleFieldLevel = o.battleFieldLevel;
			battleFieldName = o.battleFieldName;
			battleFieldLogo = o.battleFieldLogo;
			battleFieldPlayer = o.hasOwnProperty('battleFieldPlayer')?o.battleFieldPlayer:null;
			isAttackSuccess = o.isAttackSuccess;
			round = o.hasOwnProperty("round")?o.round:0;
			
			attackerTroop = setBattleTroop(o.attackerTroop,true);
			defenderTroop = setBattleTroop(o.defenderTroop);
			replay = setReplay(o.replay);
			wall = o.hasOwnProperty("wall")?o.wall:null;
			
			setFrames();
		}
		
		public function getAttackerTroop(key:int):BattleTroopType{
			var b:BattleTroopType = null;
			for each(var t:BattleTroopType in attackerTroop){
				if(t.key == key){
					b = t;
					break;
				}
			}
			return b;
		}
		
		public function getDefenderTroop(key:int):BattleTroopType{
			var b:BattleTroopType = null;
			for each(var t:BattleTroopType in defenderTroop){
				if(t.key == key){
					b = t;
					break;
				}
			}
			return b;
		}
		
 		private function setBattleTroop(o:Object,isAtt:Boolean = false):ArrayCollection{
			var arr:ArrayCollection = new ArrayCollection();
			if(o is ObjectProxy){
				var b:BattleTroopType = new BattleTroopType(o,isAtt);
				arr.addItem(b);
			}else if(o is ArrayCollection){
				for each(var oo:Object in o){
					var bb:BattleTroopType = new BattleTroopType(oo,isAtt);
					arr.addItem(bb);
				}
			}
			return arr;
		}
		
		private function setReplay(o:Object):ArrayCollection{
			var arr:ArrayCollection = new ArrayCollection();
			if(o is ObjectProxy){
				arr.addItem(o);
			}else if(o is String){
				arr.addItem(o);
			}
			else if(o is ArrayCollection){
				for each(var oo:Object in o){
					arr.addItem(oo);
				}
			} 
			return arr;
		} 
		
		private function setFrames():void{
			for(var i:int=0;i<replay.length;i++){
				frames.addRound(String(replay[i]));
			}
		}
		
	}
}