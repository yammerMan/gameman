package roma.war.data.bean
{
	import mx.collections.ArrayCollection;
	import mx.utils.ObjectProxy;
	[Bindable]
	public class CastleType
	{
		public var support:int = 0;
		public var population:int;
		public var complaint:int;
		public var wallLevel:int;
		public var arrowTower:int;
		public var trap:int;
		public var rockFall:int;
		
		public var resourceType:ObjectProxy;
		public var buildingsList:ArrayCollection = new ArrayCollection();
//		public var techsList:ArrayCollection = new ArrayCollection();
		public function CastleType(o:Object)
		{
			support = o.hasOwnProperty('support')?o.support:-1;
			population = o.hasOwnProperty('population')?o.population:-1;
			complaint = o.hasOwnProperty('complaint')?o.complaint:-1;
			wallLevel = o.wallLevel;
			arrowTower = o.hasOwnProperty('arrowTower')?o.arrowTower:-1;
			trap = o.hasOwnProperty('trap')?o.trap:-1;
			rockFall = o.hasOwnProperty('rockFall')?o.rockFall:-1;
			
			resourceType = o.resource;
			buildingsList = o.hasOwnProperty("buildings")?getList(o.buildings.type):new ArrayCollection();
//			techsList = o.hasOwnProperty('techs')?getList(o.techs):new ArrayCollection();
		}
		
		private function getList(o:Object):ArrayCollection{
			var arr:ArrayCollection = new ArrayCollection();
			if(o is ObjectProxy){
				arr.addItem(o);
			}else if(o is ArrayCollection){
				for each(var oo:ObjectProxy in o){
					arr.addItem(oo);
				}
			}
			return arr;
		}
		
	}
}