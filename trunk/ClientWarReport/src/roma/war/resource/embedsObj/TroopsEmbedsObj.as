package roma.war.resource.embedsObj
{
	public class TroopsEmbedsObj extends BaseEmbedsObj
	{
		public var offsetX:int = 0;
		public var offsetY:int = 0;
		
		public function TroopsEmbedsObj(typeName:String,actArray:Array)
		{
			super();
			this.statusTypes = typeName;
			this.actionArr = actArray;
		}
		
	}
}