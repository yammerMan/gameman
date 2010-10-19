package views.windows.functionWins.mail.bean
{
	import gs.plugins.VolumePlugin;
	
	import mx.utils.ObjectProxy;
	
	public class SeizeObjct
	{
		public var field:ObjectProxy;
		public var castle:ObjectProxy;
		public function SeizeObjct(o:Object)
		{
			initObject();
			field = o.field;
			castle = o.castle;
		}
		
		private function initObject():void{
			field = null;
			castle = null;
		}

	}
}