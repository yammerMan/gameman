package roma.logic.object.castle
{
	import flash.utils.Dictionary;
	
	import mx.collections.ArrayCollection;
	
	import roma.common.constants.GeneralConstants;
	import roma.common.events.PostTransportUpdate;
	import roma.common.valueObject.PostTransportBean;
	import roma.logic.RomaConstants;
	
	public class DakManager
	{
		public var dakMap:Dictionary = new Dictionary();
		public var dakList:ArrayCollection = new ArrayCollection();
		
		public function DakManager(dakArray:ArrayCollection)
		{
			for each(var bean:PostTransportBean in dakArray) {
				this.addDak(bean);
			}
		}
		
		private function addDak(bean:PostTransportBean):void {
			this.dakMap[bean.startCastleId+"/"+bean.targetCastleId] = bean;
		}
				
		public function getDak(startCastleId:int,targetCityId:int):PostTransportBean {
			return this.dakMap[startCastleId+"/"+targetCityId] as PostTransportBean;
		}
		
		public function getDakMap():Dictionary{
			return this.dakMap;
		}
		
		public function size():int{
            var length:int = 0;
            for each(var key:* in dakMap)
            {
            	if(key != null){
                length++;}
            }
            return length;
        }
        
        public function getDakList():ArrayCollection{
        	dakList.removeAll();
        	 for each(var key:PostTransportBean in dakMap)
            {
            	if(key != null){
                dakList.addItem(key);
                }
            }
            return dakList;
        }
		
		/**
		 * 驿站更新
		 */
		public function refreshDak(event:PostTransportUpdate):void{
			if (event.updateType == GeneralConstants.UPDATE_ADD_TYPE) {
				this.addDak(event.bean);
			} else if(event.updateType== GeneralConstants.UPDATE_UPDATE_TYPE) {
				this.dakMap[event.bean.startCastleId+"/"+event.bean.targetCastleId] = event.bean;
			}else{
				this.dakMap[event.bean.startCastleId+"/"+event.bean.targetCastleId] = null;
			}
		}
		
		/*public function getResSupply(cityId:int,type:int):int{
			var increase:int=0;
			for each(var post:PostTransportBean in dakList){
				if(post!=null){
					if(post.startCastleId==cityId||post.targetCityId==cityId){
						if(post.startCastleId==cityId){
							switch(type){
								case RomaConstants.RES_TYPE_FOOD:
									increase+=-post.food;
								break;
								
								case RomaConstants.RES_TYPE_WOOD:
									increase+=-post.wood;
								break;
								
								case RomaConstants.RES_TYPE_STONE:
									increase+=-post.stone;
								break;
								
								case RomaConstants.RES_TYPE_IRON:
									increase+=-post.iron;
								break;
								default:
								increase+=0;
							}
						}else{
							switch(type){
								case RomaConstants.RES_TYPE_FOOD:
									increase+=post.food;
								break;
								
								case RomaConstants.RES_TYPE_WOOD:
									increase+=post.wood;
								break;
								
								case RomaConstants.RES_TYPE_STONE:
									increase+=post.stone;
								break;
								
								case RomaConstants.RES_TYPE_IRON:
									increase+=post.iron;
								break;
								default:
								increase+=0;
							}
						}
					}
				}
			}
			return increase;
		}*/
	}
}