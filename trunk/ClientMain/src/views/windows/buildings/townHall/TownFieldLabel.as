package views.windows.buildings.townHall
{
	import mx.controls.Label;
	
	import roma.common.constants.FieldConstant;
	import roma.util.MultiLang;

	public class TownFieldLabel extends Label
	{
		public function TownFieldLabel()
		{
			super();
		}
		
		public function set coor(id:int):void{
			this.text = "["+String(int(id/10000))+","+String(int(id%10000))+"]";
		}
		
		public function set fieldName(type:int):void{
			var str:String = "";
			switch(type){
				case FieldConstant.FLAT_TYPE:
					str = MultiLang.msg("field.flat.name");
				break;
				case FieldConstant.DESERT_TYPE:
					str = MultiLang.msg("field.desert.name");
				break;
				case FieldConstant.TYPE_TREES:
					str = MultiLang.msg("field.forest.name");
				break;
				case FieldConstant.HILL_TYPE:
					str = MultiLang.msg("field.hill.name");
				break;
				case FieldConstant.LAKE_TYPE:
					str = MultiLang.msg("field.lake.name");
				break;
			}
			this.text = str;
		}
	}
}