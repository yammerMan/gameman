package roma.war.data
{
	import roma.common.constants.FieldConstant;
	import roma.war.data.bean.Frames;
	
	
	public class WarData
	{
		public var isIntruder:Boolean = true;
		public var isIntruderSuccess:Boolean = true;
		public var hasWall:Boolean = false;
		
		public var round:int = -1;
		// 战地信息
		public var battlefield:BattlefieldNode;
		public var conquest:XMLList = null;
		
		//wall
		public var cityDefense:CityDefense;
		//heroes 
		public var heroes:Heroes;
		//frames
		public var frames:Frames;
		
		// 是否为征服战
		public function get isConquest():Boolean{
			return conquest != null;
//			return battlefield.battleFieldName.length > 0;
		}
		//攻进城
		public function get hasInsideCastle():Boolean{
			return cityDefense.wallCurrentLife <= 0;
		}
		
		// 是否为城池战
		public function isCastleBattle():Boolean{
			return battlefield.battleFieldType == FieldConstant.TYPE_CITY;
		}
		
		public function WarData()
		{
			battlefield = new BattlefieldNode();
			cityDefense = new CityDefense();
			heroes = new Heroes();
			frames = new Frames();
		}
		
		public function dispose():void{
			battlefield = null;
			cityDefense = null;
			heroes = null;
			frames = null;
		}
		
		public function getRound(p:int):int{
			var rId:int = 0;
			for each(var r:RoundNode in frames.round){
				if(p >r.startIndex && p<r.endIndex){
					rId = r.id;
					break;
				}else{continue;}
			}
			return rId;
		}
		
	}
}