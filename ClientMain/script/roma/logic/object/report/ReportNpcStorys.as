package roma.logic.object.report
{
	import mx.resources.ResourceManager;
	
	public class ReportNpcStorys
	{
		public function ReportNpcStorys()
		{
		}
		
		public static function getStorys(npcIndex:int):String{
			var key:String = "report.battle.npc.shortTale."+String(npcIndex);
			var value:String = ResourceManager.getInstance().getString("lang" , key);
			if(value != null){return value;}
			else return "";
		}
		
	}
}