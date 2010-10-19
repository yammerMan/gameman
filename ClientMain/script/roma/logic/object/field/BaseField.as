package roma.logic.object.field
{
	import flash.display.Bitmap;
	
	import roma.common.valueObject.WildBean;
	
	[Bindable]
	public class BaseField
	{
		public var fieldName:String;
		public var fieldLevel:int;
		public var idField:int;
		public var fieldPos:String;
		public var fieldIcon:Bitmap;
		public var fieldType:int;
		public var fieldPosNoBracket:String;
		
		public function BaseField()
		{
		}
		
		public function setBean(bean:WildBean):void {
			this.fieldName = FieldHelper.getFieldName(bean.fieldType);
			this.fieldIcon= FieldHelper.getFieldMapIcon(bean.fieldType,bean.level);
			this.fieldType=bean.fieldType;
			this.fieldLevel = bean.level;
			this.idField = bean.id;	
			this.fieldPos = "["+String(int(idField/10000))+","+String(int(idField%10000))+"]";
			this.fieldPosNoBracket=String(int(idField/10000))+","+String(int(idField%10000));
		}
	}
}