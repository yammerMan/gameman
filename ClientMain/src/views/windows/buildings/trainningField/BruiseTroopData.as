package views.windows.buildings.trainningField
{
	import roma.common.valueObject.PairValueBean;
	
	[Bindable]
	public class BruiseTroopData
	{
		public var typeId:int;
		public var value:int;
		public var selected:Boolean=false;
		public function BruiseTroopData()
		{
		}
		public function copyToMe(pairValueBean:PairValueBean):void{
			this.typeId=pairValueBean.typeId;
			this.value=pairValueBean.value;
		}

	}
}