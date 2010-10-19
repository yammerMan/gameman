package views.windows.functionWins.ranking
{
	import mx.controls.Label;
	
	import roma.util.MultiLang;

	public class RendererLabel extends Label
	{
		public function RendererLabel()
		{
			super();
		}
		
		public function set rStyle(isTrue:Boolean):void{
			if(isTrue){
				this.styleName = "chatUnionPlayer";
			}
			else{
				this.styleName = "";
			}
		}
		
		public function set rText(str:String):void{
			this.text = str;
		}
		
		public function set title(id:int):void{
			this.text = MultiLang.msg('player.title.'+id);
		}
	}
}