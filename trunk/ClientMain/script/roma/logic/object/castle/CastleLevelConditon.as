package roma.logic.object.castle
{
	import flash.utils.Dictionary;
	
	import roma.common.constants.InteriorConstant;
	import roma.common.valueObject.MaterialBean;
	import roma.logic.GameContext;
	import roma.logic.RomaConstants;
	import roma.logic.object.building.BaseBuilding;
	import roma.logic.rule.ruleCheck.ResourceCheck;
	import roma.util.MultiLang;
	
	import views.spreadUI.MyAlert;
	
	[Bindable]
	public class CastleLevelConditon
	{
		public var resourceCodition:ResourceConditon;
		
		private var conditonMap:Dictionary = new Dictionary();

		public static var instance:CastleLevelConditon = new CastleLevelConditon();
		
		public function CastleLevelConditon()
		{
			conditonMap[CastleLevelConstant.CASTLE_LEVEL_TWO]   = new ResourceConditon(1,InteriorConstant.FIRST_EXPAND_TOWNHALL_LEVEL_DEPEND,1,3000,3000,3000,3000,3000);
			conditonMap[CastleLevelConstant.CASTLE_LEVEL_THREE] = new ResourceConditon(2,InteriorConstant.SECOND_EXPAND_TOWNHALL_LEVEL_DEPEND,2,5000,5000,5000,5000,5000);
			conditonMap[CastleLevelConstant.CASTLE_LEVEL_FOUR]  = new ResourceConditon(3,InteriorConstant.THIRD_EXPAND_TOWNHALL_LEVEL_DEPEND,4,10000,10000,10000,10000,10000);
		}
		
		private function getCastleResCondition(level:int):ResourceConditon{
			return conditonMap[level]; 
		}
		
		public function updateCurCastleResCondition():void{
			var level:int = GameContext.instance.getPlayerObj().getCurCastleObj().level;
			if(level==0){
				this.resourceCodition = this.getCastleResCondition(CastleLevelConstant.CASTLE_LEVEL_TWO);		
			}else if(level==1){
				this.resourceCodition = this.getCastleResCondition(CastleLevelConstant.CASTLE_LEVEL_THREE);		
			}else if(level>=2){
				this.resourceCodition=this.getCastleResCondition(CastleLevelConstant.CASTLE_LEVEL_FOUR);		
			}
		}
		
		public function checkExtendCastleLevel():Boolean{
			var townHall:BaseBuilding = GameContext.instance.getPlayerObj().getCurCastleObj().buildingManager.getTownHall();
			var castleLevel:int = GameContext.instance.getPlayerObj().getCurCastleObj().level;
			with(townHall){
				if(castleLevel == 0 && level<InteriorConstant.FIRST_EXPAND_TOWNHALL_LEVEL_DEPEND){
					MyAlert.show(MultiLang.msg('townHall.level.reach',2,InteriorConstant.FIRST_EXPAND_TOWNHALL_LEVEL_DEPEND));
					return false;
				}

				if(castleLevel == 1 && level<InteriorConstant.SECOND_EXPAND_TOWNHALL_LEVEL_DEPEND){
					MyAlert.show(MultiLang.msg('townHall.level.reach',3,InteriorConstant.SECOND_EXPAND_TOWNHALL_LEVEL_DEPEND));
					return false;
				}

				if(castleLevel == 2 && level<InteriorConstant.THIRD_EXPAND_TOWNHALL_LEVEL_DEPEND){
					MyAlert.show(MultiLang.msg('townHall.level.reach',4,InteriorConstant.THIRD_EXPAND_TOWNHALL_LEVEL_DEPEND));
					return false;
				}
			}
			
			return true;
		}
		
		public function checkExtendCondition():String{
			var str:String ="";
			var castleLevel:int = GameContext.instance.getPlayerObj().getCurCastleObj().level;
			var townLevel:int = GameContext.instance.getPlayerObj().getCurCastleObj().buildingManager.getTownHall().level;
			
			if(castleLevel+1<=3){
				var condition:ResourceConditon = this.getCastleResCondition(castleLevel+1);
				str= townLevel>= condition.needLevel  
				?"<b><font color ='#5f8c00'>"+condition.townLevelStr+"</font></b>"+"&nbsp;&nbsp;&nbsp;"
				:"<b><font color ='#ff0000'>"+condition.townLevelStr+"</font></b>"+"&nbsp;&nbsp;&nbsp;";

				str+= this.getItemNum()>=condition.needItemNum				
				?"<b><font color ='#5f8c00'>"+condition.itemStr+"</font></b>"+"&nbsp;&nbsp;&nbsp;"
				:"<b><font color ='#ff6600'>"+condition.itemStr+"</font></b>"+"&nbsp;&nbsp;&nbsp;";
			}
			
			return str;
		}
		
		private function getItemNum():int{
			var item:MaterialBean = GameContext.instance.getPlayerObj().itemManager.getMaterialBeanById(InteriorConstant.EXPAND_CASTLE_ITEM);
			if(item !=null){
				return item.count;
			}
			return 0;			
		}
		
		public function getFood():ResourceCheck{
			return new ResourceCheck(this.resourceCodition.needFood,RomaConstants.RES_TYPE_FOOD);
		}

		public function getWoods():ResourceCheck{
			return new ResourceCheck(this.resourceCodition.needWood,RomaConstants.RES_TYPE_WOOD);
		}

		public function getIrons():ResourceCheck{
			return new ResourceCheck(this.resourceCodition.needIron,RomaConstants.RES_TYPE_IRON);
		}

		public function getStones():ResourceCheck{
			return  new ResourceCheck(this.resourceCodition.needStone,RomaConstants.RES_TYPE_STONE);
		}

		public function getGolds():ResourceCheck{
			return new ResourceCheck(this.resourceCodition.needGold,RomaConstants.RES_TYPE_GOLD);
		}
	}
}