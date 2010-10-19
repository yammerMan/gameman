package roma.logic.object.tech
{
	import flash.utils.Dictionary;
	
	import roma.common.constants.TechConstant;
	import roma.logic.rule.GameRuleHelper;
	import roma.logic.rule.QuestRule;
	import roma.logic.rule.TechRule;
	import roma.resource.ImgManager;
	import roma.util.MultiLang;
	
	public class TechHelper
	{
		public static var instance:TechHelper = new TechHelper();
		
		private var techTypeMap:Dictionary = new Dictionary();
		
		private var techLevelIconMap:Dictionary = new Dictionary();
		
		private var teckDiscMap:Dictionary=new Dictionary();
		
		public function TechHelper()
		{
			initTechTypeMap();
			initTeckDiscMap();
		}
		
		private function initTechTypeMap():void{
			techTypeMap[TechConstant.ARCHITECTURE]                        = "architecture"; 
			techTypeMap[TechConstant.DEFENCE_SKILL] 					  = "defence_skill"; 
			techTypeMap[TechConstant.ENCAMPMENT]   						  = "encampment"; 					
			techTypeMap[TechConstant.EQUESTRIAN_SKILL]					  = "equestrian_skill"; 		
			techTypeMap[TechConstant.ESTATES] 							  = "estates";  
			techTypeMap[TechConstant.FABRICATION_TECHNIQUE] 			  = "fabrication_technique"; 
			techTypeMap[TechConstant.FARMING] 							  = "farming";  
			techTypeMap[TechConstant.INFANTRY_SKILL]                      = "infantry_skill"; 
			techTypeMap[TechConstant.LEADERSHIP]                          = "leadership"; 
			techTypeMap[TechConstant.LEARNING]                            = "learning"; 
			techTypeMap[TechConstant.LOGISTICS]                           = "logistics"; 
			techTypeMap[TechConstant.MARCH_ABILITY]                       = "march_ability"; 
			techTypeMap[TechConstant.MEDICAL_TECHNOLOGY]                  = "medical_technology"; 
			techTypeMap[TechConstant.METALLURGY]                          = "metallurgy"; 
			techTypeMap[TechConstant.QUARRYING]                           = "quarrying"; 
			techTypeMap[TechConstant.REPAIR_TECHNIQUES]                   = "repair_techniques"; 
			techTypeMap[TechConstant.SCOUTING]                            = "scouting"; 
			techTypeMap[TechConstant.SUPPLY_SKILL_TYPE]                        = "supply_skill"; 
			techTypeMap[TechConstant.WAREHOUSING]                         = "warehousing"; 
			techTypeMap[TechConstant.WOODCUTTING]                         = "woodcutting";  
		}
		
		private function initTeckDiscMap():void{
			teckDiscMap[TechConstant.ARCHITECTURE]                        = "65"; 
			teckDiscMap[TechConstant.DEFENCE_SKILL] 					  = "91"; 					
			teckDiscMap[TechConstant.EQUESTRIAN_SKILL]					  = "87"; 		
			teckDiscMap[TechConstant.ESTATES] 							  = "63";  
			teckDiscMap[TechConstant.FABRICATION_TECHNIQUE] 			  = "88"; 
			teckDiscMap[TechConstant.FARMING] 							  = "59";  
			teckDiscMap[TechConstant.INFANTRY_SKILL]                      = "86"; 
			teckDiscMap[TechConstant.LEADERSHIP]                          = "90"; 
			teckDiscMap[TechConstant.LEARNING]                            = "66"; 
			teckDiscMap[TechConstant.LOGISTICS]                           = "93"; 
			teckDiscMap[TechConstant.MARCH_ABILITY]                       = "94"; 
			teckDiscMap[TechConstant.MEDICAL_TECHNOLOGY]                  = "92"; 
			teckDiscMap[TechConstant.METALLURGY]                          = "62"; 
			teckDiscMap[TechConstant.QUARRYING]                           = "61"; 
			teckDiscMap[TechConstant.REPAIR_TECHNIQUES]                   = "67"; 
			teckDiscMap[TechConstant.SCOUTING]                            = "89"; 
			teckDiscMap[TechConstant.SUPPLY_SKILL_TYPE]                        = "95"; 
			teckDiscMap[TechConstant.WAREHOUSING]                         = "64"; 
			teckDiscMap[TechConstant.WOODCUTTING]                         = "60";  
		}
		
		
		/**
		 * 获取名字
		 * @param techType
		 * @return 
		 */		
		public function getTechName(techType:int):String{
			var key:String = techTypeMap[techType];
			return MultiLang.msg('tech.'+key+".name");
		}
		
		/**
		 * 获取描述
		 * @param techType
		 * @return 
		 */		
		public function getTechDisc(techType:int):String{
			var disc:String="";
			var key:String = techTypeMap[techType];
//			disc+=Lang.msg('tech.'+key+".name");
			disc+="<b><font color="+"\"#370d00"+"\">"+MultiLang.msg('tech.'+key+".name")+"</font></b>";
			disc+="\n\n"+MultiLang.msg('tech.'+key+".desc");
			var keyId:int = int(teckDiscMap[techType]);
			var questRule:QuestRule=GameRuleHelper.instance.getTaskRule(keyId);
			if(questRule!=null){
				disc+="\n\n"+questRule.questDescription;
			}
			return disc;
		}
		
		/**
		 * 获取图标
		 * @param techType
		 * @return 
		 */
		public function getTechIcon(techType:int):String{
			var key:String = techTypeMap[techType];
			return ImgManager.clazz("tech."+key+".icon");
		}
		
		/**
		 * 返回功能说明
		 * @param typeId
		 * @return 
		 */
		public function getFuncDesc(techType:int):String {
			var key:String = techTypeMap[techType];
			return MultiLang.msg('tech.'+key+".desc");
		}
		
		/** 获得科技的功能说明 */
		public function getFuncEffect(techType:int,level:int):String {
			if (level>0 && level < TechConstant.HIGHEST_LEVEL+1) {
				var rule:TechRule = GameRuleHelper.instance.getTechRule(techType,level)
				if(rule.techEffect){
					 return MultiLang.msg("tech." + techTypeMap[techType] + ".effect",level, rule.techEffect);
				}else{
					return MultiLang.msg("tech." + techTypeMap[techType] + ".effect");
				}
			} 
			return "";
		}
		
		/**
		 *获取不同级别的科技图标 
		 * @param level
		 * @return 
		 * 
		 */
		public function getDiffLevelIcon(level:int):Class{
			return ImgManager.clazz("level.background");
		}
		
		/**
		 *获取生效级别的科技图标 
		 * @param level
		 * @return 
		 * 
		 */
		public function getEffectLevelIcon():String{
			return ImgManager.clazz("level.effectLevelBG");
		}
	}
}