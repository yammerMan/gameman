package views.windows.functionWins.turntable
{
	import roma.common.valueObject.RoletteAppearItemBean;
	import roma.logic.rule.GameRuleHelper;
	import roma.util.MultiLang;
	
	public class RaffleUtil
	{
		
		public function RaffleUtil()
		{
		}
		
		 /**
		  *描述玩家中奖物品 ，显示在世界聊天框，系统信息框，
		  * @param str
		  * @return 
		  */		
		 public static function analyzeRaffleXml(str:String,isTopShow:Boolean=true):String{
			var raffledesc:String;

			var xml:XML = XML(str);
			var name:String = xml.@playerName;
			var itemCount:int = xml.@count;
			var itemValue:int = xml.@coinValue;	
			var itemName:String = GameRuleHelper.instance.getItemRuleById(xml.@itemId).name;
			
			if(itemValue!=0){
				if(isTopShow){
					raffledesc=MultiLang.msg("tvShow.playerGotValueGood",name,itemValue,itemName,itemCount);
				}else{
					raffledesc = MultiLang.msg("tvShow.playerGotValueGood.2",name,itemValue,itemName,itemCount);
				}
			}else{
				if(isTopShow){
					raffledesc=MultiLang.msg("tvShow.playerGotNoValueGood",name,itemName,itemCount);
				}else{
					raffledesc=MultiLang.msg("tvShow.playerGotNoValueGood.2",name,itemName,itemCount);
				}
			}
			return	raffledesc;
		} 


		 /**
		 * 描述自己从转盘转到的物品，显示在系统信息框
		  * @return 
		  */
		 public static function ownRaffleDesc(item:RoletteAppearItemBean):String{
		 	var itemName:String = GameRuleHelper.instance.getItemRuleById(item.itemId).name;
		 	if(item.coinValue>0){
		 		return MultiLang.msg("turntable.rolette.value.desc",item.coinValue,itemName,item.count);
		 	}
		 	return  MultiLang.msg("turntable.rolette.desc",itemName,item.count); 
		 } 
	}
}