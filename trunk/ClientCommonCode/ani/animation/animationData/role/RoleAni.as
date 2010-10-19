package animation.animationData.role
{
	import animation.BaseAnimationData;
	
	public class RoleAni
	{
		private var _foodWorkerAni:FoodWorkerAni;
		private var _woodWorkerAni:LumberWorkerAni;
		private var _stoneWorkerAni:StoneWorkerAni;
		private var _ironWorkerAni:IronWorkerAni;
		
		private var _workerWalking:WorkerWalkingAni;
		private var _workerWalking1:WorkerWalkingAni1;
		private var _workerWalking2:WorkerWalkingAni2;
		private var _workerWalking3:WorkerWalkingAni3;

		private var _foodWorkerWalking:CropsWorkerWalkingAni;
		private var _foodWorkerWalking1:CropsWorkerWalkingAni1;
		
		private var _woodWorkerWalking:LumberWorkerWalkingAni;
		private var _woodWorkerWalking1:LumberWorkerWalkingAni1;

		private var _stoneWorkerWalking:StoneWorkerWalkingAni;
		private var _stoneWorkerWalking1:StoneWorkerWalkingAni1;

		private var _ironWorkerWalking:IronWorkerWalkingAni;
		private var _ironWorkerWalking1:IronWorkerWalkingAni1;
		
		private var _womanWalking:WomanWalkingAni; 
		
		public function RoleAni()
		{
		}
		
		public function get foodWorkerAni():FoodWorkerAni{
			if(this._foodWorkerAni == null){
				this._foodWorkerAni = new FoodWorkerAni();
			}
			return _foodWorkerAni;
		}
		public function get woodWorkerAni():LumberWorkerAni{
			if(this._woodWorkerAni == null)
				this._woodWorkerAni = new LumberWorkerAni();
			return this._woodWorkerAni;
		}
		public function get stoneWorkerAni():StoneWorkerAni{
			if(this._stoneWorkerAni == null)
				this._stoneWorkerAni = new StoneWorkerAni();
			return this._stoneWorkerAni;
		}
		public function get ironWorkerAni():IronWorkerAni{
			if(this._ironWorkerAni == null)
				this._ironWorkerAni = new IronWorkerAni();
			return  this._ironWorkerAni;
		}
		public function get workerWalking():WorkerWalkingAni{
			if(this._workerWalking == null)
				_workerWalking = new WorkerWalkingAni();
			return _workerWalking;
		}
		public function get workerWalking1():WorkerWalkingAni1{
			if(this._workerWalking1 == null)
				this._workerWalking1 = new WorkerWalkingAni1();
			return this._workerWalking1
		}
		public function get workerWalking2():WorkerWalkingAni2{
			if(this._workerWalking2 == null)
				this._workerWalking2 = new WorkerWalkingAni2();;
			return this._workerWalking2
		}
		public function get workerWalking3():WorkerWalkingAni3{
			if(this._workerWalking3 == null)
				this._workerWalking3 = new WorkerWalkingAni3();
			return _workerWalking3 
		}
		public function get foodWorkerWalking():CropsWorkerWalkingAni{
			if(this._foodWorkerWalking == null)
				this._foodWorkerWalking = new CropsWorkerWalkingAni();
			return _foodWorkerWalking ;
		}
		public function get foodWorkerWalking1():CropsWorkerWalkingAni1{
			if(this._foodWorkerWalking1 == null) 
				_foodWorkerWalking1 = new CropsWorkerWalkingAni1();
			return _foodWorkerWalking1;
		}
		public function get woodWorkerWalking():LumberWorkerWalkingAni{
			if(this._woodWorkerWalking == null)
				this._woodWorkerWalking =  new LumberWorkerWalkingAni();
			return _woodWorkerWalking;
		}
		public function get woodWorkerWalking1():LumberWorkerWalkingAni1{
			if(this._woodWorkerWalking1 == null)
				this._woodWorkerWalking1 = new LumberWorkerWalkingAni1();
			return _woodWorkerWalking1 ;
		}
		public function get stoneWorkerWalking():StoneWorkerWalkingAni{
			if(this._stoneWorkerWalking == null)
				this._stoneWorkerWalking = new StoneWorkerWalkingAni();
			return this._stoneWorkerWalking ;
		}
		public function get stoneWorkerWalking1():StoneWorkerWalkingAni1{
			if(this._stoneWorkerWalking1 == null)
				this._stoneWorkerWalking1 = new StoneWorkerWalkingAni1();
			return _stoneWorkerWalking1 ;
		}
		public function get ironWorkerWalking():IronWorkerWalkingAni{
			if(this._ironWorkerWalking == null)
				this._ironWorkerWalking = new IronWorkerWalkingAni();
			return this._ironWorkerWalking ;
		}
		public function get ironWorkerWalking1():IronWorkerWalkingAni1{
			if(this._ironWorkerWalking1 == null)
				this._ironWorkerWalking1 = new IronWorkerWalkingAni1();
			return this._ironWorkerWalking1 ;
		}
		public function get womanWalking():WomanWalkingAni{
			if(this._womanWalking == null)
				this._womanWalking = new WomanWalkingAni() ;
			return this._womanWalking;
		}
		
	}
}