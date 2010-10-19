package roma.util
{
	import flash.display.BitmapData;
	import flash.display.Graphics;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.navigateToURL;
	import flash.utils.ByteArray;
	import flash.utils.Timer;
	
	import mx.core.Application;
	import mx.core.UIComponent;
	import mx.graphics.codec.JPEGEncoder;
	
	import roma.logic.CaesaryConfig;
	import roma.logic.GameContext;
	
	import views.spreadUI.MyAlert;

	public class ScreenCaptuerUploader extends UIComponent
	{
		public static var instance:ScreenCaptuerUploader = new ScreenCaptuerUploader();
		
		private var loader:URLLoader = new URLLoader();
		private var timer:Timer = new Timer(100,1);
		private var imgUrl:String
		
		public function ScreenCaptuerUploader() {
			super();
			this.visible = false;
			this.drawArrow();
						
			this.timer.addEventListener(TimerEvent.TIMER , this.upload);
		}

		private function onComplete(event:Event):void {
			this.loader.removeEventListener(Event.COMPLETE,this.onComplete);
			this.imgUrl = this.loader.data 
				+ "&accountName=" + encodeURI(GameContext.instance.getPlayerObj().getPlayerInfo().accountName)
				+ "&playerName=" + encodeURI(GameContext.instance.getPlayerObj().getPlayerInfo().playerName)
				+ "&totalPay="  + GameContext.instance.getPlayerObj().getPlayerInfo().totalPay
				+ "&serverName=" +  GameContext.instance.serverInfo.serverName
				+ "&bugMailId=" + CaesaryConfig.instance.bugMailId;
				
			MyAlert.show(MultiLang.msg("submit.bug.screencapture.uploaded"), onConfirm , "default" , null);
		}
		
		private function onConfirm(ok:Boolean):void {
			this.visible = false;
			navigateToURL(new URLRequest(this.imgUrl), "_blank");
		}
		
		private function upload(event:Event):void {
			var ap:UIComponent = UIComponent(Application.application);
			var ax:int = ap.mouseX;
			var ay:int = ap.mouseY;
			
			var bmpData:BitmapData = new BitmapData(ap.width , ap.height);
			bmpData.draw(ap);
			
			//bmpData.draw(this,new Matrix());
			
			var enconder:JPEGEncoder = new JPEGEncoder(25);
			var pngBytes:ByteArray = enconder.encode(bmpData);
			
			var request:URLRequest = new URLRequest(CaesaryConfig.instance.bugReportUrl);
			request.contentType = "application/octet-stream";
			request.method = URLRequestMethod.POST;
			request.data = pngBytes;
			
			try {
				this.loader.load(request);
				this.loader.addEventListener(Event.COMPLETE , onComplete);
			} catch (err:Error){
				//this.visible = false;
			}
		}
		
		private function drawArrow():void {
			var sc:int = 4;
			var g:Graphics = this.graphics;
			g.lineStyle(2,0xff0000);
			g.beginFill(0xff0000,0.2);
			g.lineTo(0, 0);
			g.lineTo(0,    9*sc);
			g.lineTo(3*sc, 6*sc);
			g.lineTo(6*sc, 9*sc);
			g.lineTo(9*sc, 6*sc);
			g.lineTo(6*sc, 3*sc);
			g.lineTo(9*sc, 0);
			g.lineTo(0,0);
			g.endFill();
		}
		
		public function uploadScreen():void {
			if (this.visible) {
				return;
			}
			var ap:UIComponent = UIComponent(Application.application);
			this.x = ap.mouseX;
			this.y = ap.mouseY;
			this.visible = true;
			
			this.timer.start();
		}
	}
}