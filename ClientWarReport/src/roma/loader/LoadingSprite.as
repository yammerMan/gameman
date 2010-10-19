package roma.loader
{
/* 	import fl.controls.Button;
	import fl.controls.TextArea; */
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;

	public class LoadingSprite extends Sprite
	{
		private var progressText:TextField;
		private var numText:TextField;
		private var loginBtnLabel:TextField;
		private var progressBar:MovieClip;	
		private var progressBarMask:MovieClip;	
		private var loadingNoticeMc:MovieClip;	
		private var actionName:String

		private var debugText:TextField;

		private var totalSize:Number = 10000;//需要下载的总字节数

		private var newFile:Boolean = false;
		private var lastLen:Number = 0;
		private var curTotalLen:Number = 0;
		

		public function LoadingSprite(l:String)
		{
			super();
			var sp:Sprite = new Sprite();
			this.addMovieClip(sp,l);
			
			sp.x = 0;
			sp.y = 0;
			this.addChild(sp);
		}

		public function setDebugTest(str:String):void {
			this.debugText.text = str;
		}

		public function beginLoad(str:String):void {
			this.actionName = str;
			this.newFile = true;
		}

		public function setProgress(value:int):void{
			var percent:Number = value;
			progressBar.visible = true;
			progressBarMask.scaleX = percent/100>1?1:percent/100;

			this.loginBtnLabel.text = percent + "%";
		}

	 	private function addMovieClip(sp:Sprite,l:String):void{
			var loadingProgressMc:Sprite = new Sprite;
			loadingProgressMc.x = 0;
			loadingProgressMc.y = 0;
			sp.addChild(loadingProgressMc);

			[Embed(source="LoadingProgress.swf",symbol = "SmallProgressBg")]
			var SmallProgressBgC:Class;
			var mc2:MovieClip = new  SmallProgressBgC() as MovieClip;
			loadingProgressMc.addChild(mc2);
			if(l == "cn")
				mc2.gotoAndStop("cn");
			else if(l == "big5")
				mc2.gotoAndStop("big5");
			else if(l == "ko")
				mc2.gotoAndStop("ko");
			else{
				mc2.gotoAndStop("en");
			} 
			
			[Embed(source="LoadingProgress.swf",symbol = "ProgressBar")]
			var ProgressBarC:Class
			progressBar = new ProgressBarC as MovieClip;
			progressBar.x = 22;
			progressBar.y = 204;
			progressBar.gotoAndStop(2);
			loadingProgressMc.addChild(progressBar);
			
			[Embed(source="LoadingProgress.swf",symbol = "progressMaskMc")]
			var progressBarMaskMc:Class
			progressBarMask=new progressBarMaskMc() as MovieClip;
			progressBarMask.gotoAndStop(2);
			loadingProgressMc.addChild(progressBarMask);
			progressBar.mask=progressBarMask;
			
			this.loginBtnLabel = new TextField();
			this.loginBtnLabel.x = 200;
			this.loginBtnLabel.y = 202;

			var format:TextFormat = new TextFormat();
			format.align = TextFormatAlign.CENTER;
			format.size = 14;
			format.font = "Tahoma";
			format.color = 0xffffff;
			
			this.loginBtnLabel.defaultTextFormat = format;
			this.loginBtnLabel.mouseEnabled = false;
			loadingProgressMc.addChild(this.loginBtnLabel);
	 	}
	}
}