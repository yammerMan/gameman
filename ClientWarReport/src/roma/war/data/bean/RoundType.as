package roma.war.data.bean
{
	import mx.collections.ArrayCollection;
	
	import roma.common.constants.MailConstant;
	
	public class RoundType
	{
		public var actions:ArrayCollection = new ArrayCollection();
		
		public function RoundType(o:Object)
		{
			initType();
			
			if(o != null){
				actions = getActions(String(o));
			}
		}
		
		private function initType():void{
			round.removeAll();
		}
		
		private function getActions(s:String):ArrayCollection{
			var arr:ArrayCollection = new ArrayCollection();
			var a:Array = s.split(MailConstant.SPR_MSG);
			for each(var ss:String in a){
				var act:ActionType = new ActionType(ss);
				arr.addItem(act);
			}
			return arr;
		}
		
	}
}