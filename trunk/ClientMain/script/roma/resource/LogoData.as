package roma.resource
{
	import mx.resources.ResourceManager;
	
	/**
	 * 用于描述各类logo的对象，包括玩家、英雄、联盟logo,
	 */
	public class LogoData
	{
		public var name:String;
		public var source:String;
		
		public function LogoData(imgManager:ImgManager,name:String ){
			this.name = name;
			this.source = ResourceManager.getInstance().getString("imgRes",name);
			if (this.source == null ) {
				this.source = name;
			}
		}

	}
}