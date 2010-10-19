package views.windows.buildings.market
{
	import mx.controls.Label;
	
	import roma.common.constants.ResourceConstant;
	import roma.util.MultiLang;

	public class ResourceLabel extends Label
	{
		public function ResourceLabel()
		{
			super();
			this.width = 130;
		}
		
		public function set resouceLabel(type:int):void{
			switch(type){
				case ResourceConstant.TYPE_FOOD:
					this.text = MultiLang.msg("label.food")+":";
				break;
				case ResourceConstant.TYPE_WOOD:
					this.text = MultiLang.msg("label.wood")+":";
				break;
				case ResourceConstant.RESOURCE_TYPE_STONES:
					this.text = MultiLang.msg("label.stone")+":";
				break;
				case ResourceConstant.TYPE_IRON:
					this.text = MultiLang.msg("label.iron")+":";
				break;
			}
		}
		
		public function set resouceText(type:int):void{
			switch(type){
				case ResourceConstant.TYPE_FOOD:
					this.text = MultiLang.msg("label.food");
				break;
				case ResourceConstant.TYPE_WOOD:
					this.text = MultiLang.msg("label.wood");
				break;
				case ResourceConstant.RESOURCE_TYPE_STONES:
					this.text = MultiLang.msg("label.stone");
				break;
				case ResourceConstant.TYPE_IRON:
					this.text = MultiLang.msg("label.iron");
				break;
			}
		}
	}
}