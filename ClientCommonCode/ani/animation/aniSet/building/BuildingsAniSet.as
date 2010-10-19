package animation.aniSet.building
{
	import animation.animationData.HorseAni;
	import animation.animationData.SmokeAni;
	import animation.animationData.building.DakFlagAni;
	import animation.animationData.building.DenseSmokeAni;
	import animation.animationData.building.ElevatorAni;
	import animation.animationData.building.FlameAni;
	import animation.animationData.building.JackAni;
	import animation.animationData.building.PenstockAni;
	import animation.animationData.building.PiazzaFlagAni;
	
	public class BuildingsAniSet
	{
		public function BuildingsAniSet()
		{
		}
		
		private var _somkeAni:SmokeAni;
		public function get somkeAni():SmokeAni{
			if(_somkeAni == null)
				_somkeAni = new SmokeAni();
			return _somkeAni;
		}
		
		private var _horseAni:HorseAni;
		public function get horseAni():HorseAni{
			if(_horseAni == null)
				_horseAni = new HorseAni();
			return _horseAni;
		}
		
		private var _jackAni:JackAni;
		public function get jackAni():JackAni{
			if(_jackAni == null)
				_jackAni = new JackAni();
			return _jackAni;
		}
		
		private var _penstockAni:PenstockAni;
		public function get penstockAni():PenstockAni{
			if(_penstockAni == null)
				_penstockAni = new PenstockAni();
			return _penstockAni;
		}
		
		private var _piazzaFlagAni:PiazzaFlagAni;
		public function get piazzaFlagAni():PiazzaFlagAni{
			if(_piazzaFlagAni == null)
				_piazzaFlagAni = new PiazzaFlagAni();
			return _piazzaFlagAni;
		}
		
		private var _flameAni:FlameAni;
		public function get flameAni():FlameAni{
			if(_flameAni == null)
				_flameAni = new FlameAni();
			return _flameAni;
		}
		
		private var _dakflagAni:DakFlagAni;
		public function get dakflagAni():DakFlagAni{
			if(_dakflagAni == null)
				_dakflagAni = new DakFlagAni();
			return _dakflagAni;
		}
		
		private var _elvatorAni:ElevatorAni;
		public function get elvatorAni():ElevatorAni{
			if(_elvatorAni == null)
				_elvatorAni = new ElevatorAni();
			return _elvatorAni;
		}
		
		private var _denseSmokeAni:DenseSmokeAni;
		public function get denseSmokeAni():DenseSmokeAni{
			if(_denseSmokeAni == null)
				_denseSmokeAni = new DenseSmokeAni();
			return _denseSmokeAni;
		}
		
	}
}