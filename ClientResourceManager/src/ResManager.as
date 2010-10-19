package
{
	import mx.modules.ModuleBase;
	import mx.resources.IResourceModule;
	import mx.resources.ResourceBundle;

	public class ResManager extends ModuleBase implements IResourceModule
	{
		private var bundles:Array;
		
		[ResourceBundle("res")]
		private var res:ResourceBundle;
			
		[ResourceBundle("ani")]
		private var ani:ResourceBundle;

		[ResourceBundle("itemPic")]
		private var items:ResourceBundle;
		
		[ResourceBundle("imgRes")]
		private var dymRes:ResourceBundle;

		public function get resourceBundles():Array
		{
			return this.bundles;
		}

		public function ResManager()
		{
			super();
			bundles = new Array();
			bundles.push(res,ani,items,dymRes);
		}
		
	}
}