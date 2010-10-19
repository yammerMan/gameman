package roma.logic.rule.ruleCheck
{
	import mx.collections.ArrayCollection;
	
	import roma.logic.GameContext;
	import roma.logic.object.castle.CastleObj;
	import roma.logic.object.tech.BaseTechObj;
	import roma.logic.object.tech.TechHelper;
	import roma.util.MultiLang;
	
	public class TechCheck extends BaseCheck
	{	
		public var techType:int;
		public var reqLevel:int;

		public function TechCheck(techType:int,reqLevel:int)
		{
			super(reqLevel);
		
			this.techType = techType;
			this.reqLevel = reqLevel;
			this.dispName = MultiLang.msg("condition.building");
			this.dispReq =  TechHelper.instance.getTechName(techType) + " " + MultiLang.msg("public.label.level") +" "+ this.reqLevel ;
		}
		
		override public function check():void{
			var techAry:ArrayCollection = GameContext.instance.getPlayerObj().techManager.techObjArray;
			var curLevel:int = 0;
			
			for(var i:int=0;i<techAry.length;i++){
				if(techAry.getItemAt(i).techType == this.techType){
					//拿当前城可用科技级别
					var castle:CastleObj = GameContext.instance.getPlayerObj().getCurCastleObj();
					curLevel = BaseTechObj(techAry.getItemAt(i)).getCurCastleTechLevel(castle);
					break;		
				}
			}
			
			this.isMatch = (curLevel >= this.reqLevel && curLevel <=10);
			this.dispCur = MultiLang.msg("public.label.level") +" "+ curLevel;
		}
	}
}