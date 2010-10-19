package roma.logic.rule
{
	import mx.logging.ILogger;
	import mx.logging.Log;
	import mx.resources.IResourceManager;
	import mx.resources.ResourceManager;
	
	[Bindable]
	public class QuestTypeRule
	{
		public var questTypeId:int = 0;
		public var isFinish:Boolean = false;
		public var questTypeName:String = "";
		public var questTypeDescription:String = "";
		
		private var log:ILogger = Log.getLogger("roma.logic.rule.QuestTypeRule");
		
		public function QuestTypeRule(id:int)
		{
			questTypeId = id;
			var rm:IResourceManager = ResourceManager.getInstance();
			questTypeName = rm.getString("questType",id+".name");
			questTypeDescription = rm.getString("questType",id+".description");
//			log.debug(id+".name = "+questTypeName +"    "+ id+".description = "+questTypeDescription);
		}
	}
}