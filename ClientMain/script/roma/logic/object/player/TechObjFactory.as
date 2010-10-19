package roma.logic.object.player
{
	public class TechObjFactory
	{
		public function TechObjFactory()
		{
		}
		
		private static var instance:TechObjFactory = new TechObjFactory();
		public static function getInstance():TechObjFactory{
			return instance;		
		}
		
		private var armyAttackObj:ArmyAttackObj = new ArmyAttackObj();
		public function getArmyAssistObj():ArmyAttackObj{
			return armyAttackObj;
		}
		
		private var fortificationWearObj:FortificationWearObj = new FortificationWearObj();
		public function getArmyAssistObj():FortificationWearObj{
			return fortificationWearObj;
		}
		
		private var heroAssistObj:HeroAssistObj = new HeroAssistObj();
		public function getArmyAssistObj():HeroAssistObj{
			return heroAssistObj;
		}
	}
}