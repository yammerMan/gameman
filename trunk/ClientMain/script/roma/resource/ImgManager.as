package roma.resource
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	
	import mx.collections.ArrayCollection;
	import mx.logging.ILogger;
	import mx.logging.Log;
	import mx.resources.ResourceManager;
	
	public class ImgManager
	{
		
		private static var log:ILogger = Log.getLogger("roma.resource.ImgManager");
		 
		public static const instance:ImgManager = new ImgManager(); 
		
		public var itemMcClazz:Class;
		
		private var matrix:Matrix = new Matrix();
		
		private var itemMc:MovieClip;
		
		private var rect:Rectangle;
		
		private var tempBitmap:Bitmap;
		
		private var malePlayerLogos:ArrayCollection = new ArrayCollection();
		private var femalePlayerLogos:ArrayCollection = new ArrayCollection();
		private var cityLogos:ArrayCollection = new ArrayCollection();
		private var allianceTopLogos:ArrayCollection = new ArrayCollection();
		private var allianceMiddleLogos:ArrayCollection = new ArrayCollection();
		private var allianceBottomLogos:ArrayCollection = new ArrayCollection();

		public function ImgManager() {
			this.initPlayerLogos();
//			this.initItemMc();
		}
		
		private function initItemMc():void{
			itemMcClazz= ResourceManager.getInstance().getClass("res","turntable.itemResource");
			rect=new Rectangle(0,0,150,67);
			tempBitmap=new Bitmap();
			if (itemMcClazz == null) {
				throw new Error("无法找到item的图片mc");
			}else{
				itemMc=new itemMcClazz;
			}
		}
		
		private function initPlayerLogos():void {
 			this.malePlayerLogos.addItem(new LogoData(this,"logo.player.a1"));
			this.malePlayerLogos.addItem(new LogoData(this,"logo.player.a2"));
			this.malePlayerLogos.addItem(new LogoData(this,"logo.player.a3"));
 			this.malePlayerLogos.addItem(new LogoData(this,"logo.player.a4"));
			this.malePlayerLogos.addItem(new LogoData(this,"logo.player.a5"));
			this.malePlayerLogos.addItem(new LogoData(this,"logo.player.a6"));
 			this.malePlayerLogos.addItem(new LogoData(this,"logo.player.a7"));
			this.malePlayerLogos.addItem(new LogoData(this,"logo.player.a8"));
			this.malePlayerLogos.addItem(new LogoData(this,"logo.player.a9"));
			
			this.femalePlayerLogos.addItem(new LogoData(this,"logo.player.b1"));
			this.femalePlayerLogos.addItem(new LogoData(this,"logo.player.b2"));
			this.femalePlayerLogos.addItem(new LogoData(this,"logo.player.b3")); 
			this.femalePlayerLogos.addItem(new LogoData(this,"logo.player.b4"));
			this.femalePlayerLogos.addItem(new LogoData(this,"logo.player.b5"));
			this.femalePlayerLogos.addItem(new LogoData(this,"logo.player.b6")); 
			this.femalePlayerLogos.addItem(new LogoData(this,"logo.player.b7"));
			this.femalePlayerLogos.addItem(new LogoData(this,"logo.player.b8"));
			this.femalePlayerLogos.addItem(new LogoData(this,"logo.player.b9")); 
			
			this.cityLogos.addItem(new LogoData(this,"logo.city.a1")); 
			this.cityLogos.addItem(new LogoData(this,"logo.city.a2")); 
			this.cityLogos.addItem(new LogoData(this,"logo.city.a3")); 
			this.cityLogos.addItem(new LogoData(this,"logo.city.a4"));
			
			this.allianceTopLogos.addItem(new LogoData(this,"allianceTopLogo.1")); 
			this.allianceTopLogos.addItem(new LogoData(this,"allianceTopLogo.2")); 
			this.allianceTopLogos.addItem(new LogoData(this,"allianceTopLogo.3"));
			this.allianceTopLogos.addItem(new LogoData(this,"allianceTopLogo.4"));
			this.allianceTopLogos.addItem(new LogoData(this,"allianceTopLogo.5"));
			this.allianceTopLogos.addItem(new LogoData(this,"allianceTopLogo.6"));
			this.allianceTopLogos.addItem(new LogoData(this,"allianceTopLogo.7"));
			this.allianceTopLogos.addItem(new LogoData(this,"allianceTopLogo.8"));
			this.allianceTopLogos.addItem(new LogoData(this,"allianceTopLogo.9"));
			this.allianceTopLogos.addItem(new LogoData(this,"allianceTopLogo.10")); 			
			this.allianceTopLogos.addItem(new LogoData(this,"allianceTopLogo.11")); 
			this.allianceTopLogos.addItem(new LogoData(this,"allianceTopLogo.12")); 
			this.allianceTopLogos.addItem(new LogoData(this,"allianceTopLogo.13"));
			this.allianceTopLogos.addItem(new LogoData(this,"allianceTopLogo.14"));
			this.allianceTopLogos.addItem(new LogoData(this,"allianceTopLogo.15"));
			this.allianceTopLogos.addItem(new LogoData(this,"allianceTopLogo.16"));
			this.allianceTopLogos.addItem(new LogoData(this,"allianceTopLogo.17"));
			this.allianceTopLogos.addItem(new LogoData(this,"allianceTopLogo.18"));
			this.allianceTopLogos.addItem(new LogoData(this,"allianceTopLogo.19"));
			this.allianceTopLogos.addItem(new LogoData(this,"allianceTopLogo.20"));
			this.allianceTopLogos.addItem(new LogoData(this,"allianceTopLogo.21")); 			
			
			this.allianceMiddleLogos.addItem(new LogoData(this,"allianceMiddleLogo.1")); 
			this.allianceMiddleLogos.addItem(new LogoData(this,"allianceMiddleLogo.2")); 
			this.allianceMiddleLogos.addItem(new LogoData(this,"allianceMiddleLogo.3"));
			this.allianceMiddleLogos.addItem(new LogoData(this,"allianceMiddleLogo.4")); 
			
			this.allianceBottomLogos.addItem(new LogoData(this,"allianceBottomLogo.1")); 
			this.allianceBottomLogos.addItem(new LogoData(this,"allianceBottomLogo.2")); 
			this.allianceBottomLogos.addItem(new LogoData(this,"allianceBottomLogo.3"));
			this.allianceBottomLogos.addItem(new LogoData(this,"allianceBottomLogo.4")); 
			this.allianceBottomLogos.addItem(new LogoData(this,"allianceBottomLogo.5"));   
		}

		public function getPlayerLogos(sex:int):ArrayCollection {
			if (sex==0) {
				return this.malePlayerLogos;
			} else {
				return this.femalePlayerLogos;
			}
		}
		
		public function getCityLogos():ArrayCollection{
			return this.cityLogos;
		}
		
		public function getLeagueTopLogos():ArrayCollection{
			return this.allianceTopLogos;
		}
		
		public function getLeagueMiddleLogos():ArrayCollection{
			return this.allianceMiddleLogos;
		}
		
		public function getLeagueBottomLogos():ArrayCollection{
			return this.allianceBottomLogos;
		}
		
		public static function clazz(name:String):* {
			var res:Class = null;
			if(name != ""){
				res = ResourceManager.getInstance().getClass("res",name);
				if (res ==null) {
//					log.error("找不到绑定的资源:" + name);
					if(ImgManager.dynamicClazz(name)==""){
						log.error("绑定与动态都没有的资源:" + name);
					}else{
						return ImgManager.dynamicClazz(name);
					}
				}
			}
			
			return res;
		}
		
		public static function dynamicClazz(name:String,sourceName:String="imgRes"):String {
			var res:String = "";
			if(name != ""){
				res = ResourceManager.getInstance().getString(sourceName,name);
				if (res =="") {
					log.error("找不到动态资源:" + name);
				}
			}
			
			return res;
		}
		
		//获取指定源文件的图片
		public static function appointedClazz(sourceFile:String,name:String):Class {
			var res:Class = null;
			if(name != ""){
				res = ResourceManager.getInstance().getClass(sourceFile,name);
				if (res ==null) {
					log.error("找不到资源:" + name);
				}
			}
			
			return res;
		}
		
		public static function allianceRightsLogo(rightsId:int):Class {
			return clazz("allianceRight." + rightsId);
		}
		
		public static function getItemPic(name:String):String{
			return ImgManager.dynamicClazz(name+".icon","itemPic");
		}
		
		public static function getItemBitmap(name:String):Bitmap{
			var	bitmap:Bitmap=new Bitmap();
			bitmap.bitmapData=new BitmapData(ImgManager.instance.rect.width,ImgManager.instance.rect.height,true,0);
			if(ImgManager.instance.checkItemMcLabel(name)){
				ImgManager.instance.itemMc.gotoAndStop(name);
				bitmap.bitmapData.draw(ImgManager.instance.itemMc, ImgManager.instance.matrix,null,null,ImgManager.instance.rect,true);
			}
			return bitmap;
		}
		
		private function checkItemMcLabel(name:String):Boolean{
			var boo:Boolean=false;
			if(itemMc!=null){
				for (var i:int=0; i<itemMc.currentLabels.length; i++){
					if(itemMc.currentLabels[i].name==name){
						boo=true;
						break;
					}
				}
			}
			return boo;
		}
	}
}