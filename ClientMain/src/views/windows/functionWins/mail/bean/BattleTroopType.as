package views.windows.functionWins.mail.bean
{
	import mx.collections.ArrayCollection;
	import mx.utils.ObjectProxy;
	
	[Bindable]
	public class BattleTroopType
	{
		public var lordName:String;
		public var heroName:String;
		public var heroLevel:int;
		public var heroUrlPath:String;
		public var heroExp:int;
		public var key:int;
		public var injuredPer:int;
		public var cityName:String;
		public var castleFieldId:int;
		public var isNpcHeroForCastle:Boolean;
		public var isSelfArmy:Boolean;
		
		public var troops:ArrayCollection = new ArrayCollection();
		public function BattleTroopType(o:Object)
		{
			o.hasOwnProperty('LordName')?lordName = o.LordName:null;
			heroName = o.heroName;
			heroLevel = o.heroLevel;
			heroUrlPath = o.heroUrl;
			heroExp = o.heroExp;
			key = o.key;
			injuredPer = o.injuredPer;
			isNpcHeroForCastle = o.hasOwnProperty("isNpcHeroForCastle")?o.isNpcHeroForCastle:false; 
			
			cityName = o.hasOwnProperty("cityName")?o.cityName:null;
			castleFieldId = o.hasOwnProperty("castleFieldId")?o.castleFieldId:-1;
			isSelfArmy = o.isSelfArmy;
			
			troops = setTroops(o.troopUnit);
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
		
	}
}