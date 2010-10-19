package reLoader
{
	import fl.controls.Button;
	import fl.controls.TextArea;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.events.ProgressEvent;
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
		

		public function LoadingSprite()
		{
			super();
			var sp:Sprite = new Sprite();
			this.addMovieClip(sp);
			this.initProgressText(sp);
			this.initNumText(sp);
			
			sp.x = 0;
			sp.y = 0;
			this.addChild(sp);
			
			this.debugText = new TextField();
			this.debugText.text = " ";
			sp.addChild(this.debugText);
	 
		}

		public function setDebugTest(str:String):void {
			this.debugText.text = str;
		}

		public function beginLoad(str:String):void {
			this.actionName = str;
			this.newFile = true;
		}

		public function setTotalSize(size:Number):void {
			this.totalSize = size;
		}

		public function setProgressEvent(e:ProgressEvent):void{
			if (e != null && e.bytesTotal >0) {
				
				if (this.newFile) {
					this.newFile = false;
					this.curTotalLen += this.lastLen;
					this.lastLen = e.bytesTotal;
					trace(this.actionName + " " + e.bytesTotal);
				}
				
				var loaded:Number = e.bytesLoaded + this.curTotalLen;
				if (e.bytesTotal + this.curTotalLen > this.totalSize) {
					this.totalSize = e.bytesTotal + this.curTotalLen;
				}
				
				var percent:Number = Math.round(loaded / this.totalSize * 100);
				progressBar.visible = true;
				progressBarMask.scaleX = percent>1?1:percent;
	
				var text:String = this.actionName + "\n" + loaded + "/" + this.totalSize;
	
				this.progressText.text = text;
				this.numText.text = percent + "%";
			} else {
				this.progressText.text = "";
				this.numText.text = "";
				this.progressBar.visible = false;
			}
		}

		private function initProgressText(sp:Sprite):void {
			this.progressText = new TextField();
			this.progressText.height = 40;
			this.progressText.width = 210;
			this.progressText.x = 387+160;
			this.progressText.y = 317+10;
			
			var format:TextFormat = new TextFormat();
			format.align = TextFormatAlign.CENTER;
			format.size = 12;
			format.font = "Tahoma";
			format.color = 0xfdea95;
			
			this.progressText.defaultTextFormat = format;
			this.progressText.mouseEnabled = false;
			sp.addChild(this.progressText);
		}

		private function initNumText(sp:Sprite):void {
			this.numText = new TextField();
			this.numText.x = 391+160;
			this.numText.y = 345+10;
			this.numText.width = 210;

			var format:TextFormat = new TextFormat();
			format.align = TextFormatAlign.CENTER;
			format.size = 80;
			format.font = "Arial";
			format.color = 0xffffff;

			var nemTextBg:Sprite= new Sprite();
			nemTextBg.x =116+270;
			nemTextBg.y = 141+49+125;
			nemTextBg.graphics.beginFill(0x000000,.5);
			nemTextBg.graphics.drawRect(0,0,480,128);
			nemTextBg.graphics.endFill();
			sp.addChild(nemTextBg);
			
			this.numText.defaultTextFormat = format;
			this.numText.mouseEnabled = false;
			sp.addChild(this.numText);
		}

	 	private function addMovieClip(sp:Sprite):void{
//			[Embed(source="fla/LoadingProgress.swf",symbol = "preLoadingBg")]				
//			var GameLogoC:Class;
//			var mc:MovieClip = new GameLogoC() as MovieClip;
//			mc.gotoAndStop(2);
//			this.addChild(mc);
//			LoadingHandle.instance.addBGMovieClip(sp);
//			LoadingHandle.instance.addArmyMovieClip(sp);
	
			var loadingProgressMc:Sprite = new Sprite;
			loadingProgressMc.x = 0;
			loadingProgressMc.y = 0;
			sp.addChild(loadingProgressMc);
			
			

			[Embed(source="fla/LoadingProgress.swf",symbol = "SmallProgressBg")]
			var SmallProgressBgC:Class;
			var mc2:MovieClip = new  SmallProgressBgC() as MovieClip;
			mc2.x =139;
			mc2.y = 466;
			mc2.gotoAndStop(2);
			mc2.width = 734;
			mc2.height=59;
			loadingProgressMc.addChild(mc2);
			
			[Embed(source="fla/LoadingProgress.swf",symbol = "ProgressBar")]
			var ProgressBarC:Class
			progressBar = new ProgressBarC as MovieClip;
			progressBar.x =179;
			progressBar.y = 485;
			progressBar.gotoAndStop(2);
			progressBar.width=653;
			progressBar.height=25;
			loadingProgressMc.addChild(progressBar);
			progressBar.visible = false;
			
			[Embed(source="fla/LoadingProgress.swf",symbol = "progressMaskMc")]
			var progressBarMaskMc:Class
			progressBarMask=new progressBarMaskMc() as MovieClip;
			progressBarMask.x=179;
			progressBarMask.y=467;
			progressBarMask.gotoAndStop(2);
			progressBarMask.width=653;
			progressBarMask.height=60;
			loadingProgressMc.addChild(progressBarMask);
			progressBar.mask=progressBarMask;
			
			/* var noticeTextArea:TextArea=new TextArea();
			noticeTextArea.width=223;
			noticeTextArea.height=260;
			noticeTextArea.x=645-510;
			noticeTextArea.y=156;
			noticeTextArea.htmlText=LoadingHandle.instance.newString;
			LoadingHandle.instance.addTextArea(noticeTextArea);
			loadingProgressMc.addChild(noticeTextArea);
			
			var addBtn:Button=new Button();
			addBtn.width=110;
			addBtn.height=24;
			addBtn.x=710-515;
			addBtn.y=420;
			addBtn.label="";
//			addBtn.textField.textColor=0xffffff;
//			addBtn.label="Free Sign_up";
			addBtn.addEventListener(MouseEvent.MOUSE_DOWN,clickHandle);
//			addBtn.setStyle("fontSize",11);
//			addBtn.setStyle("color",0xffffff);
//			addBtn.setStyle("fontFamily","Tahoma,'宋体'");

			this.loginBtnLabel = new TextField();
			this.loginBtnLabel.x = 710-515;
			this.loginBtnLabel.y = 422;
			this.loginBtnLabel.width = 110;
			this.loginBtnLabel.height = 24;

			var format:TextFormat = new TextFormat();
			format.align = TextFormatAlign.CENTER;
			format.size = 11;
			format.font = "Tahoma";
			format.color = 0xffffff;
			
			
			this.loginBtnLabel.defaultTextFormat = format;
			this.loginBtnLabel.mouseEnabled = false;
			this.loginBtnLabel.text="Free Sign_up";
			sp.addChild(this.loginBtnLabel);
			function clickHandle(event:MouseEvent):void{
				
			}
			loadingProgressMc.addChild(addBtn); */
	 	}
	}
}