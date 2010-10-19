package roma.logic.object.castle
{
	import mx.collections.ArrayCollection;
	import mx.logging.ILogger;
	import mx.logging.Log;
	
	import roma.common.constants.GeneralConstants;
	import roma.common.events.ApplyBeConquestedCastleUpdate;
	import roma.common.events.ConquestCastleUpdate;
	import roma.common.valueObject.RelatedCastleBean;
	import roma.common.valueObject.RelatedCastleTimeBean;
	import roma.logic.GameContext;
	import roma.logic.object.player.ConquestObj;
	import roma.message.EvtDispacther;
	import roma.message.events.ConquestEvent;
	
	public class ConquestManager
	{
		private static var log:ILogger = Log.getLogger("roma.logic.object.castle.conquestManager");
		public var applyBeConquestCastleArray:ArrayCollection = new ArrayCollection();
		public var conquestCastleArray:ArrayCollection = new ArrayCollection();
		/** 申请了谁做宗主  */
		public var applyHostCastle:RelatedCastleBean;
		/** 是否有宗主，即是否被征服了  */
		public var hostCastle:RelatedCastleTimeBean;
		
		public function ConquestManager(cId:int,host:RelatedCastleTimeBean,conquestArr:ArrayCollection,applyArr:ArrayCollection)
		{
			hostCastle = host;
			for each(var c:RelatedCastleTimeBean in conquestArr){
				this.addConquestObj(c,conquestCastleArray,cId);
			}
			for each(var a:RelatedCastleTimeBean in applyArr){
				this.addConquestObj(a,applyBeConquestCastleArray,cId);
			}
		}
		
		public function conquestHostUpdate(data:RelatedCastleTimeBean):void{
			this.hostCastle = data;
			EvtDispacther.instance.dispatchEvent(new ConquestEvent(ConquestEvent.CONQUEST_HOST_UPDATE));
		}
		
		/**
		 * 附庸城列表的更新
		 */ 
		public function updateConqust(castle:CastleObj,event:ConquestCastleUpdate):void{
			if(event.updateType == GeneralConstants.UPDATE_ADD_TYPE){
				this.addConquestObj(event.conquestBean,conquestCastleArray,castle.cityId);
			}
			else{
				for(var i:int=0;i<conquestCastleArray.length;i++){
					if(ConquestObj(conquestCastleArray[i]).relatedCityBean.castle.cityId == event.conquestBean.castle.cityId){
						if(event.updateType == GeneralConstants.UPDATE_DELETE_TYPE){
							conquestCastleArray.removeItemAt(i);
						}
						else if(event.updateType == GeneralConstants.UPDATE_UPDATE_TYPE){
						}
						break;
					}
				}
			}
			EvtDispacther.instance.dispatchEvent(new ConquestEvent(ConquestEvent.CONQUEST_LIST_UPDATE));
		}
		
		/**
		 * 申请为附庸的列表的更新
		 */ 
		public function updateApplyBeConquested(castle:CastleObj,event:ApplyBeConquestedCastleUpdate):void{
			if(event.updateType == GeneralConstants.UPDATE_ADD_TYPE){
				this.addConquestObj(event.conquestBean,applyBeConquestCastleArray,castle.cityId);
			}else{
				for(var i:int=0;i<applyBeConquestCastleArray.length;i++){
					if(ConquestObj(applyBeConquestCastleArray[i]).relatedCityBean.castle.cityId == event.conquestBean.castle.cityId){
						if(event.updateType == GeneralConstants.UPDATE_DELETE_TYPE){
							applyBeConquestCastleArray.removeItemAt(i);
						}
						else if(event.updateType == GeneralConstants.UPDATE_UPDATE_TYPE){
						}
						break;
					}
				}
			}
			EvtDispacther.instance.dispatchEvent(new ConquestEvent(ConquestEvent.APPLY_CONQUEST_UPDATE));
		}
		
		/**判断是否为宗主*/
  		public function isHost(playerName:String):Boolean{
			if(hostCastle==null){
				return false;
			}else{
				if(hostCastle.castle.playerName==playerName){
					return true;
				}else{
					return false;
				}
			}
			return false;
		} 
 		
 		/**
 		 * 是否为宗主城，通过idField判断
 		 */ 
 		public function isHostByFieldId(fId:int):Boolean{
 			if(hostCastle == null)return false;
 			else
 				return hostCastle.castle.fieldId == fId;
 		}
 		
 		/**
 		 * 是否为自己的附庸城
 		 */ 
 		public function isVassalByFieldId(fId:int):Boolean{
 			var arr:ArrayCollection = GameContext.getAllConquestCity();
 			for each(var c:ConquestObj in arr){
 				if(c.relatedCityBean.castle.fieldId == fId)	return true;
 			}
 			return false;
 		}
 		
 		/**
 		 * 获取当前城附庸城列表
 		 */ 
 		public function getCurConquestList(curId:int):ArrayCollection{
 			var arr:ArrayCollection = new ArrayCollection();
 			for each(var i:ConquestObj in conquestCastleArray){
 				if(i.selfCastleId == curId){
 					arr.addItem(i);
 				}
 			}
 			return arr;
 		}
 		
		private function addConquestObj(co:RelatedCastleTimeBean,arr:ArrayCollection,cId:int):void{
			var o:ConquestObj = new ConquestObj(co);
			o.selfCastleId = cId;
			arr.addItem(o);
		}
		
	}
}