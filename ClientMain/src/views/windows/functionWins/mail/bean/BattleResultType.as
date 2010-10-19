package views.windows.functionWins.mail.bean
{
	import mx.collections.ArrayCollection;
	import mx.utils.ObjectProxy;
	
	[Bindable]
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
		public var battleRound:int;
		
		public var defenderTroop:ArrayCollection = new ArrayCollection();
		public var attackerTroop:ArrayCollection = new ArrayCollection();
		public var replay:ArrayCollection = new ArrayCollection();
		public var wall:ObjectProxy = new ObjectProxy();
		
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
			battleRound = o.hasOwnProperty("round")?o.round:0;
			
			attackerTroop = setBattleTroop(o.attackerTroop);
			defenderTroop = setBattleTroop(o.defenderTroop);
//			replay = setReplay(o.replay);
			wall = o.hasOwnProperty("wall")?o.wall:null;
			
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
		
		/**
		 * 判断是否全灭
		 */ 
		public function getIsAllDead(arr:ArrayCollection):Boolean{
			var a:BattleTroopType;
			var b:ObjectProxy;
			for each(a in arr){
				for each(b in a.troops){
					if(b.count <= b.lose)continue;
					else{return false;}
				}
			}
			return true;
		}
		
		private function setBattleTroop(o:Object):ArrayCollection{
			var arr:ArrayCollection = new ArrayCollection();
			if(o is ObjectProxy){
				var b:BattleTroopType = new BattleTroopType(o);
				arr.addItem(b);
			}else if(o is ArrayCollection){
				for each(var oo:Object in o){
					var bb:BattleTroopType = new BattleTroopType(oo);
					arr.addItem(bb);
				}
			}
			return arr;
		}
		
		private function setReplay(o:Object):ArrayCollection{
			var arr:ArrayCollection = new ArrayCollection();
			if(o is ObjectProxy){
				var b:ReplayType  = new ReplayType(o);
				arr.addItem(b);
			}else if(o is ArrayCollection){
				for each(var oo:Object in o){
					var bb:ReplayType = new ReplayType(oo);
					arr.addItem(bb);
				}
			} 
			return arr;

		}

	}
}