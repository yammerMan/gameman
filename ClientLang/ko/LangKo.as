package
{
	import mx.modules.ModuleBase;
	import mx.resources.IResourceModule;
	import mx.resources.ResourceBundle;

	public class LangKo extends ModuleBase implements IResourceModule
	{

		[ResourceBundle("langImg")]
		private var langImg:ResourceBundle;

		[ResourceBundle("lang")]
		private var lang:ResourceBundle;
		
		[ResourceBundle("item")]
		private var item:ResourceBundle;
		
		[ResourceBundle("quest")]
		private var quest:ResourceBundle;
		
		[ResourceBundle("questType")]
		private var questType:ResourceBundle;
		
		[ResourceBundle("questQuestions")]
		private var questQuestions:ResourceBundle;
		
		[ResourceBundle("serverMsg")]
		private var serverMsg:ResourceBundle;
		
		[ResourceBundle("equip")]
		private var equip:ResourceBundle;
		
		private var bundles:Array;
		
		public function LangKo()
		{
			super();
			bundles = new Array();
			this.bundles.push(this.langImg, this.lang , this.item , this.quest, this.questType , this.questQuestions, this.serverMsg,this.equip);
		}
		
		public function get resourceBundles():Array
		{
			return bundles;
		}
		
	}
}