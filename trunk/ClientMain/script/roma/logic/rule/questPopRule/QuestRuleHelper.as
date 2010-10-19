package roma.logic.rule.questPopRule
{
	import flash.utils.Dictionary;
	import flash.xml.XMLNode;
	
	import mx.rpc.xml.SimpleXMLDecoder;
	
	import roma.logic.rule.questActionRule.BaseRuleEvent;
	import roma.logic.rule.questActionRule.ChatQuestEvent;
	import roma.logic.rule.questActionRule.ChiefQuestEvent;
	import roma.logic.rule.questActionRule.CureInjuredQuestEvent;
	import roma.logic.rule.questActionRule.HireHeroQuestEvent;
	import roma.logic.rule.questActionRule.MailQuestEvent;
	import roma.logic.rule.questActionRule.NewCastleQuestEvent;
	import roma.logic.rule.questActionRule.PacifyQuestEvent;
	import roma.logic.rule.questActionRule.PlunderCastleQuestRule;
	import roma.logic.rule.questActionRule.PlunderFieldQuestRule;
	import roma.logic.rule.questActionRule.RenameCastleQuestEvent;
	import roma.logic.rule.questActionRule.RenameFlagQuestEvent;
	import roma.logic.rule.questActionRule.ScoutQuestEvent;
	import roma.logic.rule.questActionRule.ShopQuestEvent;
	import roma.logic.rule.questActionRule.TaxationQuestEvent;
	import roma.logic.rule.questActionRule.TexRateQuestEvent;
	import roma.logic.rule.questActionRule.TradeQuestEvent;
	import roma.logic.rule.questActionRule.UpgradeHeroQuestEvent;
	import roma.logic.rule.questActionRule.UseItemQuestEvent;
	import roma.logic.rule.questActionRule.WinInNpcFieldQuestEvent;
	
	
	public class QuestRuleHelper
	{
		public static var instance:QuestRuleHelper = new QuestRuleHelper();
		public var ruleDic:Dictionary = new Dictionary();
		
		public function QuestRuleHelper()
		{
 			ruleDic["useItemAction"] = new UseItemQuestEvent();
			ruleDic["pacifyAction"] = new PacifyQuestEvent();
			ruleDic["taxationAction"]  = new TaxationQuestEvent();
			ruleDic["texRateAction"] = new TexRateQuestEvent();
			ruleDic["renameCityAction"] = new RenameCastleQuestEvent();
			ruleDic["renameFlagAction"] = new RenameFlagQuestEvent();
			ruleDic["tradeAction"] = new TradeQuestEvent();
			ruleDic["chatAction"] = new ChatQuestEvent();
			ruleDic["mailAction"] = new MailQuestEvent();

			ruleDic["upgradeChiefAction"] = new UpgradeHeroQuestEvent();
			ruleDic["armyAction"] = new ScoutQuestEvent();
			ruleDic["plunderField"] = new PlunderFieldQuestRule();
			ruleDic["plunderCastle"] = new PlunderCastleQuestRule();
			ruleDic["newCastleAction"] = new NewCastleQuestEvent();
			ruleDic["shopAction"] = new ShopQuestEvent();
			ruleDic["cureInjuredAction"] = new CureInjuredQuestEvent();
			ruleDic["winInNpcField"] = new WinInNpcFieldQuestEvent();
			
			ruleDic["workerCount"] = new WorkerQuestRule();
			ruleDic["inIncreaseBuildingLimit"] = new InIncreaseBuildingLimit();
			ruleDic["peopleLimit"] = new PeopleLimitQuestRule(); 
			ruleDic["havaGod"] = new GodQuestRule();			
			ruleDic["gotHero"] = new HireHeroQuestEvent();
			ruleDic["gotChief"] = new ChiefQuestEvent();
			ruleDic["inAlliance"] = new AllianceQuestRule();
			ruleDic["fortificationCount"] = new FortificationQuestRule();
			ruleDic["armyCount"] = new ArmyQuestRule();
			ruleDic["seizefield"] = new AttackFieldQuestRule();
			ruleDic["expandCastle"] = new ExpandCastleQuestRule();
			ruleDic["population"] = new PeopleQuestRule();
			ruleDic["food"] = new CropsQuestRule();
			ruleDic["wood"] = new LumberQuestRule();
			ruleDic["stone"] = new StoneQuestRule();
			ruleDic["iron"] = new IronQuestRule();
			ruleDic["goldYield"]= new GoldQuestRule();
			ruleDic["prestige"] = new PrestigeQuestRule();
			ruleDic["honor"] = new HonorQuestRule();
			ruleDic["goldTotal"] = new GoldTotalQuestRule();
			ruleDic["collectGameSite"] = new CollectGameSiteRule();
			ruleDic["haveTransportOut"] = new HaveTransportOutRule();
			ruleDic["conquestCastleNum"] = new ConquestCastleRule();
			ruleDic["title"] = new TitleQuestRule();
		}

		public function getActionRule(qId:String,x:XMLNode):IQuestTargetRule{
			var d:SimpleXMLDecoder = new SimpleXMLDecoder(true);
            var o:Object = d.decodeXML(x);
            if(!ruleDic.hasOwnProperty(qId))return null;
			BaseRuleEvent(ruleDic[qId]).ruleData = o;
			return ruleDic[qId];
		}
		
		public function getPropRule(qId:String,x:XMLNode):IQuestTargetRule{
			var d:SimpleXMLDecoder = new SimpleXMLDecoder(true);
			var o:Object = d.decodeXML(x);
			if(!ruleDic.hasOwnProperty(qId))return null;
			BaseRuleProp(ruleDic[qId]).ruleData = o;
			return ruleDic[qId];
		}
		
		public function getClass(className:String):IQuestTargetRule{
			return null;
		}
	}
}