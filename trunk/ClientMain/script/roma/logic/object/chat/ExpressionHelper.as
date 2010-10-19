package roma.logic.object.chat
{
	import flash.utils.Dictionary;
	
	import mx.resources.ResourceManager;
	
	import roma.resource.ImgManager;
	
	public class ExpressionHelper
	{
		public static var instance:ExpressionHelper = new ExpressionHelper();
		public var expreMap:Dictionary = new Dictionary();
		
		public function ExpressionHelper()
		{
			initExpreMap();
		}
		
		private function initExpreMap():void{
			for(var i:int=1;i<=20;i++){
				expreMap["em"+i] = new ExpressionBean("em"+i,getExpreName("em"+i));
			}
		}
		
		public static function getExpreIcon(id:String):Class{
			return ResourceManager.getInstance().getClass("chatExpression" , id+".icon");
		}
		
		public static function getExpreName(id:String):String{
			return ResourceManager.getInstance().getString("chatExpression",id+".name");
		}
	}
}