package roma.logic.rule.ruleCheck
{
	import mx.collections.ArrayCollection;
	import mx.logging.ILogger;
	import mx.logging.Log;
	
	import roma.logic.object.building.BaseBuilding;
	import roma.logic.object.building.BuildingHelper;
	import roma.logic.rule.ForticationRule;
	import roma.logic.rule.TroopRule;
	import roma.util.MultiLang;
	
	public class ConditionCheck extends BaseCheck
	{
		public static var instance:ConditionCheck = new ConditionCheck();
		
		private static var log:ILogger = Log.getLogger("roma.logic.rule.ruleCheck.ConditionCheck");
		
		public function ConditionCheck(reqNum:int =0)
		{
			super(reqNum);
		}
		
		/**
		 *检查城防或者军队生产建筑等级依赖 
		 * @param buildingObj
		 * @param troopRule
		 * @param fortRule
		 * @return 
		 * 
		 */
		public function checkBuildingLevel(buildingObj:BaseBuilding,troopRule:TroopRule=null,fortRule:ForticationRule=null):String{
			var buildingLevelRequest:int;
			var buildingDependStr:String ="";
	
			buildingLevelRequest =  troopRule !=null? troopRule.buildingLevelRequest:fortRule.buildingLevelRequest;
			
			try{
				buildingDependStr +=buildingObj.level>=buildingLevelRequest
				?"<b><font color ='#5f8c00'>"+ BuildingHelper.instance.getName(buildingObj.typeId) + " " + MultiLang.msg("public.label.level")+" "
				 + buildingLevelRequest +"</font></b>"
				 
				:"<b><font color ='#ff0000'>"+ BuildingHelper.instance.getName(buildingObj.typeId) + " " + MultiLang.msg("public.label.level")+" "
				 + buildingLevelRequest +"</font></b>";
				
				buildingDependStr+="&nbsp;&nbsp;";
				
			}catch(e:Error){
				log.error(e.message);
			}
			
			return buildingDependStr;
		}
		
		/**
		 * 检查城防或者军队生产科技依赖条件
		 * @param result
		 * @return 
		 */
		public function checkTechLevel(result:RuleCheckResult):String{
			var techDependStr:String ="";
			var techAry:ArrayCollection = result.techDepenAry;
			 
			if(techAry.length>0){
				for(var i:int=0;i<techAry.length;i++){
					var check:TechCheck = TechCheck(techAry.getItemAt(i));
					techDependStr += check.isMatch
					?"<b><font color ='#5f8c00'>"+check.dispReq+"</font></b>"+"&nbsp;&nbsp;&nbsp;"
					:"<b><font color ='#ff0000'>"+check.dispReq+"</font></b>"+"&nbsp;&nbsp;&nbsp;";
				}
			}
			return techDependStr;
		}
		
		/**
		 * 检查科技升级建筑依赖条件
		 * @param buildingDependAry
		 * @return 
		 */
		public function checkBuildingDepend(buildingDependAry:ArrayCollection):String{
			if(buildingDependAry ==null){
				return null;
			}
			
			var depBuiStr:String="";
			
			if(buildingDependAry.length>0){
				for(var i:int=0;i<buildingDependAry.length;i++){
					var check:BuildingDependsCheck = BuildingDependsCheck(buildingDependAry.getItemAt(i));
					depBuiStr += check.isMatch
					?"<b><font color ='#5f8c00'>"+check.dispReq+"</font></b>"+"&nbsp;&nbsp;&nbsp;"
					:"<b><font color ='#ff0000'>"+check.dispReq+"</font></b>"+"&nbsp;&nbsp;&nbsp;";
				}
			}
			return depBuiStr;
		}
		
		/**
		 * 检查建筑、 物品、人口依赖 
		 **/
		public function checkBuildingAndItemDepend(buildingDependAry:ArrayCollection,itemDependAry:ArrayCollection,populationDependAry:ArrayCollection):String{
			var str:String = "";
			
			//建筑依赖
			if(buildingDependAry.length>0){
				for(var b:int =0;b<buildingDependAry.length;b++){
					var check:BuildingDependsCheck = BuildingDependsCheck(buildingDependAry.getItemAt(b));
					str+= check.isMatch
					?"<b><font color ='#5f8c00'>"+check.dispReq+"</font></b>"+"&nbsp;&nbsp;"
					:"<b><font color ='#ff0000'>"+check.dispReq+"</font></b>"+"&nbsp;&nbsp;";
				}
			}
			
			//物品依赖
			if(itemDependAry.length>0){
				for(var i:int =0;i<itemDependAry.length;i++){
					var itemCheck:ItemCheck = ItemCheck(itemDependAry.getItemAt(i));
					str+=itemCheck.isMatch
					?"<b><font color ='#5f8c00'>"+itemCheck.dispReq+"</font></b>"+"&nbsp;&nbsp;"
					:"<b><font color ='#ff6600'>"+itemCheck.dispReq+"</font></b>"+"&nbsp;&nbsp;";
				}
			}
			
			//当前人口依赖
			if(populationDependAry.length>0){
				for(var p:int =0;p<populationDependAry.length;p++){
					var populationCheck:PeopleCheck = PeopleCheck(populationDependAry.getItemAt(p));
					str+=populationCheck.isMatch
					?"<b><font color ='#5f8c00'>"+populationCheck.dispReq+"</font></b>"+"&nbsp;&nbsp;"
					:"<b><font color ='#ff0000'>"+populationCheck.dispReq+"</font></b>"+"&nbsp;&nbsp;";
				}
			}
			
			return str;
		}
		
		/**
		 * 计算建造等待队列
		 * 每隔三级增加一个等待队列
		 **/
		public function calcWaitQueue(buildingObj:BaseBuilding):int{
			var queue:int;
			try{
				var mult:int = buildingObj.level/3;
				var remain:int = buildingObj.level%3;
			}catch(e:Error){
				log.error(e.message);
			}
			
			if(mult ==0 && remain>0){
				queue = 0;
			}
			if(mult>0 && remain>0){
				queue = mult*1+1;
			}
			if(mult>0 && remain ==0){
				queue = mult*1;
			}
			return queue;
		}
	}
}