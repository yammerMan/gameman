/**
* 生成时间 1 
*/

package roma.common.valueObject
{
	import mx.collections.ArrayCollection;
	import framework.util.CopyAryUtil;
	import roma.common.valueObject.*;
	import flash.utils.ByteArray;

	[Bindable]
	public class CityBean
	{
		public function CityBean(data:Object=null)
		{
			if (data!=null){
				if (data.applyHostCastle!=null) {
					this.applyHostCastle = new RelatedCastleTimeBean(data.applyHostCastle);
				}
				if (data.castleInfo!=null) {
					this.castleInfo = new CastleInfoBean(data.castleInfo);
				}
				if (data.castlePopulation!=null) {
					this.castlePopulation = new CastlePopulationBean(data.castlePopulation);
				}
				if (data.castleResource!=null) {
					this.castleResource = new CityResourceBean(data.castleResource);
				}
				if (data.hostCastle!=null) {
					this.hostCastle = new RelatedCastleTimeBean(data.hostCastle);
				}
				if (data.militaryBean!=null) {
					this.militaryBean = new CastleMilitaryBean(data.militaryBean);
				}
				if (data.workerTrainningBean!=null) {
					this.workerTrainningBean = new WorkerTrainningBean(data.workerTrainningBean);
				}
			
				var n:int;
				if (data.applyBeConquestCastles) {
					for (n=0; n<data.applyBeConquestCastles.length; n++) {
						var _applyBeConquestCastles:RelatedCastleTimeBean = new RelatedCastleTimeBean(data.applyBeConquestCastles[n]);
						this.applyBeConquestCastlesArray.addItem(_applyBeConquestCastles);
					}
				}
			
				if (data.architectures) {
					for (n=0; n<data.architectures.length; n++) {
						var _architectures:ArchitectureBean = new ArchitectureBean(data.architectures[n]);
						this.architecturesArray.addItem(_architectures);
					}
				}
			
				if (data.buffers) {
					for (n=0; n<data.buffers.length; n++) {
						var _buffers:BufferBean = new BufferBean(data.buffers[n]);
						this.buffersArray.addItem(_buffers);
					}
				}
			
				if (data.businesses) {
					for (n=0; n<data.businesses.length; n++) {
						var _businesses:BusinessBean = new BusinessBean(data.businesses[n]);
						this.businessesArray.addItem(_businesses);
					}
				}
			
				if (data.conquestCastles) {
					for (n=0; n<data.conquestCastles.length; n++) {
						var _conquestCastles:RelatedCastleTimeBean = new RelatedCastleTimeBean(data.conquestCastles[n]);
						this.conquestCastlesArray.addItem(_conquestCastles);
					}
				}
			
				if (data.fields) {
					for (n=0; n<data.fields.length; n++) {
						var _fields:WildBean = new WildBean(data.fields[n]);
						this.fieldsArray.addItem(_fields);
					}
				}
			
				if (data.fortifications) {
					for (n=0; n<data.fortifications.length; n++) {
						var _fortifications:PairValueBean = new PairValueBean(data.fortifications[n]);
						this.fortificationsArray.addItem(_fortifications);
					}
				}
			
				if (data.goldForCureInjuredTroop) {
					for (n=0; n<data.goldForCureInjuredTroop.length; n++) {
						var _goldForCureInjuredTroop:PairValueBean = new PairValueBean(data.goldForCureInjuredTroop[n]);
						this.goldForCureInjuredTroopArray.addItem(_goldForCureInjuredTroop);
					}
				}
			
				if (data.heroMans) {
					for (n=0; n<data.heroMans.length; n++) {
						var _heroMans:HeroManBean = new HeroManBean(data.heroMans[n]);
						this.heroMansArray.addItem(_heroMans);
					}
				}
			
				if (data.injuredTroops) {
					for (n=0; n<data.injuredTroops.length; n++) {
						var _injuredTroops:PairValueBean = new PairValueBean(data.injuredTroops[n]);
						this.injuredTroopsArray.addItem(_injuredTroops);
					}
				}
			
				if (data.produceQueues) {
					for (n=0; n<data.produceQueues.length; n++) {
						var _produceQueues:ManufactureQueue = new ManufactureQueue(data.produceQueues[n]);
						this.produceQueuesArray.addItem(_produceQueues);
					}
				}
			
				if (data.scouts) {
					for (n=0; n<data.scouts.length; n++) {
						var _scouts:ScoutBean = new ScoutBean(data.scouts[n]);
						this.scoutsArray.addItem(_scouts);
					}
				}
			
				if (data.transingTrades) {
					for (n=0; n<data.transingTrades.length; n++) {
						var _transingTrades:TransingBusinessBean = new TransingBusinessBean(data.transingTrades[n]);
						this.transingTradesArray.addItem(_transingTrades);
					}
				}
			
				if (data.transports) {
					for (n=0; n<data.transports.length; n++) {
						var _transports:TransportBean = new TransportBean(data.transports[n]);
						this.transportsArray.addItem(_transports);
					}
				}
			
				if (data.troops) {
					for (n=0; n<data.troops.length; n++) {
						var _troops:PairValueBean = new PairValueBean(data.troops[n]);
						this.troopsArray.addItem(_troops);
					}
				}
			
			}
		}
		

		public var applyHostCastle:RelatedCastleTimeBean;
		public var castleInfo:CastleInfoBean;
		public var castlePopulation:CastlePopulationBean;
		public var castleResource:CityResourceBean;
		public var hostCastle:RelatedCastleTimeBean;
		public var militaryBean:CastleMilitaryBean;
		public var workerTrainningBean:WorkerTrainningBean;

		public var applyBeConquestCastlesArray:ArrayCollection = new ArrayCollection();
		public var architecturesArray:ArrayCollection = new ArrayCollection();
		public var buffersArray:ArrayCollection = new ArrayCollection();
		public var businessesArray:ArrayCollection = new ArrayCollection();
		public var conquestCastlesArray:ArrayCollection = new ArrayCollection();
		public var fieldsArray:ArrayCollection = new ArrayCollection();
		public var fortificationsArray:ArrayCollection = new ArrayCollection();
		public var goldForCureInjuredTroopArray:ArrayCollection = new ArrayCollection();
		public var heroMansArray:ArrayCollection = new ArrayCollection();
		public var injuredTroopsArray:ArrayCollection = new ArrayCollection();
		public var produceQueuesArray:ArrayCollection = new ArrayCollection();
		public var scoutsArray:ArrayCollection = new ArrayCollection();
		public var transingTradesArray:ArrayCollection = new ArrayCollection();
		public var transportsArray:ArrayCollection = new ArrayCollection();
		public var troopsArray:ArrayCollection = new ArrayCollection();
			
		public function getApplyBeConquestCastles(index:int):RelatedCastleTimeBean {
			var res:RelatedCastleTimeBean = RelatedCastleTimeBean(this.applyBeConquestCastlesArray[index]);
			return res; 
		}
		public function setApplyBeConquestCastles(bean:RelatedCastleTimeBean, index:int):void {
			this.applyBeConquestCastlesArray[index] = bean;
		}
		public function getArchitectures(index:int):ArchitectureBean {
			var res:ArchitectureBean = ArchitectureBean(this.architecturesArray[index]);
			return res; 
		}
		public function setArchitectures(bean:ArchitectureBean, index:int):void {
			this.architecturesArray[index] = bean;
		}
		public function getBuffers(index:int):BufferBean {
			var res:BufferBean = BufferBean(this.buffersArray[index]);
			return res; 
		}
		public function setBuffers(bean:BufferBean, index:int):void {
			this.buffersArray[index] = bean;
		}
		public function getBusinesses(index:int):BusinessBean {
			var res:BusinessBean = BusinessBean(this.businessesArray[index]);
			return res; 
		}
		public function setBusinesses(bean:BusinessBean, index:int):void {
			this.businessesArray[index] = bean;
		}
		public function getConquestCastles(index:int):RelatedCastleTimeBean {
			var res:RelatedCastleTimeBean = RelatedCastleTimeBean(this.conquestCastlesArray[index]);
			return res; 
		}
		public function setConquestCastles(bean:RelatedCastleTimeBean, index:int):void {
			this.conquestCastlesArray[index] = bean;
		}
		public function getFields(index:int):WildBean {
			var res:WildBean = WildBean(this.fieldsArray[index]);
			return res; 
		}
		public function setFields(bean:WildBean, index:int):void {
			this.fieldsArray[index] = bean;
		}
		public function getFortifications(index:int):PairValueBean {
			var res:PairValueBean = PairValueBean(this.fortificationsArray[index]);
			return res; 
		}
		public function setFortifications(bean:PairValueBean, index:int):void {
			this.fortificationsArray[index] = bean;
		}
		public function getGoldForCureInjuredTroop(index:int):PairValueBean {
			var res:PairValueBean = PairValueBean(this.goldForCureInjuredTroopArray[index]);
			return res; 
		}
		public function setGoldForCureInjuredTroop(bean:PairValueBean, index:int):void {
			this.goldForCureInjuredTroopArray[index] = bean;
		}
		public function getHeroMans(index:int):HeroManBean {
			var res:HeroManBean = HeroManBean(this.heroMansArray[index]);
			return res; 
		}
		public function setHeroMans(bean:HeroManBean, index:int):void {
			this.heroMansArray[index] = bean;
		}
		public function getInjuredTroops(index:int):PairValueBean {
			var res:PairValueBean = PairValueBean(this.injuredTroopsArray[index]);
			return res; 
		}
		public function setInjuredTroops(bean:PairValueBean, index:int):void {
			this.injuredTroopsArray[index] = bean;
		}
		public function getProduceQueues(index:int):ManufactureQueue {
			var res:ManufactureQueue = ManufactureQueue(this.produceQueuesArray[index]);
			return res; 
		}
		public function setProduceQueues(bean:ManufactureQueue, index:int):void {
			this.produceQueuesArray[index] = bean;
		}
		public function getScouts(index:int):ScoutBean {
			var res:ScoutBean = ScoutBean(this.scoutsArray[index]);
			return res; 
		}
		public function setScouts(bean:ScoutBean, index:int):void {
			this.scoutsArray[index] = bean;
		}
		public function getTransingTrades(index:int):TransingBusinessBean {
			var res:TransingBusinessBean = TransingBusinessBean(this.transingTradesArray[index]);
			return res; 
		}
		public function setTransingTrades(bean:TransingBusinessBean, index:int):void {
			this.transingTradesArray[index] = bean;
		}
		public function getTransports(index:int):TransportBean {
			var res:TransportBean = TransportBean(this.transportsArray[index]);
			return res; 
		}
		public function setTransports(bean:TransportBean, index:int):void {
			this.transportsArray[index] = bean;
		}
		public function getTroops(index:int):PairValueBean {
			var res:PairValueBean = PairValueBean(this.troopsArray[index]);
			return res; 
		}
		public function setTroops(bean:PairValueBean, index:int):void {
			this.troopsArray[index] = bean;
		}

		public function copyToBe(target:CityBean):void {
			if (applyHostCastle!=null) {
				this.applyHostCastle.copyToBe(target.applyHostCastle)
			} else {
				target.applyHostCastle = null;
			}
			if (castleInfo!=null) {
				this.castleInfo.copyToBe(target.castleInfo)
			} else {
				target.castleInfo = null;
			}
			if (castlePopulation!=null) {
				this.castlePopulation.copyToBe(target.castlePopulation)
			} else {
				target.castlePopulation = null;
			}
			if (castleResource!=null) {
				this.castleResource.copyToBe(target.castleResource)
			} else {
				target.castleResource = null;
			}
			if (hostCastle!=null) {
				this.hostCastle.copyToBe(target.hostCastle)
			} else {
				target.hostCastle = null;
			}
			if (militaryBean!=null) {
				this.militaryBean.copyToBe(target.militaryBean)
			} else {
				target.militaryBean = null;
			}
			if (workerTrainningBean!=null) {
				this.workerTrainningBean.copyToBe(target.workerTrainningBean)
			} else {
				target.workerTrainningBean = null;
			}
		}
		
		public function toBeObject():Object {
			var obj:Object = new Object();
			obj.applyHostCastle = this.applyHostCastle.toBeObject();
			obj.castleInfo = this.castleInfo.toBeObject();
			obj.castlePopulation = this.castlePopulation.toBeObject();
			obj.castleResource = this.castleResource.toBeObject();
			obj.hostCastle = this.hostCastle.toBeObject();
			obj.militaryBean = this.militaryBean.toBeObject();
			obj.workerTrainningBean = this.workerTrainningBean.toBeObject();
			return obj;
		}

		public function toBeString(pre:String=""):String {
			var str:String = "";
			if (applyHostCastle!=null) {
				str += this.applyHostCastle.toBeString(pre + "applyHostCastle.") ;
			} else {
				str += pre + "applyHostCastle = null\n" ;
			}
			if (castleInfo!=null) {
				str += this.castleInfo.toBeString(pre + "castleInfo.") ;
			} else {
				str += pre + "castleInfo = null\n" ;
			}
			if (castlePopulation!=null) {
				str += this.castlePopulation.toBeString(pre + "castlePopulation.") ;
			} else {
				str += pre + "castlePopulation = null\n" ;
			}
			if (castleResource!=null) {
				str += this.castleResource.toBeString(pre + "castleResource.") ;
			} else {
				str += pre + "castleResource = null\n" ;
			}
			if (hostCastle!=null) {
				str += this.hostCastle.toBeString(pre + "hostCastle.") ;
			} else {
				str += pre + "hostCastle = null\n" ;
			}
			if (militaryBean!=null) {
				str += this.militaryBean.toBeString(pre + "militaryBean.") ;
			} else {
				str += pre + "militaryBean = null\n" ;
			}
			if (workerTrainningBean!=null) {
				str += this.workerTrainningBean.toBeString(pre + "workerTrainningBean.") ;
			} else {
				str += pre + "workerTrainningBean = null\n" ;
			}

			var i:int;
			for (i=0; i<this.applyBeConquestCastlesArray.length; i++) {
				str += this.getApplyBeConquestCastles(i).toBeString(pre + "applyBeConquestCastles[" + i + "].") ;
			}
			
			for (i=0; i<this.architecturesArray.length; i++) {
				str += this.getArchitectures(i).toBeString(pre + "architectures[" + i + "].") ;
			}
			
			for (i=0; i<this.buffersArray.length; i++) {
				str += this.getBuffers(i).toBeString(pre + "buffers[" + i + "].") ;
			}
			
			for (i=0; i<this.businessesArray.length; i++) {
				str += this.getBusinesses(i).toBeString(pre + "businesses[" + i + "].") ;
			}
			
			for (i=0; i<this.conquestCastlesArray.length; i++) {
				str += this.getConquestCastles(i).toBeString(pre + "conquestCastles[" + i + "].") ;
			}
			
			for (i=0; i<this.fieldsArray.length; i++) {
				str += this.getFields(i).toBeString(pre + "fields[" + i + "].") ;
			}
			
			for (i=0; i<this.fortificationsArray.length; i++) {
				str += this.getFortifications(i).toBeString(pre + "fortifications[" + i + "].") ;
			}
			
			for (i=0; i<this.goldForCureInjuredTroopArray.length; i++) {
				str += this.getGoldForCureInjuredTroop(i).toBeString(pre + "goldForCureInjuredTroop[" + i + "].") ;
			}
			
			for (i=0; i<this.heroMansArray.length; i++) {
				str += this.getHeroMans(i).toBeString(pre + "heroMans[" + i + "].") ;
			}
			
			for (i=0; i<this.injuredTroopsArray.length; i++) {
				str += this.getInjuredTroops(i).toBeString(pre + "injuredTroops[" + i + "].") ;
			}
			
			for (i=0; i<this.produceQueuesArray.length; i++) {
				str += this.getProduceQueues(i).toBeString(pre + "produceQueues[" + i + "].") ;
			}
			
			for (i=0; i<this.scoutsArray.length; i++) {
				str += this.getScouts(i).toBeString(pre + "scouts[" + i + "].") ;
			}
			
			for (i=0; i<this.transingTradesArray.length; i++) {
				str += this.getTransingTrades(i).toBeString(pre + "transingTrades[" + i + "].") ;
			}
			
			for (i=0; i<this.transportsArray.length; i++) {
				str += this.getTransports(i).toBeString(pre + "transports[" + i + "].") ;
			}
			
			for (i=0; i<this.troopsArray.length; i++) {
				str += this.getTroops(i).toBeString(pre + "troops[" + i + "].") ;
			}
			

			return str;  
		}
	}
}