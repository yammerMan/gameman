package views.spreadUI.speedUp
{
	import flash.utils.Dictionary;
	
	import roma.logic.rule.GameRuleHelper;
	import roma.logic.rule.ItemRule;
	
	public class CoinSpeedUtil
	{
		private var speedUpBuilItemAry:Array =[["speedup3hBuilding",10800],["speedup1hBuilding",3600],["speedup15mBuilding",900]];
		private var speedUpTechItemAry:Array =[["speedup3hTech",10800],["speedup1hTech",3600],["speedup15mTech",900]];
		private var speedUpWorkerTrainningAry:Array =[["speedup3hTraining",10800],["speedup1hTraining",3600],["speedup15mTraining",900]];
		
		private var _speedUpType:String;
				
		public static var instance:CoinSpeedUtil = new CoinSpeedUtil();
		
		public function CoinSpeedUtil()
		{
		}
		
		public function set speedUpType(type:String):void{
			this._speedUpType = type;
		}
		
		public function getSpeedNeedCoins(remainTime:Number):int{
			if(remainTime == 0) return 0;
			
			var count:int;
			var needCoins:int;
			var itemMap:Dictionary = new Dictionary();

			var itemAry:Array = this.speedUpBuilItemAry;			
			
			if(this._speedUpType== ItemSelectSpeedUpWin.COIN_FORTECH_SPEEDUP){
				itemAry = this.speedUpTechItemAry;
			}
			
			if(this._speedUpType== ItemSelectSpeedUpWin.COIN_FORWORKERTRAINNING_SPEEDUP){
				itemAry = this.speedUpWorkerTrainningAry;
			}
			
			for(var i:int=0;i<itemAry.length;i++){
				var rule:ItemRule = GameRuleHelper.instance.getItemRuleById(itemAry[i][0]);
				count = remainTime/itemAry[i][1];
				
				if(count>0){
					itemMap[rule] = count;
					needCoins += count * rule.price;
					remainTime = remainTime % itemAry[i][1];
				}					
			}
			
			if(remainTime>0) needCoins += GameRuleHelper.instance.getItemRuleById(itemAry[itemAry.length-1][0]).price;
			
			var itemConut:*;
			var coins:int = needCoins;
			
			for(var t:int=0;t<itemAry.length;t++){
				var itemRule:ItemRule = GameRuleHelper.instance.getItemRuleById(itemAry[t][0]);
				itemConut = itemMap[itemRule];
				
				if(itemConut == null){
					//判断下一个是否为null
					if(t==0 && itemMap[GameRuleHelper.instance.getItemRuleById(itemAry[t+1][0])] == null ) continue;

					if(itemRule.price<coins){
						needCoins = needCoins -coins +itemRule.price;
						break;
					}
				}else{
					coins -=itemRule.price*itemConut;
					if(itemRule.price<coins){
						needCoins = itemRule.price*(itemConut+1);
						break;
					}
				}
			}
			
			itemMap =null;
			return needCoins;
		}
	}
}