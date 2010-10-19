package roma.war.data.bean
{
	import mx.collections.ArrayCollection;
	import mx.utils.ObjectProxy;
	
	public class BattleTroopType
	{
		public var lordName:String;
		public var heroName:String;
		public var heroLevel:int;
		public var heroUrl:String;
		public var heroExp:int;
		public var key:int;
		public var injuredPer:int;
		public var cityName:String;
		public var castleFieldId:int;
		public var isNpcHeroForCastle:Boolean;
		
		public var troops:ArrayCollection = new ArrayCollection();
		
		public var group:int = 0;
		public var totalHP:int = 0;
		
		public function BattleTroopType(o:Object,a:Boolean)
		{
			o.hasOwnProperty('LordName')?lordName = o.LordName:null;
			heroName = o.heroName;
			heroLevel = o.heroLevel;
			heroUrl = o.heroUrl;
			heroExp = o.heroExp;
			key = o.key;
			injuredPer = o.injuredPer;
			isNpcHeroForCastle = o.hasOwnProperty("isNpcHeroForCastle")?o.isNpcHeroForCastle:false; 
			
			cityName = o.hasOwnProperty("cityName")?o.cityName:null;
			castleFieldId = o.hasOwnProperty("castleFieldId")?o.castleFieldId:-1;
			
			troops = setTroops(o.troopUnit);
			group = (a==true)?0:1;
			totalHP = setHP();
		}
		
 		private function setTroops(o:Object):ArrayCollection{
			var arr:ArrayCollection = new ArrayCollection();
			if(o is ObjectProxy){
				arr.addItem(o);
			}
			else if(o is ArrayCollection){
				for each(var oo:ObjectProxy in o){
					arr.addItem(oo);
				}
			}
			return arr;
		} 
		
		private function setHP():Number{
			var count:Number = 0;
			for each(var o:Object in troops){
				if(o.hasOwnProperty('life')){
					count += o.life*(o.count+o.lose);
				}else{
					count += 0;
				}
			}
			return count;
		}
		
	}
}