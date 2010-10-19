// ActionScript file
			import mx.collections.ArrayCollection;
			
			import roma.common.constants.BuildingConstant;
			import roma.logic.GameContext;
			import roma.logic.object.building.BaseBuilding;
			import roma.logic.object.building.impl.WareHouse;
			import roma.logic.object.castle.CastleObj;
			import roma.logic.object.castle.CastleResourceManager;
			import roma.resource.ImgManager;
			import roma.util.MultiLang;
			
			import views.spreadUI.MyAlert;
			import views.windows.buildings.warehouse.StoreHouseBean;
		
			private var maxValue:int = 100;//NumericStepper的最大值
			
			[Bindable]
		    private var curCastle:CastleObj;
		    
		    [Bindable]
		    private var foodStoreObj:StoreHouseBean=new StoreHouseBean();
		   
		    
		    [Bindable]
		    private var woodStoreObj:StoreHouseBean=new StoreHouseBean();
		   
		    [Bindable]
		    private var stoneStoreObj:StoreHouseBean=new StoreHouseBean();
		     
		    
		    [Bindable]
		    private var ironStoreObj:StoreHouseBean=new StoreHouseBean();
		  
		    
		    [Bindable]
		    private var capability:int;//仓库容量
		    
		    [Bindable]
		    private var wareHouseCount :int;//仓库数量
		    
		    [Bindable]
		    private var storeDataArr:ArrayCollection=new ArrayCollection();
		    
		    private var _buildingObj:BaseBuilding;
		    
		    private var resManager:CastleResourceManager;
		    
			public function set buildingObj(obj:BaseBuilding):void{
				this._buildingObj=obj;
			}
	
			public function refresh():void {
				this.curCastle=GameContext.instance.getPlayerObj().getCurCastleObj();
				this.wareHouseCount=GameContext.instance.getPlayerObj().getCurCastleObj().buildingManager.getMultipleBuildingArrayByType(BuildingConstant.TYPE_WAREHOUSES).length
				this.capability=this.curCastle.resourceManager.maxCap;
				this.resManager=GameContext.instance.getPlayerObj().getCurCastleObj().resourceManager;
				this.getWareData();
			}
			
			public function init():void{
				
			}

			private function getWareData():void{
			   
				this.foodStoreObj.imgSource=ImgManager.clazz("icon.food");
				this.foodStoreObj.amounts=this.curCastle.resourceManager.food.curAmount;
				this.foodStoreObj.storePercent=this.curCastle.resourceManager.foodStorePer;
				this.foodStoreObj.resLimt=Math.ceil(this.capability*this.foodStoreObj.storePercent/100);
			
				
				this.woodStoreObj.imgSource=ImgManager.clazz("icon.wood");
				this.woodStoreObj.amounts=this.curCastle.resourceManager.wood.curAmount;
				this.woodStoreObj.storePercent=this.curCastle.resourceManager.woodStorePer;
				this.woodStoreObj.resLimt=Math.ceil(this.capability*this.woodStoreObj.storePercent/100);

				
				this.stoneStoreObj.imgSource=ImgManager.clazz("icon.stone");
				this.stoneStoreObj.amounts=this.curCastle.resourceManager.stone.curAmount
				this.stoneStoreObj.storePercent=this.curCastle.resourceManager.stoneStorePer;
				this.stoneStoreObj.resLimt=Math.ceil(this.capability*this.stoneStoreObj.storePercent/100);

				
				this.ironStoreObj.imgSource=ImgManager.clazz("icon.iron");
				this.ironStoreObj.amounts=this.curCastle.resourceManager.iron.curAmount;
				this.ironStoreObj.storePercent=this.curCastle.resourceManager.ironStorePer;
				this.ironStoreObj.resLimt=Math.ceil(this.capability*this.ironStoreObj.storePercent/100);
						
				this.maxValue=100-this.foodStoreObj.storePercent-this.woodStoreObj.storePercent-this.stoneStoreObj.storePercent-this.ironStoreObj.storePercent;
				addstoreDataArr();
			}
			private function addstoreDataArr():void{
				this.storeDataArr.removeAll();
				this.storeDataArr.addItem(this.foodStoreObj);
				this.storeDataArr.addItem(this.woodStoreObj);
				this.storeDataArr.addItem(this.stoneStoreObj);
				this.storeDataArr.addItem(this.ironStoreObj);
				this.maxValue=100-this.foodStoreObj.storePercent-this.woodStoreObj.storePercent-this.stoneStoreObj.storePercent-this.ironStoreObj.storePercent;
			}
			//响应调节比例事件
			public function eventChangeHandle(event:*):void{
				this.nsFood.maximum=100;
				this.nsWood.maximum=100;
				this.nsStone.maximum=100;
				this.nsIron.maximum=100;
				var eventId:String= event.target.id;
				switch(eventId){
					case "nsFood":
						this.nsFood.maximum=100-this.nsWood.value-this.nsStone.value-this.nsIron.value;
						if((event.target.value+this.woodStoreObj.storePercent+this.stoneStoreObj.storePercent+this.ironStoreObj.storePercent)<=100){
							this.foodStoreObj.storePercent=(event.target.value+this.woodStoreObj.storePercent+this.stoneStoreObj.storePercent+this.ironStoreObj.storePercent)>100?(100-this.woodStoreObj.storePercent+this.stoneStoreObj.storePercent+this.ironStoreObj.storePercent):event.target.value;
							this.foodStoreObj.resLimt=Math.ceil(event.target.value*this.capability/100);
						}
					break;
					
					case "nsWood":
						this.nsWood.maximum=100-this.nsFood.value-this.nsStone.value-this.nsIron.value;
						if((event.target.value+this.foodStoreObj.storePercent+this.stoneStoreObj.storePercent+this.ironStoreObj.storePercent)<=100){
							this.woodStoreObj.storePercent=(event.target.value+this.foodStoreObj.storePercent+this.stoneStoreObj.storePercent+this.ironStoreObj.storePercent)>100?(100-this.foodStoreObj.storePercent+this.stoneStoreObj.storePercent+this.ironStoreObj.storePercent):event.target.value;
							this.woodStoreObj.resLimt=Math.ceil(event.target.value*this.capability/100);

						}
					break;
					
					case "nsStone":
						this.nsStone.maximum=100-this.nsWood.value-this.nsFood.value-this.nsIron.value;
						if((event.target.value+this.woodStoreObj.storePercent+this.foodStoreObj.storePercent+this.ironStoreObj.storePercent)<=100){
							this.stoneStoreObj.storePercent=(event.target.value+this.woodStoreObj.storePercent+this.foodStoreObj.storePercent+this.ironStoreObj.storePercent)>100?(100-this.woodStoreObj.storePercent+this.foodStoreObj.storePercent+this.ironStoreObj.storePercent):event.target.value;
							this.stoneStoreObj.resLimt=Math.ceil(event.target.value*this.capability/100);
						}
					break;
					
					case "nsIron":
						this.nsIron.maximum=100-this.nsWood.value-this.nsStone.value-this.nsFood.value;
						if((event.target.value+this.woodStoreObj.storePercent+this.stoneStoreObj.storePercent+this.foodStoreObj.storePercent)<=100){
							this.ironStoreObj.storePercent=(event.target.value+this.woodStoreObj.storePercent+this.stoneStoreObj.storePercent+this.foodStoreObj.storePercent)>100?(100-this.woodStoreObj.storePercent+this.stoneStoreObj.storePercent+this.foodStoreObj.storePercent):event.target.value;
							this.ironStoreObj.resLimt=Math.ceil(event.target.value*this.capability/100);
						}
					break;
					
					default:
				}
				addstoreDataArr();
				
			}
			private function modifySubmit(event:MouseEvent):void{
				if((this.nsFood.value+this.nsWood.value+this.nsStone.value+this.nsIron.value)!=100){
					MyAlert.show(MultiLang.msg("wareHouse.notFull"),doModify);
				}else{
					WareHouse(this._buildingObj).modify(this.nsFood.value,this.nsWood.value,this.nsStone.value,this.nsIron.value);
				}
			}
			
			private function doModify(_true:Boolean):void{
				if(_true){
					WareHouse(this._buildingObj).modify(this.nsFood.value,this.nsWood.value,this.nsStone.value,this.nsIron.value);
				}
			}
			private function autoChange():void{
				this.nsFood.maximum=100;
				this.nsWood.maximum=100;
				this.nsStone.maximum=100;
				this.nsIron.maximum=100;
				var total:Number=this.resManager.food.totalProduce-this.resManager.food.troopConsume+this.resManager.wood.totalProduce+this.resManager.stone.totalProduce+this.resManager.iron.totalProduce;
				var foodPer:int=int((this.resManager.food.totalProduce-this.resManager.food.troopConsume)*100/total);
				this.nsFood.value=foodPer;
				this.foodStoreObj.storePercent=this.nsFood.value;
				this.foodStoreObj.resLimt=Math.ceil(this.nsFood.value*this.capability/100);
				
				var woodPer:int;
				if(this.resManager.wood.totalProduce*100/total>0&&foodPer+1<=100&&int(this.resManager.wood.totalProduce*100/total)==0){
					woodPer=1;
				}else{
					woodPer=int(this.resManager.wood.totalProduce*100/total);
				}
				this.nsWood.value=woodPer;
				this.woodStoreObj.storePercent=this.nsWood.value;
				this.woodStoreObj.resLimt=Math.ceil(this.nsWood.value*this.capability/100);
			
				var stonePer:int;
				if(this.resManager.stone.totalProduce*100/total>0&&foodPer+woodPer+1<=100&&int(this.resManager.stone.totalProduce*100/total)==0){
					stonePer=1;
				}else{
					stonePer=int(this.resManager.stone.totalProduce*100/total);
				}
				this.nsStone.value=stonePer;
				this.stoneStoreObj.storePercent=this.nsStone.value;
				this.stoneStoreObj.resLimt=Math.ceil(this.nsStone.value*this.capability/100);
				
				var ironPer:int=100-foodPer-woodPer-stonePer-ironPer;
				this.nsIron.value=ironPer;
				this.ironStoreObj.storePercent=this.nsIron.value;
				this.ironStoreObj.resLimt=Math.ceil(this.nsIron.value*this.capability/100);
				addstoreDataArr();
				
			}