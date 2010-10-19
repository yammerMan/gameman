package roma.logic.rule
{
	public class DependData
	{
		public var level:int;
		public var typeId:int;
		
		public function DependData(id:int,num:int) {
			this.typeId = id;
			this.level = num;
		}
	}
}