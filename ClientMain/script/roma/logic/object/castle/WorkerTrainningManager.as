package roma.logic.object.castle
{
	import roma.common.constants.GeneralConstants;
	import roma.common.events.WorkerTrainningUpdate;
	import roma.common.valueObject.WorkerTrainningBean;
	import roma.message.EvtDispacther;
	import roma.message.events.MsgEvent;
	
	import sound.MsgSound;
	
	public class WorkerTrainningManager
	{
		public var workerTrainningBean:WorkerTrainningBean;
		
		public function WorkerTrainningManager(bean:WorkerTrainningBean)
		{
			this.workerTrainningBean = bean;
		}

		public function workerTrainningUpdate(event:WorkerTrainningUpdate):void{
			if(event.updateType == GeneralConstants.UPDATE_DELETE_TYPE){
				this.workerTrainningBean = null;
				MsgSound.instance.playMsgSound();
			}else{
				this.workerTrainningBean = event.bean;
			}
			
			EvtDispacther.instance.dispatchEvent(new MsgEvent(EvtDispacther.WORKER_TRAINNING_UPDATE,event));			
		}
	}
}