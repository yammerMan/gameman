package views.windows.functionWins.mail.ReportUi
{
	import flash.utils.Dictionary;
	import flash.xml.XMLDocument;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.xml.SimpleXMLDecoder;
	import mx.utils.ObjectProxy;
	import mx.utils.StringUtil;
	import mx.utils.XMLUtil;
	
	import roma.common.constants.ConquestedReportConstant;
	import roma.common.constants.FieldConstant;
	import roma.logic.CaesaryConfig;
	import roma.logic.GameContext;
	import roma.logic.object.castle.BattleHelper;
	import roma.logic.object.field.FieldHelper;
	import roma.util.MultiLang;
	
	import views.windows.functionWins.mail.bean.BattleReportType;
	import views.windows.functionWins.mail.bean.ScoutType;
	
	
	public class ReportManager
	{
		public static var instance:ReportManager = new ReportManager();
		public var receiveTime:Number = 0;
		public var reportTitle:String = "";
		public var reportTitleDic:Dictionary = new Dictionary();
		public var url:String = "";
		public var battleReportType:BattleReportType;
		public var scoutType:ScoutType;
		public var reportObj:ObjectProxy;
		
		public var receiveTimeStr:String = "";
		
		public function ReportManager()
		{
		}
		
		/** 战斗结果报告 */
		public function setBattleResultBean(o:Object):void{
			battleReportType = new BattleReportType(o);
		}
		
		/** 战斗过程  */
		public function getReplayList():ArrayCollection{
			return battleReportType.battle.replay;
		}
		
		/**
		 * 侦查报告
		 */ 
		public function setScout(o:Object):void{
			scoutType = new ScoutType(o);
		}
		
		public static function getTitle(id:String):String{
			if(instance.reportTitleDic[id])
			return instance.reportTitleDic[id];
			else
			return "reports";
		}
		
		public static function getBattleUrl(u:String):String{
			var urlDataStr:String = StringUtil.substitute(CaesaryConfig.instance.battleDataUrl,CaesaryConfig.instance.serverIp,u);
			var str:String = StringUtil.substitute(CaesaryConfig.instance.battleUrl,encodeURI(urlDataStr)); 
			return str; 
		}
		
		public static function parseTitleStr(str:String,isAllianceTitle:Boolean=false):String{
			var xmlDoc:XMLDocument = XMLUtil.createXMLDocument(str);
			var d:SimpleXMLDecoder = new SimpleXMLDecoder(true);
	        var xmlObj:Object = d.decodeXML(xmlDoc);
	        var xml:ObjectProxy = new ObjectProxy();
	        if(xmlObj.hasOwnProperty("reportTitle"))
	      	  xml = xmlObj.reportTitle;
	        
			var fId:int;
			var fType:int;
			var bName:String;
			var targetStr:String; 
			var bLev:int;
//			this.styleName="";
			// 主题内容显示
			if (xml.hasOwnProperty("battle")) {
				// 战斗报告
				fId = xml.battle.battleFieldId;
				fType = xml.battle.battleFieldType;
				bName = xml.battle.battleFieldName;
				bLev = xml.battle.battleFieldLevel;
				targetStr = instance.getTargetStr(fId, fType,bName,bLev); 
				if(isAllianceTitle){
					var pName:String=str.slice(0,str.indexOf(":"));
					if(xml.battle.isAttack){
						return MultiLang.msg("report.title.attackBattle{0}" , targetStr,pName);
					}else{
						return MultiLang.msg("report.title.defenceBattle{0}" , targetStr,pName);
					}
				}else{
					return MultiLang.msg("report.title.battle{0}" , targetStr);
				}
				
			}
			else if (xml.hasOwnProperty("armyMove")) {
				// 军队动态
				fId = xml.armyMove.battleFieldId;
				fType = xml.armyMove.battleFieldType;
				bName = xml.armyMove.battleFieldName;
				targetStr = instance.getTargetStr(fId, fType,bName);
				
				var castelFieldId:int = xml.armyMove.castleFieldId;
				var cityName:String = xml.armyMove.castleName;
				var castleStr:String = instance.getTargetStr(castelFieldId, FieldConstant.TYPE_CITY,cityName);
				 
				var heroName:String = xml.armyMove.heroName;
				
				if (xml.armyMove.isBack == true) {
					return MultiLang.msg("report.title.armyMove.back{0}{1}{2}",castleStr, heroName, targetStr);
				} else {
					return MultiLang.msg("report.title.armyMove.forward{0}{1}{2}",castleStr, heroName, targetStr);
				}
			} 
			else if(xml.hasOwnProperty('troopDie')){
				// 军队动乱
				return MultiLang.msg('report.title.troopDie{0}',xml.troopDie.castleName+GameContext.getFieldPostionString(xml.troopDie.castlePo));
			}
			else if(xml.hasOwnProperty('uprising')){
				// 民宗暴乱
				return MultiLang.msg('report.title.uprising{0}',xml.uprising.castleName+GameContext.getFieldPostionString(xml.uprising.castlePo));
			}
			else if(xml.hasOwnProperty('herpEscape')){
				// 英雄逃亡
				return MultiLang.msg('report.title.heroEscape{0}',xml.herpEscape.castleName+GameContext.getFieldPostionString(xml.herpEscape.castlePo));
			}
			else if(xml.hasOwnProperty('tradeFinish')){
				// 市场交易
				if(xml.tradeFinish.isSell == false){
					var buyItemStr:String = MultiLang.msg('report.buyInto.label');
					return MultiLang.msg('report.title.trade{0}',buyItemStr);
				}
				else{
					var sellStr:String = MultiLang.msg('report.sellTo.label');
					return  MultiLang.msg('report.title.trade{0}',sellStr);
				}
			}
			else if(xml.hasOwnProperty('transport')){
				// 运输报告
				if(xml.transport.isReturn == true){
					return MultiLang.msg('report.title.transport.comeBack');
				}
				else{
					return MultiLang.msg('report.title.transport.reach');
				}
			}
			else if(xml.hasOwnProperty('aniScout')){
				// 反侦查
				return MultiLang.msg('report.title.aniScout{0}',xml.aniScout.castleName+GameContext.getFieldPostionString(xml.aniScout.fieldId));
			}
			else if(xml.hasOwnProperty('scout')){
				// 侦查
				if(xml.scout.battleFieldName !=""){
					return MultiLang.msg('report.title.scout{0}',xml.scout.battleFieldName+GameContext.getFieldPostionString(xml.scout.battleFieldId));
				}
				else{
					return MultiLang.msg('report.title.scout{0}',FieldHelper.getFieldName(xml.scout.battleFieldType)+GameContext.getFieldPostionString(xml.scout.battleFieldId));
				}
			}
			else if(xml.hasOwnProperty('heroGrowth')){
				// 英雄历练
				var typeName:String = BattleHelper.instance.getBeanTempleType(xml.heroGrowth.growthType);
				return MultiLang.msg("report.title.heroTemper{0}{1}{2}",xml.heroGrowth.castleName,xml.heroGrowth.heroName,typeName);
			}
			else if(xml.hasOwnProperty('conquested')){
				// 独立战斗
				switch(int(xml.conquested.titleType)){
					case ConquestedReportConstant.IS_USE_ITME :
					return MultiLang.msg('report.conquest.getIndependence.title',xml.conquested.conquestedName);
					case ConquestedReportConstant.IS_HOST:
					return MultiLang.msg('report.conquest.success.title',xml.conquested.hostName);
					case ConquestedReportConstant.IS_CONQUESTED:
					return MultiLang.msg('report.conquest.beConquest.title',xml.conquested.conquestedName);
					case ConquestedReportConstant.IS_ADD_HOST:
					return MultiLang.msg('report.conquest.beConquest.title',xml.conquested.hostName);
					case ConquestedReportConstant.IS_ADD_HOST_CONQUESTED:
					return MultiLang.msg('report.conquest.success.title',xml.coquested.conquestedName);
					case ConquestedReportConstant.IS_HOST_CANCEL_CONQUESTED:
					return MultiLang.msg('report.conquest.getIndependence.title',xml.conquested.conquestedName);
					default:
					return "";
				}
			}
			else {
				return str;
			}
		}
		
		
		public static function parseIsAttack(str:String):Boolean{
			var xmlDoc:XMLDocument = XMLUtil.createXMLDocument(str);
			var d:SimpleXMLDecoder = new SimpleXMLDecoder(true);
	        var xmlObj:Object = d.decodeXML(xmlDoc);
	        var xml:ObjectProxy = new ObjectProxy();
	        if(xmlObj.hasOwnProperty("reportTitle"))
	      	  xml = xmlObj.reportTitle;
	        

			var isAttack:Boolean=false;
			if (xml.hasOwnProperty("battle")) {
				// 战斗报告
				isAttack = xml.battle.isAttack;	
			}
			return isAttack;
		}
		
		public static function getReportType(str:String):String{
			var xmlDoc:XMLDocument = XMLUtil.createXMLDocument(str);
			var decoder:SimpleXMLDecoder = new SimpleXMLDecoder(true);
	        var xmlObj:Object = decoder.decodeXML(xmlDoc);
	        var xml:ObjectProxy = xmlObj.reportTitle;
	        
	        if(xml.hasOwnProperty("aniScout") || xml.hasOwnProperty("scout"))
	        	return "scoutReport";
	        else
	        	return "";
		}
		
		private function getTargetStr(idField:int , fieldType:int , cityName:String,fieldLev:int = -1):String {
			var fieldStr:String = GameContext.getFieldPostionString(idField);
			if (fieldType != FieldConstant.TYPE_CITY) {
				if(fieldLev != -1)
				return FieldHelper.getFieldName(fieldType,fieldLev) + fieldStr;
				else
				return FieldHelper.getFieldName(fieldType) + fieldStr;
			} else {
				return cityName + fieldStr;
			}
		}
	}
}