package roma.logic.object.castle
{
	import flash.utils.Dictionary;
	
	public class ItemHelp
	{
		private static var instance:ItemHelp = new ItemHelp();
		private var armyItemsConsumeHoursDic:Dictionary = new Dictionary();
		
		public function ItemHelp()
		{
			armyItemsConsumeHoursDic["Triarii.1.consumeHours"] = 40;
			armyItemsConsumeHoursDic["Triarii.2.consumeHours"] = 400;
			armyItemsConsumeHoursDic["Triarii.3.consumeHours"] = 4000;
			armyItemsConsumeHoursDic["Archers.1.consumeHours"] = 50;
			armyItemsConsumeHoursDic["Archers.2.consumeHours"] = 500;
			armyItemsConsumeHoursDic["Archers.3.consumeHours"] = 5000;
			armyItemsConsumeHoursDic["UrbanCohort.1.consumeHours"] = 360;
			armyItemsConsumeHoursDic["UrbanCohort.2.consumeHours"] = 3600;
			armyItemsConsumeHoursDic["UrbanCohort.3.consumeHours"] = 36000;
			armyItemsConsumeHoursDic["Scout.1.consumeHours"] = 60;
			armyItemsConsumeHoursDic["Scout.2.consumeHours"] = 600;
			armyItemsConsumeHoursDic["Scout.3.consumeHours"] = 6000;
			armyItemsConsumeHoursDic["Cavalry.1.consumeHours"] = 180;
			armyItemsConsumeHoursDic["Cavalry.2.consumeHours"] = 1800;
			armyItemsConsumeHoursDic["Cavalry.3.consumeHours"] = 18000;
			armyItemsConsumeHoursDic["Ballista.1.consumeHours"] = 200
			armyItemsConsumeHoursDic["Ballista.2.consumeHours"] = 2000;
			armyItemsConsumeHoursDic["Ballista.3.consumeHours"] = 20000;
			armyItemsConsumeHoursDic["Onagers.1.consumeHours"] = 1500;
			armyItemsConsumeHoursDic["Onagers.2.consumeHours"] = 15000;
			armyItemsConsumeHoursDic["Onagers.3.consumeHours"] = 150000;
		}
		
		public static function getArmyItemsConsumeHours(id:String):int{
			if(instance.armyItemsConsumeHoursDic.hasOwnProperty(id+".consumeHours")){
				return instance.armyItemsConsumeHoursDic[id+".consumeHours"];
			}
			return -1;
		}
		
	}
}