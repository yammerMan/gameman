package views.mainFrame
{
	import flash.xml.XMLDocument;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.xml.SimpleXMLDecoder;
	import mx.utils.ObjectProxy;
	import mx.utils.XMLUtil;
	
	import roma.common.constants.FieldConstant;
	import roma.logic.GameContext;
	import roma.logic.object.chat.WordFilters;
	import roma.logic.object.field.FieldHelper;
	import roma.logic.rule.GameRuleHelper;
	import roma.util.MultiLang;
	
	import views.mainModules.map.smallMap.NpcFieldConstant;
	import views.windows.functionWins.mail.ReportUi.ReportManager;
	
	public class ChatNotice
	{
		public static var instance:ChatNotice = new ChatNotice();
		
		public function ChatNotice()
		{
		}
		
		/**
		 * 军队报告
		 */ 
		public function parseArmyMoveReport(str:String):String{
			return ReportManager.parseTitleStr(str);
	    }
	    
	    /**
	    * 训练场报告
	    */ 
	    public function parseTrainRoomReport(list:XMLList):String {
            var player:XML;
            var item:XML;
            var trainRoomReport:String="";
			var otherPlayerstr:String="";
			var items:String="";
           
           	if(list.hasOwnProperty("otherPlayer")){
           		var playerNum:int=0;
				for each(player in list.child("otherPlayer")) {
					playerNum++;
					if(playerNum==3)break;
	                otherPlayerstr+="<font color='#ff0000'>"+player.toString()+"</font>"+",";
	            }
			};
			
			if(list.hasOwnProperty("items")){
				for each(item in list.child("items")) {
	                items+="<font color='#ff0000'>"+GameRuleHelper.instance.getItemRuleById(item.attribute("id")).name+" x "+item.attribute("count")+"</font>"+"," ;
	            }
			};
			if(items!=""){
				items=items.substr(0,items.length-1);
			}
			if(list.attribute("npcType")==FieldConstant.TYPE_NPC_FIELD){
	            if(otherPlayerstr!=""){
		            otherPlayerstr=otherPlayerstr.substr(0,otherPlayerstr.length-1);
	            	trainRoomReport=MultiLang.msg("chat.trainRoomReport.manyPlayers","<font color='#ff0000'>"+list.attribute("player")+"</font>","<font color='#ff0000'>"+list.attribute("npcFieldName")+"</font>","<font color='#ff0000'>"+list.attribute("npcIndex")+"</font>","<font color='#ff0000'>"+list.attribute("npcHero")+"</font>",items,"<font color='#ff0000'>"+list.attribute("totalHonor")+"</font>","<font color='#ff0000'>"+list.attribute("totalExp")+"</font>",otherPlayerstr);
	            }else{
	            	trainRoomReport=MultiLang.msg("chat.trainRoomReport.onePlayer","<font color='#ff0000'>"+list.attribute("player")+"</font>","<font color='#ff0000'>"+list.attribute("npcFieldName")+"</font>","<font color='#ff0000'>"+list.attribute("npcIndex")+"</font>","<font color='#ff0000'>"+list.attribute("npcHero")+"</font>",items,"<font color='#ff0000'>"+list.attribute("totalHonor")+"</font>","<font color='#ff0000'>"+list.attribute("totalExp")+"</font>");
	            }
			}else if(list.attribute("npcType")==NpcFieldConstant.TYPE_RATTER_NPC_FIELD){
				if(otherPlayerstr!=""){
		            otherPlayerstr=otherPlayerstr.substr(0,otherPlayerstr.length-1);
	            	trainRoomReport=MultiLang.msg("chat.ratterNpcReport.manyPlayers","<font color='#ff0000'>"+list.attribute("player")+"</font>","<font color='#ff0000'>"+list.attribute("npcFieldName")+"</font>","<font color='#ff0000'>"+list.attribute("npcIndex")+"</font>","<font color='#ff0000'>"+list.attribute("npcHero")+"</font>",items,"<font color='#ff0000'>"+list.attribute("totalHonor")+"</font>","<font color='#ff0000'>"+list.attribute("totalExp")+"</font>",otherPlayerstr);
	            }else{
	            	trainRoomReport=MultiLang.msg("chat.ratterNpcReport.onePlayer","<font color='#ff0000'>"+list.attribute("player")+"</font>","<font color='#ff0000'>"+list.attribute("npcFieldName")+"</font>","<font color='#ff0000'>"+list.attribute("npcIndex")+"</font>","<font color='#ff0000'>"+list.attribute("npcHero")+"</font>",items,"<font color='#ff0000'>"+list.attribute("totalHonor")+"</font>","<font color='#ff0000'>"+list.attribute("totalExp")+"</font>");
	            }
			}else{
				 if(otherPlayerstr!=""){
		            otherPlayerstr=otherPlayerstr.substr(0,otherPlayerstr.length-1);
	            	trainRoomReport=MultiLang.msg("chat.trainRoomReport.manyPlayers","<font color='#ff0000'>"+list.attribute("player")+"</font>","<font color='#ff0000'>"+list.attribute("npcFieldName")+"</font>","<font color='#ff0000'>"+list.attribute("npcIndex")+"</font>","<font color='#ff0000'>"+list.attribute("npcHero")+"</font>",items,"<font color='#ff0000'>"+list.attribute("totalHonor")+"</font>","<font color='#ff0000'>"+list.attribute("totalExp")+"</font>",otherPlayerstr);
	            }else{
	            	trainRoomReport=MultiLang.msg("chat.trainRoomReport.onePlayer","<font color='#ff0000'>"+list.attribute("player")+"</font>","<font color='#ff0000'>"+list.attribute("npcFieldName")+"</font>","<font color='#ff0000'>"+list.attribute("npcIndex")+"</font>","<font color='#ff0000'>"+list.attribute("npcHero")+"</font>",items,"<font color='#ff0000'>"+list.attribute("totalHonor")+"</font>","<font color='#ff0000'>"+list.attribute("totalExp")+"</font>");
	            }
			}
			
            return  "<font color='#994b2c'>" +trainRoomReport +"</font>";
        }
        
        /**
	    * 宗主城被打报告
	    */ 
	    public function parseSysHostBeAttack(str:String):String{
	    	var xd:XMLDocument = XMLUtil.createXMLDocument(str);
	    	var d:SimpleXMLDecoder = new SimpleXMLDecoder(true);
			var obj:Object = d.decodeXML(xd)["hostBeAttack"];
	    	var selfName:String = "";
	    	var hostName:String = "";
	    	var fStr:String = "";
	    	if(obj.hasOwnProperty("selfCastle")){
	    		if(obj["selfCastle"] is ArrayCollection){
	    			for each(var o:Object in obj["selfCastle"]){
	    				selfName += o["cityName"]+",";
	    			}
	    			selfName = selfName.substring(0,selfName.length-1);
	    		}else if(obj["selfCastle"] is ObjectProxy){
	    			selfName += obj["selfCastle"]["cityName"];
	    		}
	    	}
	    	fStr = GameContext.getFieldPostionString(obj["hostCastleFieldId"]);
	    	hostName += "<font color='#0000ff'>"+obj["hostCastleName"]+"</font>"+fStr;
	    	var str:String = "<font color='#d60000'>"+MultiLang.msg('chat.system.hostBeAttack',"<font color='#0000ff'>"+selfName+"</font>",hostName)+"</font>";
	    	str = WordFilters.instance.positionAnalyse(str);
	    	return str;
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