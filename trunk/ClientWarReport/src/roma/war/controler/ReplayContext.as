package roma.war.controler
{
	public class ReplayContext
	{
		public function ReplayContext()
		{
		}
		
		public static function getFieldPostionString(idField:int):String {
			var x:int = idField / 10000;
			var y:int = idField % 10000;
			return "[" + x + "," + y + "]";
		}
		
		public static function getFieldPostionX(idField:int):int {
			return idField / 10000;
		}
		
		public static function getFieldPostionY(idField:int):int {
			return idField % 10000;
		}
		
		
	}
}