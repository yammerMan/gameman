package roma.logic.rule.questPopRule{
	import flash.xml.XMLNode;
	
	import roma.logic.object.building.BuildingHelper;
	import roma.util.MultiLang;
	/**
	 * 建筑物任务目标规则
	 */
	public class BuildingQuestRule implements IQuestTargetRule{
		private static var B:String;
		public function BuildingQuestRule(x:XMLNode):void{
			var bn:String = BuildingHelper.instance.getName(x.attributes.buildingType);
			B = MultiLang.msg("quest.hasbuilding.{0}.{1}.lev",bn,x.attributes.level); 
		}
		
		public function getName():String {
			return B;
		}
	}
}