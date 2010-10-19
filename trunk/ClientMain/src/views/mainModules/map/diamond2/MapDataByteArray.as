package views.mainModules.map.diamond2
{
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	
	import mx.logging.ILogger;
	import mx.logging.Log;
	
	import roma.common.constants.FieldConstant;
	import roma.common.valueObject.FieldBattleInfoBean;
	import roma.common.valueObject.SimpleMapCastleBean;
	import roma.logic.CaesaryConfig;
	import roma.logic.GameContext;
	
	import views.mainModules.map.smallMap.NpcFieldConstant;

	[Embed(source="mapData.txt", mimeType="application/octet-stream")] 
	public class MapDataByteArray extends ByteArray
	{
		
		private var log:ILogger = Log.getLogger("views.mainModules.map.diamond2.MapDataByteArray");
		
		private static var _instance:MapDataByteArray;

		public static function get instance():MapDataByteArray{
			if (_instance ==null) {
				_instance = new MapDataByteArray();
				if(CaesaryConfig.instance.havePersonNpc){
					_instance.initPersonNpc();
				}
			}
			return _instance;
		}
		
		private var castleByteArray:ByteArray;

		private var mapArray:Array = new Array(FieldConstant.MAP_SIZE);
		
		private var _trainNpcMap:Dictionary = new Dictionary(); 
		
		private var _ratterNpcMap:Dictionary = new Dictionary(); 
		
		private var _personNpcMap:Dictionary=new Dictionary();
		
		private function initPersonNpc():void{
			if(CaesaryConfig.instance.personNpcCastleArr.length>0){
				for each(var str:String in CaesaryConfig.instance.personNpcCastleArr){
					var cityId:int=GameContext.getFieldId(str.split(",")[0],str.split(",")[1]);
					_personNpcMap[cityId]=cityId;
				}
			}
		}
		
		
		public function set trainNpcMap(map:Dictionary):void{
			_trainNpcMap = map;
		}
		
		public function get trainNpcMap():Dictionary{
			return _trainNpcMap;
		}
		
		public function get ratterNpcMap():Dictionary{
			return ratterNpcMap;
		}
		
		public function set ratterNpcMap(map:Dictionary):void{
			_ratterNpcMap = map;
		}
		
		public function set personNpcMap(map:Dictionary):void{
			_personNpcMap = map;
		}
		
		public function get personNpcMap():Dictionary{
			return _personNpcMap;
		}
		
		
		public function MapDataByteArray(){
			super();
			for (var x:int=0; x< FieldConstant.MAP_SIZE; x++) {
				this.mapArray[x] = new Array(FieldConstant.MAP_SIZE);
			}
		}
		
		public function getTileObj(fx:int, fy:int):DiamondMapTile2 {
			var x:int = DiamondMapTile2.tranTileXY2FieldXY(fx);
			var y:int = DiamondMapTile2.tranTileXY2FieldXY(fy);
						
			var fieldid:int = GameContext.getFieldId(x,y);
			var trainNpcFieldId:* = _trainNpcMap[fieldid];
			var ratterNpcFieldId:*=_ratterNpcMap[fieldid];
			var en:* = this.mapArray[x][y];

			//如果是训练场npc城
			if(trainNpcFieldId!=null){
				if(en ==null||en ==true){
					this.mapArray[x][y] =new DiamondMapTile2(x,y , FieldConstant.TYPE_NPC_FIELD);
					return this.mapArray[x][y];
				}else{
					return en;	
				}
			}
			
			//如果是叛军城
			if(ratterNpcFieldId!=null){
				if(en ==null||en ==true){
					this.mapArray[x][y] =new DiamondMapTile2(x,y , NpcFieldConstant.TYPE_RATTER_NPC_FIELD);
					return this.mapArray[x][y];
				}else{
					return en;	
				}
			}
			
			if (en !=null) {
				//如果已经初始化过
				if (en is DiamondMapTile2) {
					//如果是地图对象，直接返回
					return en;
				} else {
					//如果不是地图对象，返回空
					return null;
				}
			} else {
				//如果没有初始化过，就初始化
				var type:int = this.getFieldType(x,y);
				
				if (type == FieldConstant.FLAT_TYPE) {
					//如果原始类型是平地，需要判断是否已经变为城堡
					if (this.isCastle(x, y)) {
						//如果已经变为城堡，返回新的地图城堡对象
						this.mapArray[x][y] = new DiamondMapTile2(x,y,FieldConstant.TYPE_CITY);
						return this.mapArray[x][y];
					} else {
						//如果不是城堡，设置一下已经初始化,然后返回空
						this.mapArray[x][y] = true;
						return null;
					}
				} else {
					//如果不是平地，返回新的地图对象
					this.mapArray[x][y] = new DiamondMapTile2(x,y,type);
					return this.mapArray[x][y];
				}
			}
		}
		
		public function isCastle(fx:int ,fy:int):Boolean {
			var index:Number = fy * FieldConstant.MAP_SIZE + fx;
			var pos:int = index /8;
			var off:int = 7 - index % 8;
			this.castleByteArray.position = pos;
			var v:uint = this.castleByteArray.readUnsignedByte();
			var bit:uint = (v>>off) & 1;
			var res:Boolean = (bit==1);
			return bit == 1; 
		}
		
		public function isTrainNpcCastle(fx:int ,fy:int):Boolean{
			var fieldid:int = GameContext.getFieldId(fx,fy);
			var trainNpcFieldId:* = _trainNpcMap[fieldid];
			if(trainNpcFieldId !=null)
				return true;
				
			return false;	
		}
		
		public function isRatterNpcCastle(fx:int ,fy:int):Boolean{
			var fieldid:int = GameContext.getFieldId(fx,fy);
			var ratterNpcFieldId:*=_ratterNpcMap[fieldid];
			if(ratterNpcFieldId!=null)
				return true;
				
			return false;	
		}
		
		public function isPersonNpcCastle(fx:int ,fy:int):Boolean{
			var fieldid:int = GameContext.getFieldId(fx,fy);
			var personNpcFieldId:*=_personNpcMap[fieldid];
			if(personNpcFieldId!=null)
				return true;
				
			return false;	
		}
		
		/**
		 * 根据登录数据更新缓存
		 */
		public function setCastleByteArray(byteArray:ByteArray):void {
			this.castleByteArray = byteArray;
			this.castleByteArray.uncompress();
		}

		public function addCastle(bean:SimpleMapCastleBean):void {
			var fx:int = bean.fieldId / 10000;
			var fy:int = bean.fieldId % 10000;
			var tile:DiamondMapTile2 = this.getTileObj(fx,fy);
			if (tile == null || tile.getFieldType() != FieldConstant.TYPE_CITY) {
				if(tile !=null){
					this.cleanCastle(bean.fieldId);
				}
				tile = new DiamondMapTile2(fx,fy , FieldConstant.TYPE_CITY);
				this.mapArray[fx][fy] = tile;
			}
			
			tile.setMapCityBean(bean);
		}
		
		public function addInBattle(b:FieldBattleInfoBean):void{
			var fx:int = b.fieldId/10000;
			var fy:int= b.fieldId%10000;
			var tile:DiamondMapTile2 = this.getTileObj(fx,fy);
			if(tile !=null){
				tile.battleBean = b;
				tile.isInBattle = true;
			}
		}

		private function getFieldType(tx:int, ty:int):int {
			var p:int = tx * FieldConstant.MAP_SIZE + ty;
			this.position = p/2; 
			var v:int = this.readUnsignedByte();
			if (p %2==0) {
				return v>>4;
			} else {
				return v & 0xf;
			}
		}
		
		public function cleanCastle(idField:int):void {
			var fx:int = idField / 10000;
			var fy:int = idField % 10000;
			this.mapArray[fx][fy] = true;
		}
		
		public function cleanNpcCastle(idField:int):void{
			var fx:int = idField / 10000;
			var fy:int = idField % 10000;
			this.mapArray[fx][fy] = null;
		}
		
	}
}
