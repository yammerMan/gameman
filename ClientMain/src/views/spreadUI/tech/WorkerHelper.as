package views.spreadUI.tech
{
	import flash.utils.Dictionary;
	
	import roma.common.constants.WorkerConstant;
	import roma.resource.ImgManager;
	import roma.util.MultiLang;
	
	public class WorkerHelper
	{
		public static var instance:WorkerHelper= new WorkerHelper();
		
		private  var  workerTypeMap:Dictionary = new Dictionary();
		
		public function WorkerHelper()
		{
			initWorkerMap();
		}
		
		private function initWorkerMap():void{
			workerTypeMap[WorkerConstant.FARMER_WORKER_TYPE]     =     "farmer";
			workerTypeMap[WorkerConstant.MINER_WORKER_TYPE]      =     "miner";
			workerTypeMap[WorkerConstant.STONEMASON_WORKER_TYPE] =     "stonemason";
			workerTypeMap[WorkerConstant.WOODCUTTER_WORKER_TYPE] =     "woodcutter";
		}
		
		public function getWorkerName(type:int):String{
			var str:String="";
			switch(type){
				case WorkerConstant.FARMER_WORKER_TYPE:
					str=MultiLang.msg("worker.farmer.name");
				break;
				
				case WorkerConstant.WOODCUTTER_WORKER_TYPE:
					str=MultiLang.msg("worker.woodcutter.name");
				break;
				
				case WorkerConstant.STONEMASON_WORKER_TYPE:
					str=MultiLang.msg("worker.stonemason.name");
				break;
				
				case WorkerConstant.MINER_WORKER_TYPE:
					str=MultiLang.msg("worker.miner.name");
				break;
				
				default:
				
			}
			return str;
		}

		public function getResourceName(type:int):String{
			var str:String="";
			switch(type){
				case WorkerConstant.FARMER_WORKER_TYPE:
					str=MultiLang.msg("building.farm.name");
				break;
				
				case WorkerConstant.WOODCUTTER_WORKER_TYPE:
					str=MultiLang.msg("building.sawmill.name");
				break;
				
				case WorkerConstant.STONEMASON_WORKER_TYPE:
					str=MultiLang.msg("building.quarry.name");
				break;
				
				case WorkerConstant.MINER_WORKER_TYPE:
					str=MultiLang.msg("building.ironMine.name");
				break;
				
				default:
				
			}
			return str;
		}
		
		public function getWorkerUnitName(type:int):String{
			var key:String = workerTypeMap[type];
			return MultiLang.msg('worker.'+key+".unit");
		}
		
		public function getWorkerIcon(type:int):String{
			var key:String = workerTypeMap[type];
			return ImgManager.clazz('worker.'+key+'.icon');
		}
		
		public function getWorkerDesc(type:int):String{
			var key:String = workerTypeMap[type];
			return MultiLang.msg('worker.'+key+".desc");
		}
		
		public function getWorkerFunc(type:int):String{
			var key:String = workerTypeMap[type];
			return MultiLang.msg('worker.'+key+".func");
		}
	}
}