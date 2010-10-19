package views.windows.buildings.temple
{
	import roma.common.constants.BuffConstants;
	import roma.common.constants.InteriorConstant;
	import roma.logic.GameContext;
	import roma.util.BufferHandle;
	import roma.util.ClientUtil;
	import roma.util.MultiLang;
	
	public class MollifyData
	{
		
		public static var instance:MollifyData = new MollifyData();
		
		public function MollifyData()
		{
		}

	 	public function levyRelated():String{
	 		var txt:String="";
	 		var curPopulation:int = GameContext.instance.getPlayerObj().getCurCastleObj().resourceManager.curPopulation;
 			txt+=MultiLang.msg("townHall.levyEffect",Math.floor(curPopulation*InteriorConstant.LEVY_GOLD_AMOUNT_TIMES_POPU),MultiLang.msg("label.gold"),InteriorConstant.SUPPORT_DECREASE_BY_LEVY)+"\n";
 			txt+=MultiLang.msg("townHall.levyEffect",Math.floor(curPopulation*InteriorConstant.LEVY_FOOD_AMOUNT_TIMES_POPU),MultiLang.msg("label.food"),InteriorConstant.SUPPORT_DECREASE_BY_LEVY)+"\n";
 			txt+=MultiLang.msg("townHall.levyEffect",Math.floor(curPopulation*InteriorConstant.LEVY_WOOD_AMOUNT_TIMES_POPU),MultiLang.msg("label.wood"),InteriorConstant.SUPPORT_DECREASE_BY_LEVY)+"\n";
 			txt+=MultiLang.msg("townHall.levyEffect",Math.floor(curPopulation*InteriorConstant.LEVY_STONE_AMOUNT_TIMES_POPU),MultiLang.msg("label.stone"),InteriorConstant.SUPPORT_DECREASE_BY_LEVY)+"\n";
 			txt+=MultiLang.msg("townHall.levyEffect",Math.floor(curPopulation*InteriorConstant.LEVY_IRON_AMOUNT_TIMES_POPU),MultiLang.msg("label.iron"),InteriorConstant.SUPPORT_DECREASE_BY_LEVY);
	 		return txt;
	 	}
	 	
	 	public function mollifyRelated():String{
			var txt:String ="";		 
	 		var curPopulation:int = GameContext.instance.getPlayerObj().getCurCastleObj().resourceManager.curPopulation;
 			txt+=MultiLang.msg("townHall.reduceComplaint",MultiLang.msg("townHall.pacify_type_relief"),Math.floor(curPopulation*InteriorConstant.RELIEF_NEED_FOOD_TIMES_POPU)+" "+MultiLang.msg("label.food"),InteriorConstant.RELIEF_DECREASE_COMPLAINT)+"\n";
 			txt+=MultiLang.msg("townHall.reduceComplaint",MultiLang.msg("townHall.pacify_type_pray"),Math.floor(curPopulation*InteriorConstant.PRAY_NEED_FOOD_TIMES_POPU)+" "+MultiLang.msg("label.food")+","+Math.floor(curPopulation*InteriorConstant.PRAY_NEED_GOLD_TIMES_POPU)+" "+MultiLang.msg("label.gold"),InteriorConstant.PRAY_DECREASE_COMPLAINT)+"\n";
 			txt+=MultiLang.msg("townHall.reduceComplaint",MultiLang.msg("townHall.pacify_type_bless"),Math.floor(curPopulation*InteriorConstant.BLESS_NEED_FOOD_TIMES_POPU)+" "+MultiLang.msg("label.food")+","+Math.floor(curPopulation*InteriorConstant.BLESS_NEED_GOLD_TIMES_POPU)+" "+MultiLang.msg("label.gold"),InteriorConstant.BLESS_DECREASE_COMPLAINT)+"\n";
 			txt+=MultiLang.msg("townHall.multiplyTheEarth",MultiLang.msg("townHall.pacify_type_raise_popu"),Math.floor(curPopulation*InteriorConstant.RAISEPOPU_NEED_FOOD_TIMES_POPU)+" "+MultiLang.msg("label.food"),Math.floor(curPopulation*InteriorConstant.RAISE_POPU_TIMES_CURRENT));
	 		return txt;
	 	}
	}
}