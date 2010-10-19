package roma.logic.object.player
{
	import mx.collections.ArrayCollection;
	
	import roma.common.constants.GeneralConstants;
	import roma.common.events.FieldCollectUpdate;
	import roma.common.valueObject.FieldCollectBean;
	
	import views.mainModules.map.diamond2.MapDataByteArray;
	
	public class FavoriteManager
	{
		public var favoriteArray:ArrayCollection = new ArrayCollection();
		
		public var filterArray:ArrayCollection = new ArrayCollection();
		
		public function FavoriteManager(favoriteArray:ArrayCollection)
		{
			this.favoriteArray = favoriteArray;
			this.filterFlat();
		}
		
		public function updateFieldFavorite(event:FieldCollectUpdate):void{
			with(event){
				if(updateType == GeneralConstants.UPDATE_ADD_TYPE){
					this.favoriteArray.addItem(bean);
				}else{
					for(var i:int=0;i<this.favoriteArray.length;i++){
						var fieldBean:FieldCollectBean = this.favoriteArray.getItemAt(i) as FieldCollectBean;
						if(bean.fieldId == fieldBean.fieldId){
							if(updateType == GeneralConstants.UPDATE_DELETE_TYPE){
								this.favoriteArray.removeItemAt(i);
							}else{
								bean.copyToBe(fieldBean);
							}
							
							break;
						}
					}
				}
			}

			this.filterFlat();
		}
		
		/**
		 *过滤掉平地 
		 */		
		private function filterFlat():void{
			for each(var bean:FieldCollectBean in this.favoriteArray){
				if(MapDataByteArray.instance.getTileObj(int(bean.fieldId/10000),int(bean.fieldId%10000)) !=null){
					this.filterArray.addItem(bean);
				}
			}
		}
	}
}