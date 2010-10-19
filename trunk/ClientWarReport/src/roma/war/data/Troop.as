package roma.war.data
{
	import mx.collections.ArrayCollection;
	
	public class Troop
	{
		public function Troop()
		{
			items = new ArrayCollection();	
		}
		
		public var items:ArrayCollection;
		
		public function addTroop(tn:TroopNode):void{
			items.addItem(tn);
		}
		
	}
}