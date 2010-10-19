package roma.war.ui.result
{
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	import roma.war.resource.MultiLang;

	public class ResultButton extends MovieClip
	{
		[Embed(source="../../resource/embeds/button_Common-Normal.png",mimeType="image/png")]
		public var ResultBtnBg:Class;
		
		private var btnBg:BitmapScale9Grid;
		private var btnText:TextField = new TextField();
		private var textFormat:TextFormat = new TextFormat();		
		public function ResultButton()
		{
			super();
			var r:Bitmap = new ResultBtnBg() as Bitmap;
			btnBg = new BitmapScale9Grid(r,3,18,3,7);
			btnBg.width = 100;
			btnBg.height =  22;
			this.addChild(btnBg);
			textFormat = new TextFormat();
			this.textFormat.font = "Tahoma";
			
			btnText.width = 100;
			btnText.autoSize = TextFieldAutoSize.CENTER;
			btnText.text = MultiLang.msg("war.ui.text.result")
			this.addChild(btnText);
			
			setFormat();
		}
		
		private function setFormat():void{
			btnText.setTextFormat(textFormat);
		}
		
		override public function set width(w : Number) : void {
			this.btnBg.width = w;
		}
		
		override public function set height(h : Number) : void {
			this.btnBg.height = h;
		}
	}
}