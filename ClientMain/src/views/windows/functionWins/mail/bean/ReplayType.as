package views.windows.functionWins.mail.bean
{
	import mx.collections.ArrayCollection;
	import mx.utils.ObjectProxy;
	
	import roma.common.constants.LetterConstant;
	
	public class ReplayType
	{
		public var round:ArrayCollection = new ArrayCollection();
/* 		public var attacker:ArrayCollection = new ArrayCollection();
		public var defender:ArrayCollection = new ArrayCollection();
		public var fort:ObjectProxy = new ObjectProxy(); */
		
		public function ReplayType(o:Object)
		{
			initType();
			
			if(o != null){
				round = getRound(String(o));
			}
		}
		
		private function initType():void{
			round.removeAll();
		}
		
		private function getRound(s:String):ArrayCollection{
			var arr:ArrayCollection = new ArrayCollection();
			var a:Array = s.split(LetterConstant.SPR_MSG);
			for each(var ss:String in a){
				var rt:RoundType = new RoundType(ss);
				arr.addItem(rt);
			}
			return arr;
		}
		
	}
}