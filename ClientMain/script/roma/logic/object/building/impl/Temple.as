package roma.logic.object.building.impl
{
	import animation.IAniPlayer;
	import animation.aniSet.building.TempleAniSet;
	
	import roma.common.action.ControllerFactory;
	import roma.common.constants.BuffConstants;
	import roma.common.constants.BuildingConstant;
	import roma.common.constants.InteriorConstant;
	import roma.common.constants.ResourceConstant;
	import roma.common.constants.TempleConstant;
	import roma.common.controller.CommonResponse;
	import roma.common.valueObject.ArchitectureBean;
	import roma.logic.GameContext;
	import roma.logic.object.building.BaseBuilding;
	import roma.logic.object.castle.CastleObj;
	import roma.util.BufferHandle;
	import roma.util.MultiLang;
	
	import views.MainContainer;
	import views.PopupWindows;
	import views.spreadUI.MyAlert;
	import views.windows.buildings.market.MarketHelper;
	import views.windows.buildings.temple.MollifyCivilian;
	import views.windows.buildings.temple.TempleWin;

	/**
	 * 
	 * 神庙
	 * 
	 */
	public class Temple extends BaseBuilding
	{
		public function Temple(bean:ArchitectureBean)
		{
			super(bean);
		}
		
		/**
		 * 重写父类的方法
		 * 点击弹出界面
		 **/
		override public function onClick():void {
			PopupWindows.openBuildingInfoWin(TempleWin.WINDOW_SHOW ,this);
		}

		/** 获得建筑的动画*/
		override protected function getNormalAniPLayer():IAniPlayer {
			return new TempleAniSet();			
		}

		/** 神庙神对建筑与招兵时间的的影响*/
		public function getTempleGodaccPer():Number{
			var res:Number;
			if(this.getCurLevelBuildingRule()!=null){
				 res = this.getCurLevelBuildingRule().buff1 / 100;
			}
			return res;
		}
		
		/**
		 *神庙选择 
		 * @param godType
		 * 
		 */
		public function serverGod(godType:int,fun:Function=null):void{
			var onServerGodResponse:Function = function(event:CommonResponse):void{
				if(event.isSuccess()){
					if(fun !=null){
						fun.apply(this,[godType]);
					}
					castle.godType = godType;
				}else{
					MyAlert.showError(event);
				}
			}
			
			ControllerFactory.getInstance().getCityController().serverGod(this.castle.cityId,godType,onServerGodResponse);
		}
		
		/** 获得建筑的功能说明 ， 需要覆盖的方法*/
		override public function getFuncDesc(level:int):String {
			if (level>0 && level < BuildingConstant.HIGHEST_LEVEL+1) {
				var src:String="";
				var castle:CastleObj = GameContext.instance.getPlayerObj().getCurCastleObj();
				switch(castle.godType){
					case TempleConstant.JUNEAU_GOD:
						src=MultiLang.msg("building.temple.func.juneauGod",level,level*3);
					break;
					
					case TempleConstant.JUPITER_GOD:
						src=MultiLang.msg("building.temple.func.jupiterGod",level,level*3);
					break;
					
					case TempleConstant.MARS_GOD:
						src=MultiLang.msg("building.temple.func.marsGod",level,level*3);
					break;
					
					default:
						src=MultiLang.msg("building.temple.func.noGod");
				}
				return src;
				
			} else {
				return "";
			}
		}
		
		/**
		 *安抚百姓 
		 * @param selectedValue
		 * @param typeId
		 * 
		 */
		public function sendHandler(selectedValue:Object,typeId:int,fun:Function,fun1:Function):void{
			var onPacifyResponse:Function = function(event:CommonResponse):void{
				if(event.isSuccess()){
					fun.apply(this);	
					MainContainer.instance.risePlay(MultiLang.msg("townHall.label.comformSuccess"));							
				}else{
					MyAlert.showError(event);
				}
			}
			
			var onLevyResponse:Function = function(event:CommonResponse):void{
				if(event.isSuccess()){
					fun1.apply(this);
					var pop:int=GameContext.instance.getPlayerObj().getCurCastleObj().resourceManager.curPopulation;
					switch(typeId){
						case ResourceConstant.RESOURCE_TYPE_MONEY:
							MainContainer.instance.risePlay(MultiLang.msg("townHall.label.levySuccess",Math.floor(pop*InteriorConstant.LEVY_GOLD_AMOUNT_TIMES_POPU),MarketHelper.instance.getResourceType(ResourceConstant.RESOURCE_TYPE_MONEY)));
						break;
						
						case ResourceConstant.TYPE_FOOD:
							MainContainer.instance.risePlay(MultiLang.msg("townHall.label.levySuccess",Math.floor(pop*InteriorConstant.LEVY_FOOD_AMOUNT_TIMES_POPU),MarketHelper.instance.getResourceType(ResourceConstant.TYPE_FOOD)));
						break;
						
						case ResourceConstant.TYPE_WOOD:
							MainContainer.instance.risePlay(MultiLang.msg("townHall.label.levySuccess",Math.floor(pop*InteriorConstant.LEVY_WOOD_AMOUNT_TIMES_POPU),MarketHelper.instance.getResourceType(ResourceConstant.TYPE_WOOD)));
						break;
						
						case ResourceConstant.RESOURCE_TYPE_STONES:
							MainContainer.instance.risePlay(MultiLang.msg("townHall.label.levySuccess",Math.floor(pop*InteriorConstant.LEVY_STONE_AMOUNT_TIMES_POPU),MarketHelper.instance.getResourceType(ResourceConstant.RESOURCE_TYPE_STONES)));
						break;
						
						case ResourceConstant.TYPE_IRON:
							MainContainer.instance.risePlay(MultiLang.msg("townHall.label.levySuccess",Math.floor(pop*InteriorConstant.LEVY_IRON_AMOUNT_TIMES_POPU),MarketHelper.instance.getResourceType(ResourceConstant.TYPE_IRON)));
						break;
					}
					
									
				}else{
					MyAlert.showError(event);
				}				
			}

			if(selectedValue == MollifyCivilian.MOLLIFY){
				if(BufferHandle.getVirtuousBuffById(BuffConstants.CASTLE_COMFORTING_COOL_DOWN)){
					MyAlert.show(MultiLang.msg('comforting.not.frequency'));
					return;
				}
				ControllerFactory.getInstance().getCityController().confortPeople(this.castle.cityId,typeId,onPacifyResponse);
			}else{
				if(BufferHandle.getVirtuousBuffById(BuffConstants.CASTLE_LEVY_COOL_DOWN)){
					MyAlert.show(MultiLang.msg('levy.not.frequency'));
					return;
				}
				ControllerFactory.getInstance().getCityController().levyResource(this.castle.cityId,typeId,onLevyResponse);
			}
		}		
	}
}