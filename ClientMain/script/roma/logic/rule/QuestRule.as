package roma.logic.rule
{
	import flash.xml.XMLDocument;
	import flash.xml.XMLNode;
	
	import mx.collections.ArrayCollection;
	import mx.logging.ILogger;
	import mx.logging.Log;
	import mx.resources.IResourceManager;
	import mx.resources.ResourceManager;
	import mx.rpc.xml.SimpleXMLDecoder;
	import mx.utils.XMLUtil;
	
	import roma.logic.CaesaryConfig;
	import roma.logic.rule.questActionRule.FromSiteCollectionRule;
	import roma.logic.rule.questPopRule.IQuestTargetRule;
	
	import views.windows.functionWins.task.TaskConstant;
	
	
	[Bindable]
	public class QuestRule
	{
		public var taskId:int = -99;
		public var questName:String = "";
		public var questDescription:String = "";
		public var questManual:String = "";
		public var isFinish:Boolean = false;
		public var targetBeanList:ArrayCollection = new ArrayCollection();
		public var targetList:ArrayCollection = new ArrayCollection();
		public var getAwardStr:String = "";
		public var questionList:ArrayCollection = new ArrayCollection();
		public var favoriteName:String = "";
		/* public var isAddFavorite:Boolean = false;
		public var isFromFavorite:Boolean = false;
		public var favoriteUrl:String =""; */
		
		private static var log:ILogger = Log.getLogger("roma.logic.rule.QuestRule");
		
		public function QuestRule(id:int,target:String,getAward:String)
		{
			this.taskId = id;
			var rm:IResourceManager = ResourceManager.getInstance();
			this.questName = rm.getString("quest",id+".name");
//			log.debug(id+".name "+questName);
			this.questDescription = rm.getString("quest",id+".description");
			this.questManual = rm.getString("quest",id+".manual");
			
			resolveTarget(target);
			resolveAward(getAward);
		}
		
		private function resolveTarget(param:String):void{
			var targetXml:XMLDocument = XMLUtil.createXMLDocument(param);
			targetList.removeAll();
			var questionCount:int = 0;
			favoriteName = "";
			var iqr:IQuestTargetRule;
			for each(var x:XMLNode in targetXml.firstChild.childNodes){
				if(x.nodeName != null){
					if(x.nodeName == "action"){
						if(x.firstChild.nodeName == "fromSiteCollection"){
							// 判断是否url跟收藏的url相同
							var collectionR:FromSiteCollectionRule = new FromSiteCollectionRule();
							if(taskId == TaskConstant.QUEST_FROMCOLLECT){
								targetList.addItem(collectionR.collectUrlStr);
							}
							else{
								targetList.addItem("");
							}
						}
						else{
							for each(var actionX:XMLNode in x.childNodes){
								iqr = IQuestTargetRule(QuestRuleDataFactory.instance.getActionQuestRule(actionX));
								if(iqr != null){
									var str:String = iqr.getName();
		//							log.debug("action "+str);
									targetList.addItem(str);
								}
							}
						}
					}
					else if(x.nodeName == "prop"){
						if(x.firstChild.nodeName == "collectGameSite"){
							// 在这里设定收藏任务
							iqr = IQuestTargetRule(QuestRuleDataFactory.instance.getPropQuestRule(x.firstChild));
							if(iqr != null)
							favoriteName = iqr.getName();
						}else{
							for each(var propX:XMLNode in x.childNodes){
								iqr = IQuestTargetRule(QuestRuleDataFactory.instance.getPropQuestRule(propX));
								if(iqr != null){var str1:String = iqr.getName();
		//							log.debug("prop "+str1);
									targetList.addItem(str1);
								}
							}
						}
					}
					else if(x.nodeName == "questions" ||x.nodeName == "question"){
						questionCount ++;
						questionList.addItem(QuestRuleDataFactory.instance.getTaskion(x,taskId,questionCount));
					}
					else if(x.nodeName == "getAward"){
						
					}
					else{
						if(x.nodeName == "hasItem"){
							// 物品是有多种物品要求的
							for each(var itemX:XMLNode in x.childNodes){
								var str3:String = IQuestTargetRule(QuestRuleDataFactory.instance.getTaskRule(itemX,taskId)).getName();
								targetList.addItem(str3);
							}
						}
						else{
							iqr = IQuestTargetRule(QuestRuleDataFactory.instance.getTaskRule(x,taskId));
							if(iqr != null){
								var str2:String = iqr.getName();
		//						log.debug("others "+str2)
								targetList.addItem(str2);
							}
						}
					}
				}
			}
		}
		
		private function resolveAward(param:String):void{
			var getAwardXml:XMLDocument = XMLUtil.createXMLDocument(param);
			var d:SimpleXMLDecoder = new SimpleXMLDecoder(true);
			var xmlObj:Object = d.decodeXML(getAwardXml);
			getAwardStr = QuestRuleDataFactory.instance.getAward(xmlObj.award);
		}
	}
}