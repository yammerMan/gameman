package views.spreadUI.troop
{
	import flash.utils.Dictionary;
	
	import roma.resource.ImgManager;
	import roma.util.MultiLang;
	
	public class TroopSkillHelper
	{
		public static var instance:TroopSkillHelper = new TroopSkillHelper();
		
		private var skillMap:Dictionary = new Dictionary();
		
		public function TroopSkillHelper()
		{
			initSkillMap();
		}
		
		private function initSkillMap():void{
			skillMap[TroopSkillConstant.LONGRANGESTRIKE] 					="longrangestrike";     
			skillMap[TroopSkillConstant.PERFORATION] 					    ="perforation";     
			skillMap[TroopSkillConstant.RESISTRUSH] 					    ="resistrush";     
			skillMap[TroopSkillConstant.RUSH] 					            ="rush";     
			skillMap[TroopSkillConstant.SCATTERING] 					    ="scattering";     
			skillMap[TroopSkillConstant.SIDEINJURE] 				 	    ="sideinjure";     
			skillMap[TroopSkillConstant.SWEEPARMY] 					        ="sweeparmy";     
			skillMap[TroopSkillConstant.TOZT] 					            ="tozt";     
			skillMap[TroopSkillConstant.TURTLEBACK] 					    ="turtleback";     
		}
		
		public function getSkillName(type:String):String{
			var key:String = skillMap[type];
			return MultiLang.msg(key+'.name');   
		}

		public function getSkillDesc(type:String):String{
			var key:String = skillMap[type];
			return MultiLang.msg(key+'.desc');   
		}
		
		public function getSkillIcon(type:String):String{
			var key:String = skillMap[type];
			return ImgManager.clazz(key+'.icon');   
		}
	}
}