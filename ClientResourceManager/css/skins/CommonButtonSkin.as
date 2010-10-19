package skins{
	import flash.display.GradientType;
	import flash.display.Graphics;
	import flash.display.SpreadMethod;
	import flash.geom.Matrix;
	public class CommonButtonSkin extends RecBorder {
		private var spreadMethod:String=SpreadMethod.PAD;
		private var fillType:String=GradientType.LINEAR;
		private var g:Graphics=graphics;
		private var matr:Matrix;
		private var alphas:Array=[1,1];
		private var ratios:Array=[0x00,0xFF];
		private var unscaledWidth:Number;
		private var unscaledHeight:Number;
		private var cornerRadius:Number;
		public function CommonButtonSkin() {
		}
		override protected function updateDisplayList(unscaledWidth:Number,unscaledHeight:Number):void {
			if (! parent) {
				return;
			}

			super.updateDisplayList(unscaledWidth,unscaledHeight);
			g.clear();

			this.cornerRadius=getStyle("cornerRadius");
			if (isNaN(cornerRadius)) {
				this.cornerRadius=0;
			}
			this.unscaledHeight=unscaledHeight;
			this.unscaledWidth=unscaledWidth;


			matr=new Matrix  ;

			matr.createGradientBox(20,20,0,0,0);
			matr.rotate(Math.PI/2);

			g.clear();
			switch (name) {
				case "UpSkin" :
				case "upSkin" :
					{
						drawUp();
						break;






					};
				case "OverSkin" :
				case "overSkin" :
					{
						drawOver();
						break;






					};
				case "DownSkin" :
				case "downSkin" :
					{
						drawDown();

						break;






					};
				case "DisabledSkin" :
				case "disabledSkin" :
					{
						drawDisable();
						break;






					};
				case "SelectedOverSkin" :
				case "selectedOverSkin" :
					{
						drawOver();
						break;






					};
				case "SelectedUpSkin" :
				case "selectedUpSkin" :
					{
						drawUp();
						break;






					};
				case "SelectedDownSkin" :
				case "selectedDownSkin" :
					{
						drawDown();
						break;






					};
				case "selectedDisabledSkin" :
				case "SelectedDisabledSkin" :
					{
						drawDisable();
						break;






					};
				default :

			}

			g.endFill();

		}
		private function drawUp():void {
			var colors1:Array=[0xfdea95,0xefbd65];
			var colors2:Array=[0xaf956f,0x997445];
			var colors3:Array=[0xf9f0bd,0xd5ba78];
			drawButton(colors1,colors2,colors3);
		}
		
		private function drawOver():void {
			var colors1:Array=[0xfdea95,0xefbd65];
			var colors2:Array=[0xaf977c,0xa2845b];
			var colors3:Array=[0xfbf5d7,0xe5d6a9];
			drawButton(colors1,colors2,colors3);
		}
		
		private function drawDown():void {
			var colors1:Array=[0xffca6c,0xfae792];
			var colors2:Array=[0x977141,0xae946e];
			var colors3:Array=[0xcfb16c,0xf8eebb];
			drawButton(colors1,colors2,colors3);
		}
		
		private function drawDisable():void {
			var colors1:Array=[0xfdea95,0xefbd65];
			var colors2:Array=[0xaf956f,0x997445];
			var colors3:Array=[0xf9f0bd,0xd5ba78];
			drawButton(colors1,colors2,colors3);
		}
		
		private function drawButton(colors1:Array,colors2:Array,colors3:Array):void{
			g.beginFill(0x420000,0.6);
			if(cornerRadius>3){
				g.drawRoundRectComplex(0,0,unscaledWidth,unscaledHeight,cornerRadius,cornerRadius,cornerRadius,cornerRadius);


				g.beginGradientFill(fillType,colors1,alphas,ratios,matr,spreadMethod);
				g.drawRoundRectComplex(1,1,unscaledWidth-2,unscaledHeight-2,cornerRadius-1,cornerRadius-1,cornerRadius-1,cornerRadius-1);
	
				g.beginGradientFill(fillType,colors2,alphas,ratios,matr,spreadMethod);
				g.drawRoundRectComplex(2,2,unscaledWidth-4,unscaledHeight-4,cornerRadius-2,cornerRadius-2,cornerRadius-2,cornerRadius-2);
	
				g.beginGradientFill(fillType,colors3,alphas,ratios,matr,spreadMethod);
				g.drawRoundRectComplex(3,3,unscaledWidth-6,unscaledHeight-6,cornerRadius-3,cornerRadius-3,cornerRadius-3,cornerRadius-3);
			}else{
				g.drawRoundRectComplex(0,0,unscaledWidth,unscaledHeight,0,0,0,0);


				g.beginGradientFill(fillType,colors1,alphas,ratios,matr,spreadMethod);
				g.drawRoundRectComplex(1,1,unscaledWidth-2,unscaledHeight-2,0,0,0,0);
	
				g.beginGradientFill(fillType,colors2,alphas,ratios,matr,spreadMethod);
				g.drawRoundRectComplex(2,2,unscaledWidth-4,unscaledHeight-4,0,0,0,0);
	
				g.beginGradientFill(fillType,colors3,alphas,ratios,matr,spreadMethod);
				g.drawRoundRectComplex(3,3,unscaledWidth-6,unscaledHeight-6,0,0,0,0);
			}
		
		}
	}
}