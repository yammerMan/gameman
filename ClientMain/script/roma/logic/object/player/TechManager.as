package roma.logic.object.player
{
	import flash.utils.Dictionary;
	
	import mx.collections.ArrayCollection;
	
	import roma.common.constants.BuildingConstant;
	import roma.common.constants.TechConstant;
	import roma.common.events.TechUpdate;
	import roma.common.valueObject.TechBean;
	import roma.logic.GameContext;
	import roma.logic.object.tech.BaseTechObj;
	import roma.logic.object.tech.impl.Architecture;
	import roma.logic.object.tech.impl.DefenceSkill;
	import roma.logic.object.tech.impl.Encampment;
	import roma.logic.object.tech.impl.EquestrianSkill;
	import roma.logic.object.tech.impl.Estates;
	import roma.logic.object.tech.impl.FabricationTechnique;
	import roma.logic.object.tech.impl.Farming;
	import roma.logic.object.tech.impl.InfantrySkill;
	import roma.logic.object.tech.impl.Leadership;
	import roma.logic.object.tech.impl.Learning;
	import roma.logic.object.tech.impl.Logistics;
	import roma.logic.object.tech.impl.MarchAbility;
	import roma.logic.object.tech.impl.MedicalTechnology;
	import roma.logic.object.tech.impl.Metallurgy;
	import roma.logic.object.tech.impl.Quarrying;
	import roma.logic.object.tech.impl.RepairTechniques;
	import roma.logic.object.tech.impl.Scouting;
	import roma.logic.object.tech.impl.SupplySkill;
	import roma.logic.object.tech.impl.Warehousing;
	import roma.logic.object.tech.impl.LumberCutting;
	import roma.message.EvtDispacther;
	import roma.message.events.TecStatusChangeEvent;
	
	public class TechManager
	{
		public var techObjArray:ArrayCollection = new ArrayCollection();
		
		private var techMap:Dictionary = new Dictionary();

		//民用科技
		public var peopleTechAry:ArrayCollection = new ArrayCollection();
		//军用科技
		public var armyTechAry:ArrayCollection = new ArrayCollection();
		
		public function TechManager(techArray:ArrayCollection)
		{
			for each(var bean:TechBean in techArray) {
				this.addTechObj(bean);
			}
			
			this.divisionTechType();		
		}
		
		public function updateTech(event:TechUpdate):void {
			var obj:BaseTechObj = this.techMap[event.techBean.typeId] as BaseTechObj;
			if (obj==null) {
				this.addTechObj(event.techBean);	
			} else {
				obj.setBean(event.techBean);
			}
			
			EvtDispacther.instance.dispatchEvent(new TecStatusChangeEvent(obj));		
		}
		
		public function getTechObjById(typeId:int):BaseTechObj {
			return this.techMap[typeId];
		}
		
		private function addTechObj(bean:TechBean):void {
			var obj:BaseTechObj = this.newTechObjInstance(bean);
			this.techObjArray.addItem(obj);
			this.techMap[bean.typeId] = obj;
		}
		
		/**
		 *民用、军用科技分类 
		 */
		private function divisionTechType():void{
			for(var t:int =0;t<this.techObjArray.length;t++){
				if(BaseTechObj(this.techObjArray.getItemAt(t)).techKind == BuildingConstant.TYPE_ACADEMY_BUILDING){
					this.peopleTechAry.addItem(this.techObjArray.getItemAt(t));
				}else{
					this.armyTechAry.addItem(this.techObjArray.getItemAt(t));
				}
			}
		}
				
		private function newTechObjInstance(techBean:TechBean):BaseTechObj{
			var res:BaseTechObj;
			
			switch (techBean.typeId) {
				case TechConstant.ARCHITECTURE :
					res = new Architecture();
					break;				
				case TechConstant.DEFENCE_SKILL :
					res = new DefenceSkill();
					break;				
				case TechConstant.ENCAMPMENT :
					res = new Encampment();
					break;				
				case TechConstant.EQUESTRIAN_SKILL :
					res = new EquestrianSkill();
					break;				
				case TechConstant.ESTATES :
					res = new Estates();
					break;				
				case TechConstant.FABRICATION_TECHNIQUE :
					res = new FabricationTechnique();
					break;				
				case TechConstant.FARMING :
					res = new Farming();
					break;				
				case TechConstant.INFANTRY_SKILL :
					res = new InfantrySkill();
					break;				
				case TechConstant.LEADERSHIP :
					res = new Leadership();
					break;				
				case TechConstant.LEARNING :
					res = new Learning();
					break;				
				case TechConstant.LOGISTICS :
					res = new Logistics();
					break;				
				case TechConstant.MARCH_ABILITY :
					res = new MarchAbility();
					break;				
				case TechConstant.MEDICAL_TECHNOLOGY :
					res = new MedicalTechnology();
					break;				
				case TechConstant.METALLURGY :
					res = new Metallurgy();
					break;				
				case TechConstant.QUARRYING :
					res = new Quarrying();
					break;				
				case TechConstant.REPAIR_TECHNIQUES :
					res = new RepairTechniques();
					break;				
				case TechConstant.SCOUTING :
					res = new Scouting();
					break;				
				case TechConstant.SUPPLY_SKILL_TYPE :
					res = new SupplySkill();
					break;				
				case TechConstant.WAREHOUSING :
					res = new Warehousing();
					break;				
				case TechConstant.WOODCUTTING :
					res = new LumberCutting();
					break;				
			}
			
			res.setBean(techBean);
			return res;
		} 

	}
}