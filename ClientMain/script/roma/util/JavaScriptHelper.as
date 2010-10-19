package roma.util
{
	import flash.external.ExternalInterface;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	
	import mx.logging.ILogger;
	import mx.logging.Log;
	
	import roma.logic.rule.ItemRule;
	
	/**
	 * 专门负责和页面上javascript打交道的帮助类
	 */
	public class JavaScriptHelper
	{
		private var log:ILogger = Log.getLogger("roma.util.JavaScriptHelper");

		public static var instance:JavaScriptHelper = new JavaScriptHelper();
		
		public static const COIN_SPEED:String = "coinSpeed";
		
		public function refreshBrowser():void {
			log.debug("refreshBrowser");
			if (ExternalInterface.available) {
				ExternalInterface.call("refreshBrowser");
			}
		}
		
		public function trackPageview(url:String):void {
			log.debug("trackPageview({0}" , url);
			if (ExternalInterface.available) {
				ExternalInterface.call("trackPageview" , url);
			}
		}
		
		public function addFavorite():void {
			log.debug("addFavorite");
			if (ExternalInterface.available) {
				ExternalInterface.call("addFavorite");
			}
		}
		
		public function getGameUrl():String{
			log.debug("getGameUrl");
			var str:String = "";
			if(ExternalInterface.available){
				str = ExternalInterface.call("function(){return location.href;}");
			}
			return str;
		}
		
		public function callRecharge():void {
			if(ExternalInterface.available){
				ExternalInterface.call("callRecharge()");
			}
		}	
			
		public function trackEvent(category:String, action:String, label:String, value:int):void {
			log.debug("trackEvent");
			if (ExternalInterface.available) {
				ExternalInterface.call("trackEvent", category, action, label , value);
			}
		}
	
		public function onEnterGame():void {
			if (ExternalInterface.available) {
				ExternalInterface.call("onEnterGame");
			}
		}
		
		public function addItemLog(actionType:int , rule:ItemRule, itemId:String=COIN_SPEED, needCoin:int=0):void{
			var id:String = itemId;
			var name:String = "金币加速";
			var itemType:int = -1;
			var price:int = needCoin;
			
			if (rule!=null) {
				id = rule.itemId;
				name = rule.name;
				itemType = rule.itemType;
				price = rule.price;
			}
			
			log.debug("addItemLog({0} , {1},{2},{3},{4}", actionType , id, name, itemType, price);
			if (ExternalInterface.available) {
				ExternalInterface.call("addItemLog" , actionType , id, name, itemType, price);
			}
		}
		
		public function fullScreen(full:Boolean):void {
			if (ExternalInterface.available) {
				ExternalInterface.call("fullScreen" , full);
			}
		}
		
		public function getURL(urlStr:String,window:String="_blank"):void{
			if(!ExternalInterface.available)return;
			var browser:String = ExternalInterface.call("function getBrowser(){return navigator.userAgent}")  as String;
			
			if(browser.indexOf("Firefox")!= -1 || browser.indexOf("MSIE 7.0") != -1){
				ExternalInterface.call('window.open("'+urlStr+'","'+window+'")'); 
			}
			else{
				navigateToURL(new URLRequest(urlStr),window);
			}
		}
		
		public function loginFocus():void{
			if(!ExternalInterface.available)return;
			ExternalInterface.call("function onLoginComp(){document.getElementById('ClientMain').focus()}");
		}
		
		public function jsCallRecharge(url:String):void {
			if(ExternalInterface.available){
				ExternalInterface.call("openRecharge", url);
			}
		}			
	}
}