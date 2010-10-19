// ActionScript file

	import flash.events.Event;
	
	import mx.collections.ArrayCollection;
	import mx.controls.dataGridClasses.DataGridColumn;
	import mx.events.DataGridEvent;
	import mx.events.ListEvent;
	
	import roma.common.action.ControllerFactory;
	import roma.common.constants.FieldConstant;
	import roma.common.controller.CommonResponse;
	import roma.common.valueObject.FieldCollectBean;
	import roma.logic.GameContext;
	import roma.logic.object.castle.CastleObj;
	import roma.message.EvtDispacther;
	import roma.message.events.FavoriteEvent;
	import roma.util.MultiLang;
	import roma.util.PopupWinManager;
	
	import views.spreadUI.MyAlert;
	import views.spreadUI.favorite.FieldFavorite;
	import views.spreadUI.tips.CommonTooltip;
	import views.spreadUI.tips.ToolTipContainer;

	[Bindable]
	public var newRemark:String;
	[Bindable]
	private var dataArray:ArrayCollection;
	
	private var oldRemark:String;
	
	public static const ADD_FAVORITE:String = "add.favorite";
	public static const UPDATE_FAVORITE:String = "update.favorite";
	public static const DELETE_FAVORITE:String = "delete.favorite";
	public static const FAVORITE_FIELD_SELECT:String = "favorite.field.select";
	public static const UPDATE_COLLECT:String = "update.collect";  
			
	public static var instance:FieldFavorite = new FieldFavorite();
	
	private var changeToolTip:CommonTooltip;
	
	public static function show():void{
		if(instance !=null){
			PopupWinManager.instance.addPopup(instance,false);
		}
		
		if(instance.initialized){
			instance.dataArray = GameContext.instance.getPlayerObj().favoriteManager.favoriteArray;
			if(instance.dataArray.length>3){
				instance.width=300;
			}else{
				instance.width=280;
			}
		}
	}
	
	public function addListener():void{
		if(!EvtDispacther.instance.hasEventListener(ADD_FAVORITE)){
			EvtDispacther.instance.addEventListener(ADD_FAVORITE,addFavHandler);
		}
	}
	
	private function init():void{
		changeToolTip = ToolTipContainer.instance.commonTooltip;
		
		this.dataArray = GameContext.instance.getPlayerObj().favoriteManager.favoriteArray;
		
		if(!EvtDispacther.instance.hasEventListener(ADD_FAVORITE)){
			EvtDispacther.instance.addEventListener(ADD_FAVORITE,addFavHandler);
		}
		
		EvtDispacther.instance.addEventListener(UPDATE_FAVORITE,updateFavHandler);
		EvtDispacther.instance.addEventListener(DELETE_FAVORITE,deleteFavHandler);
		
		EvtDispacther.instance.addEventListener(EvtDispacther.FIELD_FAVOTITE_UPDATE,favoriteUpdate);
	}
	
	private function favoriteUpdate(event:Event):void{
		this.dataArray = GameContext.instance.getPlayerObj().favoriteManager.favoriteArray;
		if(this.dataArray.length>3){
			this.width=300;
		}else{
			this.width=280;
		}
	}
	
	/**
	 * @param event
	 * 添加收藏
	 */	
	private function addFavHandler(event:FavoriteEvent):void{
		//判断收藏是否超过最大数量
		var favoriteAry:ArrayCollection =GameContext.instance.getPlayerObj().favoriteManager.favoriteArray;
		if(favoriteAry.length>=FieldConstant.COLLECT_FIELD_LIMIT){
			MyAlert.show(MultiLang.msg('favorite.collect.limit',FieldConstant.COLLECT_FIELD_LIMIT));
			return;
		}
		
		//判断收藏的是否是自己的城
		var castleAry:Array = GameContext.instance.getPlayerObj().castelArray;
		for(var i:int=0;i<castleAry.length;i++){
			var castle:CastleObj = castleAry[i] as CastleObj;
			if(castle.idField == event.idField){
				MyAlert.show("favorite.isCan't,collect.own");
				return;
			}
		}		

		this.addOrupdateFavorite(event.idField,event.remark);
	}

	/**
	 * @param event
	 * 更新收藏
	 */	
	private function updateFavHandler(event:FavoriteEvent):void{
		var bean:FieldCollectBean = event.evtData as FieldCollectBean;

		if(bean ==null || event.remark ==null || oldRemark == event.remark) return;
														
		this.addOrupdateFavorite(bean.fieldId,event.remark);
		this.oldRemark = event.remark;
	}

	/**
	 * @param event
	 * 删除收藏
	 */	
	private function deleteFavHandler(event:FavoriteEvent):void{
		var bean:FieldCollectBean = event.evtData as FieldCollectBean;
		if(bean == null) return;
		
		var onDeleteFavoriteOnresponse:Function = function(event:CommonResponse):void{
			if(!event.isSuccess()){
				MyAlert.showError(event);
			}else{
				EvtDispacther.instance.dispatchEvent(new Event(UPDATE_COLLECT));
			}
		}
		
		ControllerFactory.getInstance().getPlayerController().deleteFieldCollect(bean.fieldId,onDeleteFavoriteOnresponse);
	}
	
	/**
	 *更新与收藏共用函数 
	 * @param idField
	 * @param remark
	 * 
	 */	
	private function addOrupdateFavorite(idField:int,remark:String):void{
		var onAddOrUpdateFieldCollectResponse:Function = function(event:CommonResponse):void{
			if(!event.isSuccess()){
				MyAlert.showError(event);				
			}else{
				EvtDispacther.instance.dispatchEvent(new Event(UPDATE_COLLECT));
			}
		}
		
		ControllerFactory.getInstance().getPlayerController().addOrUpdateFieldCollect(idField,remark,onAddOrUpdateFieldCollectResponse);
	}
	
	/**
	 *获取项目编辑前与编辑后数据 
	 * @param event
	 * 
	 */		
	private function onEditEnd(event:DataGridEvent):void {   
   		var beingEditField:String = event.dataField;  //获得当前列的dataField   
	    if(beingEditField == "remark") {   
	        var oldRemark:String = event.itemRenderer.data.remark; 
//	        this.newRemark= _dataGrid.itemEditorInstance[columnName.editorDataField];
        }   
    }  
	
	/**
	 *项目选择 
	 * @param event
	 * 
	 */	
	private function itemClickHandler(event:ListEvent):void{
//		MsgDispacther.sendEvent(FAVORITE_FIELD_SELECT,event.itemRenderer.data);
	}
	
	/**
	 * 项目回调函数，转换野地id为坐标
	 * @param item
	 * @param column
	 * @return 
	 * 
	 */	
	private function convertCoord(item:Object, column:DataGridColumn):String{
		return "["+int(item.idField/10000)+","+int(item.idField%10000)+"]";
	}
		
	public function removePopup():void{
		PopupWinManager.instance.removePopup();
	}
	
	
