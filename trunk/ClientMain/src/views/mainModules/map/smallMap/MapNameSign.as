package views.mainModules.map.smallMap
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Matrix;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	import roma.common.constants.FieldConstant;
	
	import views.mainModules.map.diamond2.TileHelper;

	public class MapNameSign
	{
		private var textSignBit:Bitmap;
		private var mx:Matrix = new Matrix();
		private var signTextFiled:TextField = new TextField();
		
		private var signCoorArr:Array = new Array(
									{x:115,y:50},{x:280,y:140},{x:425,y:95},
									{x:160,y:185},{x:80,y:330},{x:285,y:290},
									{x:460,y:260},{x:95,y:450},{x:340,y:475},{x:445,y:385});
		
		public function MapNameSign()
		{
			super();
			this.textSignBit = new Bitmap();
			signTextFiled = new TextField();
		}
		
		public function setSign():void{
			var bit:BitmapData = new BitmapData(FieldConstant.MAP_SIZE+50,FieldConstant.MAP_SIZE+50,true,0x0);
			mx = new Matrix();
			var i:int =0;
			var arr:Array = TileHelper.instance.zoneName;
			for(i=0;i<arr.length;i++){
				mx.tx = signCoorArr[i].x;
				mx.ty = signCoorArr[i].y;
				signTextFiled.text = arr[i];
				setTextFormat();
				bit.draw(signTextFiled,mx);
			} 
			
			var old:BitmapData = textSignBit.bitmapData;
			textSignBit.bitmapData = bit;
			if(old != null){
				old.dispose();
			} 
		}
		
		public function getTextBit():Bitmap{
			return textSignBit;
		}
		
		private function setTextFormat():void{
			this.signTextFiled.width = 90;
			this.signTextFiled.wordWrap = true;
			
			var f:TextFormat = new TextFormat();
            f.font = "Tohoma";
            f.color = 0x000000;
            f.size = 16;
			f.bold = true;
			signTextFiled.setTextFormat(f);
		}
		
	}
}