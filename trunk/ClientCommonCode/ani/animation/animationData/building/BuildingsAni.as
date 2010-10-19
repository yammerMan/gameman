package animation.animationData.building
{
	import animation.BaseAnimationData;
	
	public class BuildingsAni
	{
		public function BuildingsAni()
		{
		}
		
		private var _warehouseNormal:WarehouseNormalAni;
		public function get warehouseNormal():WarehouseNormalAni {
			if (this._warehouseNormal ==null) {
				this._warehouseNormal = new WarehouseNormalAni();
			}
			return _warehouseNormal;
		}
		
		private var _barrackNormal:BarrackNormalAni;
		public function get barrackNormal():BarrackNormalAni{
			if(this._barrackNormal == null)
				this._barrackNormal = new BarrackNormalAni();
			return this._barrackNormal;
		}
		
		private var _stableNormal:StableNormalAni;
		public function get stableNormal():StableNormalAni{
			if(this._stableNormal == null)
				this._stableNormal = new StableNormalAni();
			return _stableNormal;
		}
		
		private var _workshopNormal:WorkshopNormalAni;
		public function get workshopNormal():WorkshopNormalAni{
			if(this._workshopNormal == null)
				this._workshopNormal =  new WorkshopNormalAni();
			return _workshopNormal;
		}
		
		private var _amphitheatreNormal:AmphitheatreNormalAni;
		public function get amphitheatreNormal():AmphitheatreNormalAni{
			if(this._amphitheatreNormal == null)
				this._amphitheatreNormal = new AmphitheatreNormalAni();
			return this._amphitheatreNormal;
		}
		
		private var _marketNormal:MarketNormalAni;
		public function get marketNormal():MarketNormalAni{
			if(this._marketNormal == null)
				this._marketNormal = new MarketNormalAni();
			return this._marketNormal;
		}
		
		private var _dakNormal:DakNormalAni;
		public function get dakNormal():DakNormalAni{
			if(this._dakNormal == null)
				this._dakNormal = new DakNormalAni();
			return _dakNormal;
		}
		
		private var _academyNormal:AcademyNormalAni;
		public function get academyNormal():AcademyNormalAni{
			if(this._academyNormal== null)
				this._academyNormal = new AcademyNormalAni();
			return _academyNormal;
		}
		
		private var _militaryInstituteNormal:MilitaryInstituteNormalAni;
		public function get militaryInstituteNormal():MilitaryInstituteNormalAni{
			if(this._militaryInstituteNormal== null)
				this._militaryInstituteNormal = new MilitaryInstituteNormalAni();
			return _militaryInstituteNormal;
		}
		
		private var _templeNormal:TempleNormalAni;
		public function get templeNormal():TempleNormalAni{
			if(this._templeNormal == null)
				this._templeNormal =  new TempleNormalAni();
			return _templeNormal;
		}
		
		private var _trainningFeildNormal:TrainningFeildNormalAni;
		public function get trainningFeildNormal():TrainningFeildNormalAni{
			if(this._trainningFeildNormal== null)
				this._trainningFeildNormal = new TrainningFeildNormalAni();
			return _trainningFeildNormal;
		}
		
		private var _campGeneralTentNormal:CampGeneralTentNormalAni;
		public function get campGeneralTentNormal():CampGeneralTentNormalAni{
			if(this._campGeneralTentNormal== null)
				this._campGeneralTentNormal = new CampGeneralTentNormalAni();
			return _campGeneralTentNormal;
		}
		
		private var _campWallNormal:CampWallNormalAni;
		public function get campWallNormal():CampWallNormalAni{
			if(this._campWallNormal== null)
				this._campWallNormal = new CampWallNormalAni();
			return _campWallNormal;
		}
		
		private var _campDakNormal:CampDakNormalAni;
		public function get campDakNormal():CampDakNormalAni{
			if(this._campDakNormal== null)
				this._campDakNormal = new CampDakNormalAni();
			return _campDakNormal;
		}
		
		private var _campWarehouseNormal:CampWarehouseNormalAni;
		public function get campWarehouseNormal():CampWarehouseNormalAni{
			if(this._campWarehouseNormal == null)
				this._campWarehouseNormal = new CampWarehouseNormalAni();
			return _campWarehouseNormal ;
		}
		
		private var _houseNormal:HouseNormalAni;
		public function get houseNormal():HouseNormalAni{
			if(this._houseNormal == null)
				this._houseNormal = new HouseNormalAni();
			return _houseNormal ;
		}
		
		private var _townHallNormal:TownHannNormalAni;
		public function get townHallNormal():TownHannNormalAni{
			if(this._townHallNormal == null)
				this._townHallNormal = new TownHannNormalAni();
			return _townHallNormal;
		}
		
		private var _farmNormal:FarmNormalAni;
		public function get farmNormal():FarmNormalAni{
			if(this._farmNormal == null)
				this._farmNormal = new FarmNormalAni();
			return _farmNormal;
		}
		
		private var _quarryNormal:QuarryNormalAni;
		public function get quarryNormal():QuarryNormalAni{
			if(this._quarryNormal == null)
				this._quarryNormal = new QuarryNormalAni();
			return _quarryNormal;
		}
		
		private var _ironMineNormal:IronMineNormalAni;
		public function get ironMineNormal():IronMineNormalAni{
			if(this._ironMineNormal == null)
				this._ironMineNormal = new IronMineNormalAni();
			return _ironMineNormal;
		}
		
		private var _sawmillNormal:SawmillNormalAni;
		public function get sawmillNormal():SawmillNormalAni{
			if(this._sawmillNormal == null)
				this._sawmillNormal = new SawmillNormalAni();
			return _sawmillNormal ;
		}
		
		private var _frontFenceAni:FrontFenceAni;
		public function get frontFenceAni():FrontFenceAni{
			if(this._frontFenceAni == null)
				this._frontFenceAni = new FrontFenceAni();
			return _frontFenceAni ;
		}
		
		private var _backFenceAni:BackFenceAni;
		public function get backFenceAni():BackFenceAni{
			if(this._backFenceAni == null)
				this._backFenceAni = new BackFenceAni();
			return _backFenceAni;
		}
		
		private var _townHallFrontFenceAni:TownHallFrontFenceAni;
		public function get townHallFrontFenceAni():TownHallFrontFenceAni{
			if(this._townHallFrontFenceAni == null)
				this._townHallFrontFenceAni = new TownHallFrontFenceAni();
			return _townHallFrontFenceAni;
		}
		
		private var _townHallBackFenceAni:TownHallBackFenceAni;
		public function get townHallBackFenceAni():TownHallBackFenceAni{
			if(this._townHallBackFenceAni == null)
				this._townHallBackFenceAni = new TownHallBackFenceAni();
			return _townHallBackFenceAni;
		}
		
		private var _workingPeople:WorkingPeopleAni;
		public function get workingPeople():WorkingPeopleAni{
			if(this._workingPeople == null)
				this._workingPeople = new WorkingPeopleAni();
			return _workingPeople ;
		}
		
		private var _workingPeople1:WorkingPeopleAniSec;
		public function get workingPeople1():WorkingPeopleAniSec{
			if(this._workingPeople1 == null)
				this._workingPeople1 = new WorkingPeopleAniSec();
			return _workingPeople1;
		}
		
		private var _fountainAni:FountainAni;
		public function get fountainAni():FountainAni{
			if(this._fountainAni == null)
				this._fountainAni =  new FountainAni();
			return _fountainAni ;
		}

	}
}