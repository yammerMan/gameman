package roma.war.resource.embedsObj
{
	public class WeaponEmbedsObj extends BaseEmbedsObj
	{
		/** 偏移值（直接就是目标） **/
		public var offsetX:int = 0;
		public var offsetY:int = 0;
		
		public function WeaponEmbedsObj(typeName:String,actArray:Array)
		{
			super();
			this.statusTypes = typeName;
			this.actionArr = actArray;
		}
		
	}
}