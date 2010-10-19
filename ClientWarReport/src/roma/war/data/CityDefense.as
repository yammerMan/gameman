package roma.war.data
{
	public class CityDefense
	{
		public function CityDefense()
		{
			wallTotalLife = 0;
			wallCurrentLife = 0;
			
			arrowTower = new CityDefenseNode();
			trap = new CityDefenseNode();
			rockFall = new CityDefenseNode();
		}
		
		public var wallTotalLife:Number = 0;
		public var wallCurrentLife:Number = 0;
		
		//攻进城的回合
		public var insidePosition:Number = -1;
		//CityDefenseNode
		public var arrowTower:CityDefenseNode;
		public var trap:CityDefenseNode;
		public var rockFall:CityDefenseNode;
	}
}