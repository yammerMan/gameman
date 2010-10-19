package roma.util
{
	import flash.display.DisplayObject;
	import flash.filters.ColorMatrixFilter;
	import flash.filters.GlowFilter;
	
	import mx.effects.Glow;
	[Bindable]
	public class FiltersUtil
	{
		public function FiltersUtil()
		{
			initGlow();
		}
		
		public static var instance:FiltersUtil=new FiltersUtil();
		
		//白色描边效果
		public static var whiteFilter:GlowFilter =new GlowFilter(0xffffff, 1, 2, 2, 100, 1, false, false);
		
		//白色描边3像素效果
		public static var white3Filter:GlowFilter =new GlowFilter(0xffffff, 1, 3, 3, 100, 1, false, false);
		//黑色描边效果
		public static var glowFilter:GlowFilter =new GlowFilter(0x000000, 1, 2, 2, 100, 1, false, false);
		//黑色描边3像素效果
		public static var glowFilter3Pix:GlowFilter =new GlowFilter(0x000000, 1, 3, 3, 100, 1, false, false);
		//绿色描边效果
		public static var greenGlowFilter:GlowFilter =new GlowFilter(0x405f00, 1, 2, 2, 100, 1, false, false);
		//褐色描边效果
		public static var brownGlowFilter:GlowFilter =new GlowFilter(0x5e341b, 1, 2, 2, 100, 1, false, false);
		//褐色描边3效果
		public static var brownGlow3Filter:GlowFilter =new GlowFilter(0x472100, 1, 3, 3, 100, 1, false, false);
		
		//浅绿色描边效果
		public static var greenLightGlowFilter:GlowFilter =new GlowFilter(0x0b7b05, 1, 2, 2, 100, 1, false, false);
		public static var glowFilter1:GlowFilter = new GlowFilter(0xffffff,1,1.5,1.5,100,1,false,false);
 		
 		
 		
 		public static var outfitGrayFilter:GlowFilter =new GlowFilter(0x898989, 1, 3, 3, 100, 1, false, false);
 		public static var outfitGreenFilter:GlowFilter =new GlowFilter(0x61af0d, 1, 3, 3, 100, 1, false, false);
 		public static var outfitBlueFilter:GlowFilter =new GlowFilter(0x0d74af, 1, 3, 3, 100, 1, false, false);
 		public static var outfitPurpleFilter:GlowFilter =new GlowFilter(0x9908cf, 1, 3, 3, 100, 1, false, false);
 		
 		
 		
		private  var glow:Glow=new Glow();
 		
 		//初始化发光滤镜的参数
 		private function initGlow():void{
 			this.glow.alphaFrom=1.0;
 			this.glow.alphaTo=0.8;
 			this.glow.blurXFrom=0.0;
 			this.glow.blurXTo=5.0;
 			this.glow.blurYFrom=0.0;
 			this.glow.blurYTo=5.0;
 			this.glow.color=0x000000;
 		}
 	 	//使用发光滤镜	
 		public function playGlow(instance:DisplayObject):void{
 			this.glow.play([instance]);
 		}
 		//停止发光滤镜
 		public function stopGlow():void{
 			this.glow.stop();
 		}
 		
 		/**
 			处理亮度
 		*/
 		public static var brightnessColorMatrixFilter:ColorMatrixFilter=new ColorMatrixFilter([1.5,0,0,0,
 																							   0,0,1.5,0,
 																							   0,0,0,0,
 																							   1.5,0,0,0,
 																							   0,0,1,0,
 																							   0,0,1,0]); 
 																							   
 		/** 处理暗淡的滤镜 */
 		public static var darkColorMatrixFilter:ColorMatrixFilter = new ColorMatrixFilter([
 																						0.3, 0.59, 0.11, 0,
 																						0, 0.3, 0.59, 0.11, 
 																						0, 0, 0.3, 0.59, 
 																						0.11, 0, 0, 
 																						0, 0, 0, 1, 0
																					 	]);
	}
}