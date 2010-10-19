package views.windows.buildings.market
{
	import mx.resources.IResourceManager;
	
	import roma.common.constants.ResourceConstant;
	import roma.util.MultiLang;
	
	[Bindable]
	public class ResourceItemBean
	{
		public var url:String = "";
		public var name:String = "";
		public function ResourceItemBean(resourceId:int)
		{
			switch(resourceId){
				case ResourceConstant.TYPE_FOOD:
					this.url = "icon.food"
					this.name = MultiLang.msg("label.food");
				break;
				case ResourceConstant.TYPE_WOOD:
					this.url = "icon.wood";
					this.name = MultiLang.msg("label.wood");
				break;
				case ResourceConstant.RESOURCE_TYPE_STONES:
					this.url = "icon.stone";
					this.name = MultiLang.msg("label.stone");
				break;
				case ResourceConstant.TYPE_IRON:
				this.url = "icon.iron";
					this.name = MultiLang.msg("label.iron");
				break;
			}
		}
		
	}
}