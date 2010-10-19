package views.windows.buildings.market
{
	import mx.controls.Label;
	
	import roma.common.valueObject.FieldCollectBean;
	import roma.logic.GameContext;
	import roma.logic.object.castle.CastleObj;

	public class RenderLabel extends Label
	{
		public function RenderLabel()
		{
			super();
		}
		
		public function set city(data:Object):void{
			this.text = CastleObj(data).name + " " +GameContext.getFieldPostionString(CastleObj(data).idField);
		}
		
 		public function set favorites(data:Object):void{
			this.text = FieldCollectBean(data).remark+" "+GameContext.getFieldPostionString(FieldCollectBean(data).idField);
		} 
	}
}