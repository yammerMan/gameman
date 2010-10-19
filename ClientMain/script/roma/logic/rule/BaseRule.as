package roma.logic.rule
{
	import roma.logic.object.building.BaseBuilding;
	import roma.logic.rule.ruleCheck.RuleCheckResult;

	public class BaseRule
	{
		public var costFood:int = 0;
		public var costWood:int = 0;
		public var costGold:int = 0;
		public var costIron:int = 0;
		public var costStone:int = 0;
		public var costTime:int = 0;
		
		public var itemDepends:Array = new Array();
		public var techDepends:Array = new Array();
		public var buildingDepends:Array = new Array();

		public var ppopulationDepends:int;
		
		public function BaseRule(
			costFood:int,
			costWood:int,
			costGold:int,
			costIron:int,
			costStone:int,
			costTime:int,
			itemDependsStr:String=null,
			techDependsStr:String=null,
			buildingDependsStr:String=null,
			populationDependsStr:String =null){
				
			this.costFood  = costFood  ;
			this.costWood  = costWood  ;
			this.costGold  = costGold  ;
			this.costIron  = costIron  ;
			this.costStone = costStone ;
			this.costTime  = costTime  ;
			
			this.ppopulationDepends = int(populationDependsStr);
			
			this.splitString(this.techDepends , techDependsStr);
			this.splitString(this.buildingDepends , buildingDependsStr);

			if (itemDependsStr!=null && itemDependsStr.length>0) {
				var strAry:Array = itemDependsStr.split(",");
				for each(var en:String in strAry) {
					var i:int = en.indexOf(".");
					var itemID:String = en.substring(0,i);
					var num:String = en.substring(i+1);
					var dd:ItemDependData = new ItemDependData(itemID,int(num) );
					itemDepends.push(dd);
				}
//				this.splitString(this.itemDepends , itemDependsStr);
			}
		}
		
		private function splitString(array:Array, str:String):void {
			if (str!=null && str.length>0) {
				var strAry:Array = str.split(",");
				for each(var en:String in strAry) {
					var i:int = en.indexOf(".");
					var typeId:String = en.substring(0,i);
					var level:String = en.substring(i+1);
					var dd:DependData = new DependData(int(typeId),int(level));
					array.push(dd);
				}
			} 
		}
		
		public function check(buildingObj:BaseBuilding=null):RuleCheckResult {
			return new RuleCheckResult(this);
		}
	}
}