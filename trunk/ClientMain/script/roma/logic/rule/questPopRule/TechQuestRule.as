package roma.logic.rule.questPopRule{
	import flash.xml.XMLNode;
	
	import roma.logic.object.tech.TechHelper;
	import roma.util.MultiLang;
	/**
	 * 科技任务目标
	 */
	public class TechQuestRule implements IQuestTargetRule{
		
		private static var T:String;
		
		public function TechQuestRule(x:XMLNode):void {
			T = "";
//			for each(var techX:XMLNode in x){
				var techN:String = TechHelper.instance.getTechName(x.attributes.techType);
				T = MultiLang.msg("quest.tech{0}{1}",techN,x.attributes.level);
//			}
		}

		public function getName():String{
			return T;
		}
	}
}