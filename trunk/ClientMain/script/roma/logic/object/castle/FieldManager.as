package roma.logic.object.castle
{
	import mx.collections.ArrayCollection;
	
	import roma.common.constants.GeneralConstants;
	import roma.common.constants.FieldConstant;
	import roma.common.events.CityFieldUpdate;
	import roma.common.valueObject.WildBean;
	import roma.logic.object.field.BaseField;
	import roma.logic.object.field.impl.DesertField;
	import roma.logic.object.field.impl.ForestField;
	import roma.logic.object.field.impl.HillField;
	import roma.logic.object.field.impl.LakeField;
	
	public class FieldManager
	{
		
		public var fieldObjArray:ArrayCollection = new ArrayCollection();
		
		public function FieldManager(castle:CastleObj , fieldArray:ArrayCollection)
		{
			for each (var bean:WildBean in fieldArray) {
				this.fieldObjArray.addItem(this.newFieldObjInstance(bean));
			}
		}
		
		/**
		 * 野地更新
		 */
		public function updateField(event:CityFieldUpdate):void {
			if (event.updateType == GeneralConstants.UPDATE_ADD_TYPE ) {
				//增加野地
				this.fieldObjArray.addItem(this.newFieldObjInstance(event.bean));
			} else {
				for (var i:int=0 ; i< this.fieldObjArray.length; i++) {
					var fieldObj:BaseField = this.fieldObjArray[i] as BaseField;
					if (fieldObj.idField == event.bean.id) {
						if (event.updateType == GeneralConstants.UPDATE_DELETE_TYPE) {
							//删除野地
							this.fieldObjArray.removeItemAt(i);
						} else {
							//更新野地
							fieldObj.setBean(event.bean);
						}
						break;
					}
				}
			}
		}
		
		private function newFieldObjInstance(bean:WildBean):BaseField {
			var res:BaseField;
			switch (bean.fieldType) {
				case FieldConstant.DESERT_TYPE :
					res = new DesertField();
					break;
				case FieldConstant.TYPE_TREES :
					res = new ForestField();
					break;
				case FieldConstant.HILL_TYPE :
					res = new HillField();
					break;
				case FieldConstant.LAKE_TYPE :
					res = new LakeField();
					break;
			}
			res.setBean(bean);
			return res;
		}		
	}
}