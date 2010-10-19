package views.mainModules.map.diamond2
{
	import flash.display.DisplayObject;
	
	import mx.controls.Image;
	
	import roma.common.constants.FieldConstant;
	import roma.util.MultiLang;
	
	public class TileHelper
	{
		private var mapUIContainer:DisplayObject 
		
		/** 鼠标在场景里面 */
		public var mouseInContext:Boolean;
		
		public var tileX:int;
		public var tileY:int;
		public var fieldX:int;
		public var fieldY:int;
		public var idField:int;
		
		public var mapLocalX:int;
		public var mapLocalY:int;

		public var debugStr:String;
		
		//区域的名称
		public var zoneName:Array=new Array;
		public var zoneBgArray:Array = [];
		
		public static var instance:TileHelper=new TileHelper();
		
		public function TileHelper() {
			instance=this;

			zoneName.push(MultiLang.msg("state.Britons"));
			zoneName.push(MultiLang.msg("state.Reich"));   
			zoneName.push(MultiLang.msg("state.Asiana"));
			zoneName.push(MultiLang.msg("state.Gauls"));  
			zoneName.push(MultiLang.msg("state.Hispania"));  
			zoneName.push(MultiLang.msg("state.Italia"));    
			zoneName.push(MultiLang.msg("state.Macedon"));   
			zoneName.push(MultiLang.msg("state.Carthage")); 
			zoneName.push(MultiLang.msg("state.Egypt"));    
			zoneName.push(MultiLang.msg("state.Parthia"));  
			
			zoneBgArray = ["map.state.Britons.icon","map.state.Reich.icon","map.state.Asiana.icon","map.state.Gauls.icon",
						"map.state.Hispania.icon","map.state.Italia.icon","map.state.Macedon.icon","map.state.Carthage.icon",
						"map.state.Egypt.icon","map.state.Parthia.icon"];
		}
		private function init(mapUIContainer:DisplayObject, contentMouseX:int, contentMouseY:int):void {
			var halfHeight:int = DiamondWorldMap2.TILE_HEIGHT>>1;
			var halfWidth:int = DiamondWorldMap2.TILE_WIDTH>>1;
			
			var mapX:int;
			var mapY:int;
			
			if (contentMouseX>=0 && contentMouseX<=DiamondWorldMap2.SCENE_WIDTH && contentMouseY>=0 && contentMouseY<= DiamondWorldMap2.SCENE_HEIGHT) {
				this.mouseInContext = true;
				
				var totalX:int = (contentMouseX -mapUIContainer.x);
				var totalY:int = (contentMouseY -mapUIContainer.y);

				var cx:int = totalX / DiamondWorldMap2.TILE_WIDTH;
				var cy:int = totalY / DiamondWorldMap2.TILE_HEIGHT;				

				if (totalX<0 && totalX%DiamondWorldMap2.TILE_WIDTH!=0) {
					cx --;
				}
				if (totalY<0 && totalY%DiamondWorldMap2.TILE_HEIGHT!=0) {
					cy --;
				}

				var tx:int = totalX % DiamondWorldMap2.TILE_WIDTH;
				if (tx<0) {
					tx +=DiamondWorldMap2.TILE_WIDTH;
				}
				var ty:int = totalY % DiamondWorldMap2.TILE_HEIGHT;
				if (ty<0) {
					ty += DiamondWorldMap2.TILE_HEIGHT;
				}
				
				mapX = cx + cy;
				mapY = cy - cx;

				
				if (tx< halfWidth) {
					//左边
					if (tx + ty *2  < halfWidth) {
						//左上
						mapX --;
					} else if (tx  + (DiamondWorldMap2.TILE_HEIGHT - ty)*2 < halfWidth ){
						//左下
						mapY ++;
					}
				} else {
					//右边
					if (DiamondWorldMap2.TILE_WIDTH - tx + ty*2 < halfWidth) {
						mapY --;
					} else if (DiamondWorldMap2.TILE_WIDTH - tx+ (DiamondWorldMap2.TILE_HEIGHT - ty)*2 < halfWidth ){
						mapX ++ ;
					}
				}
				
				this.calcMapXY(mapX , mapY);
				this.updateDrawXY(mapUIContainer);
				
				//this.debugStr = StringUtil.substitute("C:{0},{1}\nT:{2},{3}\n{4},{5}\n{6},{7}" , cx, cy , tx,ty , tileX , tileY, totalX, totalY); 
				//this.debugStr = StringUtil.substitute("Field:{0},{1}\nTile:{2},{3}" , this.fieldX, this.fieldY , this.tileX , this.tileY); 
			} else {
				this.mouseInContext = false;
			}
		}
		
		public function calcMapXY(mapX:int, mapY:int):void {
			this.tileX = mapX;
			this.tileY = mapY;
			
			this.fieldX = this.tileX % FieldConstant.MAP_SIZE;
			this.fieldY = this.tileY % FieldConstant.MAP_SIZE;
			if (this.fieldX <0 ) {
				this.fieldX += FieldConstant.MAP_SIZE;
			}
			if (this.fieldY <0 ) {
				this.fieldY += FieldConstant.MAP_SIZE;
			}
			this.idField = this.fieldX * 10000 + this.fieldY;
		}
		
		public function updateDrawXY(mapUIContainer:DisplayObject):void {
			this.mapLocalX = DiamondWorldMap2.TILE_WIDTH  / 2 * (this.tileX - this.tileY) + mapUIContainer.x;
			this.mapLocalY = DiamondWorldMap2.TILE_HEIGHT / 2 * (this.tileX + this.tileY) + mapUIContainer.y;
		}
		
		public static function calc(mapUIContainer:DisplayObject, contentMouseX:int, contentMouseY:int):TileHelper {
			var res:TileHelper = new TileHelper();
			res.init(mapUIContainer , contentMouseX , contentMouseY);
			return res;
		}
		
		public static function calcFieldID(tx:int, ty:int):int {
			return tranTileXY2FieldXY(tx) * 10000 + tranTileXY2FieldXY(ty);
		}
		
		public static function tranTileXY2FieldXY(value:int):int {
			var x1:int = value % FieldConstant.MAP_SIZE;
			if (x1<0) {
				x1 += FieldConstant.MAP_SIZE;
			}
			return x1;
		}
		
		public static function getZoneName(zone:int):String {
			var str:String="";
			if(instance.zoneName[zone]!=null){
				str=instance.zoneName[zone]
			}else{
				str=String(zone);
			}
			return str;
		}
		
		public static function getZoneMask(zone:int):String{
			return instance.zoneBgArray[zone] as String;
		}
		
	}
}