package roma.logic.rule
{
	import mx.resources.IResourceManager;
	import mx.resources.ResourceManager;
	
	import roma.resource.ImgManager;
	
	[Bindable]
	public class ItemRule
	{
		public var itemId:String;
		public var price:int;
		public var user_limit:int;
		public var day_limit:int;
		public var itemType:int;
		public var isHeroItem:Boolean;
		public var isPlayerItem:Boolean;
		public var keyItemId:String;

		public var name:String;
		public var itemDesc:String;
		public var funcDesc:String;
		public var itemIcon:String;

		public function ItemRule(
			itemId:String,
			price:int,
			user_limit:int,
			day_limit:int,
			itemType:int,
			isHeroItem:Boolean,
			isPlayerItem:Boolean,
			keyItemId:String)
		{
			this.itemId     = itemId     ;                  
			this.price      = price      ;
			this.user_limit = user_limit ;
			this.day_limit  = day_limit  ;
			this.itemType   = itemType   ;
			this.isHeroItem = isHeroItem ;
			this.isPlayerItem = isPlayerItem;
			this.keyItemId = keyItemId;

			var rm:IResourceManager = ResourceManager.getInstance();
			this.name       = rm.getString("item" , itemId + ".name");
			this.itemDesc   = rm.getString("item" , itemId + ".itemDesc");
			this.funcDesc   = rm.getString("item" , itemId + ".funcDesc");
//			this.itemIcon   = rm.getString("itemPic" , itemId + ".icon");
			this.itemIcon   = ImgManager.getItemPic(itemId);
		}
	}
}