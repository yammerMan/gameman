package roma.logic.rule.questActionRule
{
	import roma.util.JavaScriptHelper;
	import roma.util.MultiLang;
	
	import views.windows.functionWins.task.TaskConstant;
	
	
	public class FromSiteCollectionRule extends BaseRuleEvent
	{
		public var collectUrlStr:String; 
//		private var gameUrl:String = "";
		public function FromSiteCollectionRule()
		{
			super();
			collectUrlStr = MultiLang.msg('quest.fromFavorite');
		}
		
	/* 	public function isTure():Boolean{
			var b:Boolean = false;
			var str:String = JavaScriptHelper.instance.getGameUrl();
			if(str !=null){
				if(str != ""){
					if(str.indexOf(TaskConstant.FAVORITE_RUNE) >-1){
						b = true;
					}
				}
			}
			return b;
		}
		
		public function getUrl():String{
			//TODO
			var str:String = JavaScriptHelper.instance.getGameUrl();
			if(str !=null){
				if(str.indexOf(TaskConstant.FAVORITE_RUNE)>-1){
				}else{
					str += TaskConstant.FAVORITE_RUNE;
				}
			}	
			return str;
		}*/	
	
	}
}