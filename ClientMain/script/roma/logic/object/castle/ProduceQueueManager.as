package roma.logic.object.castle
{
	import flash.utils.Dictionary;
	
	import mx.collections.ArrayCollection;
	
	import roma.common.events.ManufactureQueueUpdate;
	import roma.common.valueObject.ManufactureQueue;
	import roma.message.EvtDispacther;
	import roma.message.events.PublicEvent;
	
	public class ProduceQueueManager
	{
		public var produceQueueAry:ArrayCollection;

		private var _castle:CastleObj;
		private var produceQueueMap:Dictionary = new Dictionary();
		
		public function ProduceQueueManager(castle:CastleObj,queueAry:ArrayCollection)
		{
			_castle = castle;
		
			this.produceQueueAry = queueAry;
			this.addProduceQueue();
		}

		public function updateProduceQueue(event:ManufactureQueueUpdate):void{
			this.produceQueueMap[event.produces.positionId] = event.produces;	
						
			EvtDispacther.instance.dispatchEvent(new PublicEvent(EvtDispacther.PRODUCE_UPDATE,event.produces));
		}
		
		private function addProduceQueue():void{
			for each(var queue:ManufactureQueue in this.produceQueueAry){
				this.produceQueueMap[queue.positionId] = queue;
			}
		}
		
		public function getProducesAry(position:int):ArrayCollection{
			if(this.produceQueueMap[position] !=null){
				return ManufactureQueue(produceQueueMap[position]).producesArray;
			}
			return new ArrayCollection();
		}
	}
}