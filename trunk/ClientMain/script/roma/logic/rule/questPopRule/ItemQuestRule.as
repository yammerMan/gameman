package roma.logic.rule.questPopRule{
	import flash.xml.XMLNode;
	
	import mx.resources.IResourceManager;
	import mx.resources.ResourceManager;
	
	import roma.util.MultiLang;
	/**
	 * 物品类任务目标
	 */
	public class ItemQuestRule implements IQuestTargetRule{
		private static var I:String ;
		public function ItemQuestRule(x:XMLNode):void {
			I = "";
			var rm:IResourceManager = ResourceManager.getInstance();
			
			var itemN:String = rm.getString("item",x.attributes.itemId+".name");
			I = MultiLang.msg("quest.hasItem.{0}{1}",itemN,x.attributes.count);
		}
		
		public function getName():String {
			return I;
		}
	}
}