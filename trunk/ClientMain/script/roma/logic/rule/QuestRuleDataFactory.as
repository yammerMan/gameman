package roma.logic.rule
{
	import flash.xml.XMLNode;
	
	import mx.collections.ArrayCollection;
	import mx.logging.ILogger;
	import mx.logging.Log;
	import mx.resources.ResourceManager;
	import mx.utils.ObjectProxy;
	
	import roma.logic.object.castle.TFHelper;
	import roma.logic.rule.questPopRule.BuildingQuestRule;
	import roma.logic.rule.questPopRule.IQuestTargetRule;
	import roma.logic.rule.questPopRule.ItemQuestRule;
	import roma.logic.rule.questPopRule.QuestRuleHelper;
	import roma.logic.rule.questPopRule.TechQuestRule;
	import roma.util.MultiLang;
	
	import views.spreadUI.tech.WorkerHelper;
	import views.windows.functionWins.task.QuestionBean;
	
	public class QuestRuleDataFactory
	{
		private var log:ILogger = Log.getLogger("roma.logic.rule.QuestRuleDataFactory");
		public static var instance:QuestRuleDataFactory = new QuestRuleDataFactory();

		private var taskId:int =0;		
		public function QuestRuleDataFactory()
		{
		}
		
		/**
		 *  返回其他的任务
		 */ 
		public function getTaskRule(x:XMLNode,id:int):IQuestTargetRule{
			var base:IQuestTargetRule;
			switch(x.nodeName){
				case "hasBuilding":
					base = new BuildingQuestRule(x);
				break;
				case "items":
					base = new ItemQuestRule(x);
				break;
				case "tech":
					base = new TechQuestRule(x);
				break;
				default:
					return null;
			}
			return base;
		}
		
		/**
		 * 奖励返回
		 */ 
		public function getAward(obj:Object):String{
			var o:ObjectProxy = new ObjectProxy(obj);
			var str:String = "";
			str += o.hasOwnProperty('food')?MultiLang.msg("quest.award{0}{1}",MultiLang.msg('label.food'),o.food)+", ":"";
			str += o.hasOwnProperty('wood')?MultiLang.msg("quest.award{0}{1}",MultiLang.msg('label.wood'),o.wood)+", ":"";
			str += o.hasOwnProperty('stone')?MultiLang.msg("quest.award{0}{1}",MultiLang.msg('label.stone'),o.stone)+", ":"";
			str += o.hasOwnProperty('iron')?MultiLang.msg("quest.award{0}{1}",MultiLang.msg('label.iron'),o.iron)+", ":"";
			str += o.hasOwnProperty('gold')?MultiLang.msg("quest.award{0}{1}",MultiLang.msg('label.gold'),o.gold)+", ":"";
			str += o.hasOwnProperty('population')?MultiLang.msg("quest.award{0}{1}",MultiLang.msg('label.population'),o.population)+", ":"";
			str += o.hasOwnProperty('prestige')?MultiLang.msg("quest.award{0}{1}",MultiLang.msg('public.label.prestige'),o.prestige)+", ":"";
			str += o.hasOwnProperty('honor')?MultiLang.msg("quest.award{0}{1}",MultiLang.msg('label.horne'),int(o.honor/3))+", ":"";
			if(o.hasOwnProperty('awardItem')){
				if(o.awardItem is ObjectProxy){
					str += MultiLang.msg("quest.award.item{0}{1}",ResourceManager.getInstance().getString("item",o.awardItem.id+".name"),o.awardItem.count)+", ";
				}
				else if(o.awardItem is ArrayCollection){
					for each(var oo:ObjectProxy in o.awardItem){
						str += MultiLang.msg("quest.award.item{0}{1}",ResourceManager.getInstance().getString("item",oo.id+".name"),oo.count)+", ";
					}
				}
			}
			if(o.hasOwnProperty('army')){
				str += MultiLang.msg("quest.award{0}{1}",TFHelper.instance.getTfName(o.army.type),o.army.count)+", ";
			}
			if(o.hasOwnProperty('cityDefense')){
				str += MultiLang.msg("quest.award{0}{1}",TFHelper.instance.getTfName(o.cityDefense.type),o.cityDefense.count)+", ";
			}
			if(o.hasOwnProperty('worker')){
				if(o.worker is ObjectProxy){
					str += MultiLang.msg("quest.award{0}{1}",WorkerHelper.instance.getWorkerUnitName(o.worker.type),o.worker.count)+", ";
				}else if(o.worker is ArrayCollection){
					for each(var oo2:ObjectProxy in o.worker){
						str += MultiLang.msg("quest.award{0}{1}",WorkerHelper.instance.getWorkerUnitName(oo2.type),oo2.count)+", ";
					}
				}
			}
			str += o.hasOwnProperty('medal')?MultiLang.msg("quest.award{0}{1}",MultiLang.msg('public.label.coin'),o.medal)+", ":"";
			str += o.hasOwnProperty('title_id')?MultiLang.msg('player.title.'+o.title_id)+", ":"";
			return str.substring(0,str.length-2);
		}
		
		/**
		 * 获得问题任务
		 */ 
		public function getTaskion(x:XMLNode,id:int,qid:int):QuestionBean{
			return new QuestionBean(x,id,qid);
		}
		
		/**
		 * 返回行为任务
		 */ 
		public function getActionQuestRule(x:XMLNode):IQuestTargetRule{
			return	QuestRuleHelper.instance.getActionRule(x.nodeName,x);
		}
		/**
		 * 返回目标的任务
		 */ 
		public function getPropQuestRule(x:XMLNode):IQuestTargetRule{
			return	QuestRuleHelper.instance.getPropRule(x.nodeName,x);
		}
		
	}
}