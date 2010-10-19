package roma.logic.object.castle
{
	import flash.utils.Dictionary;
	
	import mx.collections.ArrayCollection;
	
	import roma.common.constants.GeneralConstants;
	import roma.common.constants.HeroManConstants;
	import roma.common.events.HeroManUpdate;
	import roma.common.valueObject.HeroManBean;
	import roma.logic.object.hero.HeroObj;
	import roma.message.EvtDispacther;
	import roma.message.events.HerosEvent;
	
	public class HeroManager 
	{
		public var heroArray:ArrayCollection = new ArrayCollection();

		private var _castle:CastleObj;
		private var heroMap:Dictionary=new Dictionary();
		
		public function HeroManager(castle:CastleObj, heroArray:ArrayCollection)
		{
			_castle = castle;
			
			for each(var bean:HeroManBean in heroArray) {
				this.addHero(bean);
			}
		}

		public function heroUpdate(event:HeroManUpdate):void {
			if (event.updateType == GeneralConstants.UPDATE_ADD_TYPE) {
				this.addHero(event.bean);
			} else if(event.updateType == GeneralConstants.UPDATE_UPDATE_TYPE){
				for (var j:int=0; j<this.heroArray.length; j++) {
					if (HeroObj(this.heroArray[j]).heroInfo.id == event.heroManId) {
						HeroObj(heroArray[j]).heroInfo = event.bean.heroInfo;
						break;
					}
				}
			}else if(event.updateType == GeneralConstants.UPDATE_DELETE_TYPE){
				for (var i:int=0; i<this.heroArray.length; i++) {
					if (HeroObj(this.heroArray[i]).heroInfo.id == event.heroManId) {
						heroMap[this.heroArray[i].heroInfo.id]=null;
						this.heroArray.removeItemAt(i);
						break;
					}
				}
			}
			EvtDispacther.instance.dispatchEvent(new HerosEvent(HerosEvent.HERO_UPDATE,event));
		}
		
		private function addHero(bean:HeroManBean):void {
			var hero:HeroObj = new HeroObj(_castle , bean);
			if(heroMap[hero.heroInfo.id]==null){
				this.heroArray.addItem(hero);
			}
		}
		
		public function getBeanById(heroManId:int):HeroObj {
			for each (var obj:HeroObj in  this.heroArray) {
				if (obj.heroInfo.id == heroManId) {
					return obj;
				}
			}
			return null;
		}
		
		public function getChiefHero():HeroObj{
			for each(var hero:HeroObj in this.heroArray){
				if(hero.heroInfo.status == HeroManConstants.STATUS_CHIEF){
					return hero;
				}
			}
			return null; 
		}
		
		public function getFreeChiefHeroAry():ArrayCollection{
			var ary:ArrayCollection = new ArrayCollection();
			for each(var hero:HeroObj in this.heroArray){
				if(hero.heroInfo.status == HeroManConstants.STATUS_FREE || hero.heroInfo.status == HeroManConstants.STATUS_CHIEF){
					ary.addItem(hero);
				}	
			}
			return ary;		
		}
		//检查英雄队列是否有重复
		public function heroArrCheck():void{
			var len:int=this.heroArray.length;
 			for(var i:int=0;i<len;i++){
				for(var j:int=0;j<len;j++){
					if(i==j) continue;
					if(HeroObj(this.heroArray[i]).heroInfo.id==HeroObj(this.heroArray[j]).heroInfo.id){
						this.heroArray.removeItemAt(j);
						len--;
						i--;
						
					}
				}
			}
		}
	}
}