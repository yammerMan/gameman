package views.windows.functionWins.mail.bean
{
	import mx.collections.ArrayCollection;
	import mx.utils.ObjectProxy;
	[Bindable]
	public class ScoutType
	{
		public var scoutNum:int = 0;
		public var remainScout:int = 0;
		public var targetFieldId:int = 0;
		public var targetType:int = 0;
		public var targetLev:int = 0;
		public var target:String = "";
		public var result:int = 0;
		
		public var castleType:CastleType;
		public var troopsList:ArrayCollection = new ArrayCollection();
		public var herosList:ArrayCollection = new ArrayCollection();
		public var techsList:ArrayCollection = new ArrayCollection();
		public function ScoutType(o:Object)
		{
			scoutNum = o.scoutNum;
			remainScout = o.remainScout;
			targetFieldId = o.targetFieldId;
			targetType = o.targetType;
			target = o.targetName;
			targetLev = o.targetLevel;
			result = o.result;
			
			castleType = o.hasOwnProperty('castle')?new CastleType(o.castle):null;
			troopsList = o.hasOwnProperty('troops')?getTroopList(o.troops.troopUnit):new ArrayCollection();
			herosList = o.hasOwnProperty('heros')?getList(o.heros.hero):new ArrayCollection();
			techsList = o.hasOwnProperty('techs')?getList(o.techs.techType):new ArrayCollection();
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
		
		private function getTroopList(o:Object):ArrayCollection{
			var arr:ArrayCollection = new ArrayCollection();
			if(o is ObjectProxy){
				var t:ObjectProxy = new ObjectProxy();
			 	t['t'] = o.troopType;
				t['c'] = o.count; 
				arr.addItem(o);
			}
			else if(o is ArrayCollection){
				for each(var oo:ObjectProxy in o){
					arr.addItem({t:oo.troopType,c:oo.count});
				}
			}
			return arr;
		}
	}
}