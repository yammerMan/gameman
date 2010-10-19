package animation.animationData
{
	import animation.BaseAnimationData;
	import animation.animationData.worldMap.*;
	
	import flash.utils.Dictionary;
	
	public class FieldAni
	{
		private var _desert1:Desert1Ani;
		public function get desert1():Desert1Ani{
			if(_desert1 == null)
				_desert1 = new Desert1Ani();
			return _desert1;
		}
		
		private var _desert2:Desert2Ani;
		public function get desert2():Desert2Ani{
			if(_desert2 == null)
				_desert2 = new Desert2Ani();
			return _desert2;
		}

		private var _desert3:Desert3Ani;
		public function get desert3():Desert3Ani{
			if(_desert3 == null)
				_desert3 = new Desert3Ani();
			return _desert3;
		}
		
		private var _hill1:Hill1Ani;
		public function get hill1():Hill1Ani{
			if(_hill1 == null)
				_hill1 = new Hill1Ani();
			return _hill1;
		}

		private var _hill2:Hill2Ani;
		public function get hill2():Hill2Ani{
			if(_hill2 == null)
				_hill2 = new Hill2Ani();
			return _hill2;
		}

		private var _hill3:Hill3Ani;
		public function get hill3():Hill3Ani{
			if(_hill3 == null)
				_hill3 = new Hill3Ani();
			return _hill3;
		}

		private var _forest1:Forest1Ani;
		public function get forest1():Forest1Ani{
			if(_forest1 == null)
				_forest1 = new Forest1Ani();
			return _forest1;
		}

		private var _forest2:Forest2Ani;
		public function get forest2():Forest2Ani{
			if(_forest2 == null)
				_forest2 = new Forest2Ani();
			return _forest2;
		}

		private var _forest3:Forest3Ani;
		public function get forest3():Forest3Ani{
			if(_forest3 == null)
				_forest3 = new Forest3Ani();
			return _forest3;
		}
		
		private var _castle1:Castle1Ani;
		public function get castle1():Castle1Ani{
			if(_castle1 == null)
				_castle1 = new Castle1Ani();
			return _castle1;
		}
		
		private var _castle2:Castle2Ani;
		public function get castle2():Castle2Ani{
			if(_castle2 == null)
				_castle2 = new Castle2Ani();
			return _castle2;
		}
		
		private var _castle3:Castle3Ani;
		public function get castle3():Castle3Ani{
			if(_castle3 == null)
				_castle3 = new Castle3Ani();
			return _castle3;
		}
		
		private var _castle4:Castle4Ani;
		public function get castle4():Castle4Ani{
			if(_castle4 == null)
				_castle4 = new Castle4Ani();
			return _castle4;
		}
		
		private var _trainingRoom:TrainingRoomAni;
		public function get trainingRoom():TrainingRoomAni{
			if(_trainingRoom == null)
				_trainingRoom = new TrainingRoomAni();
			return _trainingRoom;
		}
		
		private var _kingsCastle:KingsCastleAni;
		public function get kingsCastle():KingsCastleAni{
			if(_kingsCastle == null)
				_kingsCastle = new KingsCastleAni();
			return _kingsCastle;
		}
		
		private var _ratterNpc:RatterNpcAni;
		public function get ratterNpc():RatterNpcAni{
			if(_ratterNpc == null)
				_ratterNpc = new RatterNpcAni();
			return _ratterNpc;
		}
		
		private var _footballField201:FootballField201Ani;
		private var _footballField202:FootballField202Ani;
		private var _footballField203:FootballField203Ani;
		private var footballFieldDic:Dictionary=new Dictionary();
		public function getFootballField(type:int):BaseAnimationData{
			if(footballFieldDic[type] == null){
				switch(type){
					case 201:
					footballFieldDic[type]=new FootballField201Ani();
					break;
					
					case 202:
					footballFieldDic[type]=new FootballField202Ani();
					break;
					
					case 203:
					footballFieldDic[type]=new FootballField203Ani();
					break;
					
					default:
					footballFieldDic[type]=new FootballField201Ani();
				}
			}
			return BaseAnimationData(footballFieldDic[type]);
		}
		
		private var _camp1:Camp1Ani;
		public function get camp1():Camp1Ani{
			if(_camp1 == null)
				_camp1 = new Camp1Ani();
			return _camp1;
		}
		
		private var _camp2:Camp2Ani;
		public function get camp2():Camp2Ani{
			if(_camp2 == null)
				_camp2 = new Camp2Ani();
			return _camp2;
		}
		
		private var _camp3:Camp3Ani;
		public function get camp3():Camp3Ani{
			if(_camp3 == null)
				_camp3 = new Camp3Ani();
			return _camp3;
		}
		
		private var _camp4:Camp4Ani;
		public function get camp4():Camp4Ani{
			if(_camp4 == null)
				_camp4 = new Camp4Ani();
			return _camp4;
		}
		
		private var _battleFumeAni:BattleFumeAni;
		public function get battleFumeAni():BattleFumeAni{
			if(_battleFumeAni == null)
				_battleFumeAni = new BattleFumeAni();
			return _battleFumeAni;
		}
		
		private var _lakeAni:LakeAni;
		public function get lakeAni():LakeAni{
			if(_lakeAni == null)
				_lakeAni = new LakeAni();
			return _lakeAni;
		}
		
	}
}