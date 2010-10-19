package roma.logic.object.chat
{
	import flash.utils.Dictionary;
	
	import mx.collections.ArrayCollection;
	
	import roma.data.MapTileData;
	import roma.logic.GameContext;
	import roma.logic.rule.GameRuleHelper;
	import roma.logic.rule.ItemRule;
	import roma.util.MultiLang;
	
	import views.mainFrame.ChatPanel;
	
	public class WordFilters
	{
		public static var SIGN_BATTLE:String = "signBattle:";
		public static var SIGN_BATTLE_LINK:String = "signBattleLink"
		
		public static var instance:WordFilters = new WordFilters();
		public var armyTroopDictionary:Dictionary=new Dictionary();
		private var patternStr:String = "";
		
		public function WordFilters()
		{
			var arr:Array = new Array();
			for each(var ir:ItemRule in GameRuleHelper.instance.itemRuleArray){
				if(ir.name== null)continue;
				if(ir.price <= 0)continue;
				var str:String = ir.name;
				str = ir.name.replace(/\*/g,"\\*");
				str = str.replace(/\(/g,"\\(");
				str = str.replace(/\)/g,"\\)");
				str = str.replace(/\|/g,"\\|");
				str = str.replace(/\x22/g,"");
				if (str.length>1) {
					arr.push(str);
				}
			}
 			patternStr = arr.join("|");
		}
		
		/**
		 *分离野地信息
		 */  
		public function positionAnalyse(str:String):String{
			var arr1:Array = str.match(/\[[0-9]{1,3}[,][0-9]{1,3}\]/g);
			var arr2:Array = str.split(/\[[0-9]{1,3}[,][0-9]{1,3}\]/);
			var s:String = "";
			for(var i:int=0;i<arr1.length;i++){
				s += arr2[i]+"<font color='#0000ff'><u><a href=\""+"event:"+arr1[i]+"\">"+arr1[i]+"</a></u></font>";
			}
			s += arr2[arr2.length-1];
			return s;
		}
		
		/**
		 * 出征信息
		 */ 
		public function apartArmyData(str:String):String{
			var s:String = str;
			var c:int = str.indexOf(SIGN_BATTLE);
			if(c>-1){
				s = str.slice(c+SIGN_BATTLE.length-1);
				var arr:Array = s.split(".");
				var t:MapTileData = new MapTileData();
				t.playerName=String(arr[0]);
				t.fieldName=String(arr[1]);
				t.fieldX=GameContext.getFieldPostionX(arr[2]);
				t.fieldY=GameContext.getFieldPostionY(arr[2]);
				t.canAttack=Boolean(arr[3]);
				t.canTransport=Boolean(arr[4]);
				t.canReinforce=Boolean(arr[5]);
				t.missionType=int(arr[6]);
				t.arrivedTime=Number(arr[7]);
				t.battleId = Number(arr[8]);
				//Dictionary的记录序列是：战斗id/到达时间
				var k:String = SIGN_BATTLE_LINK+String(t.battleId)+String(t.arrivedTime);
				this.armyTroopDictionary[k]=t;
				s=MultiLang.msg("chat.armyTroopInfo",t.playerName,GameContext.toConstructionLocalTimeStr(t.arrivedTime),t.fieldX,t.fieldY,t.getMissionName());
				s="<font color='#0033b3'><a href=\""+"event:"+k+"\">"+s+"</a></font>";
			}
			return s;
		}
		
		/**
		 * 每句话的物品分析 
		 */ 
		public function itemsSign(str:String):String{
			var pattern:RegExp = new RegExp(patternStr,'g');
			var pattern2:RegExp = new RegExp(patternStr); 
			
			var arr1:Array = str.match(pattern);
			var arr2:Array = str.split(pattern2);
			var s:String= "";
			
			for(var i:int=0;i<arr1.length;i++){
				s += arr2[i]+"<font color='#0030ff'><a href=\""+"event:items"+arr1[i]+"\">"+arr1[i]+"</a></font>";
			}
			s += arr2[arr2.length-1];
			return s;
		}

		/**
		 * 通过物品名称来寻找物品id，很牵强的做法
		 */ 
		public function getItemRule(iStr:String):ItemRule{
			var item:ItemRule;
			for each(var ir:ItemRule in GameRuleHelper.instance.itemRuleArray){
				if(ir.name== null)continue;
				if(ir.price <= 0)continue;
				item = ir;
				if(ir.name == iStr){
					break;
				}
			}
			return item;
		}

		public function copyArrayCollection(arr:ArrayCollection):ArrayCollection{
			var arrTemp:ArrayCollection = new ArrayCollection();
			for each(var a:Object in arr){
				arrTemp.addItem(a);
			}
			return arrTemp;
		}
		
		public function removeChatList(arr:ArrayCollection):ArrayCollection{
			if(arr.length > ChatPanel.MAX_CHAT_length+20){
				arr.source.splice(0,20);
			}
			return arr;
		}
		
	}
}