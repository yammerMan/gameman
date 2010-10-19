package roma.util
{
	import flash.display.BitmapData;
	
	import mx.collections.ArrayCollection;
	import mx.core.BitmapAsset;
	import mx.core.UIComponent;
	
	import roma.logic.GameContext;
	import roma.common.constants.BuffConstants;
	import roma.logic.object.buff.BaseBuffObj;
	import roma.logic.object.castle.CastleObj;
	
	public class BufferHandle
	{
		public static var instance:BufferHandle = new BufferHandle();
		private var buff_arr:Array = [
			BuffConstants.PLAYER_INC_FOOD_PRODUCE,
			BuffConstants.PLAYER_INC_GOLD_PRODUCE,
			BuffConstants.PLAYER_INC_FOOD_PRODUCE,
			BuffConstants.PLAYER_INC_IRON_PRODUCE,
			BuffConstants.PLAYER_INC_STONE_PRODUCE,
			BuffConstants.PLAYER_INC_WOOD_PRODUCE,
			BuffConstants.PLAYER_KEEP_SILENCE,
			BuffConstants.PLAYER_BEGINNER,
			BuffConstants.PLAYER_INC_ARMY_ATTACK,
			BuffConstants.PLAYER_INC_ARMY_DEFENCE,
			BuffConstants.PLAYER_PEACE,
			BuffConstants.PLAYER_PEACE_COOLDOWN,
			BuffConstants.PLAYER_TROOP_RELIVE,
			BuffConstants.CASTLE_COMFORTING_COOL_DOWN,
			BuffConstants.CASTLE_LEVY_COOL_DOWN,
			BuffConstants.CASTLE_ADV_MOVE,
			BuffConstants.CASTLE_MOVE_COOLDOWN,
			BuffConstants.TAX_MODIFY_COOL_DOWN
			
		]
		
		public function BufferHandle()
		{
		}
		
		//判断当前城市有没这样的buffer
		public static function getBuffById(typeId:int):BaseBuffObj {
			var castle:CastleObj = GameContext.instance.getPlayerObj().getCurCastleObj();
			trace("BufferHandle: curCastle=" + castle.cityId);
			var res:BaseBuffObj = castle.buffManager.getBuffById(typeId);
			return res;
		}
		
			//判断当前城市有没这样的buffer,如果有buffer的剩余时间是否大于0
		public static function getVirtuousBuffById(typeId:int):Boolean {
			var haveVirtuousBuff:Boolean=false;
			var castle:CastleObj = GameContext.instance.getPlayerObj().getCurCastleObj();
			var res:BaseBuffObj = castle.buffManager.getBuffById(typeId);
			if(res!=null){
				var now:Number = new Date().valueOf();
				var diff:Number = GameContext.instance.getTimeDis();
				var remain:Number = (res.buffBean.endTime + diff - now)/1000 ;
				haveVirtuousBuff=remain>0?true:false;
			}
			return haveVirtuousBuff;
		}
		
		public static function sortBuff(arr:ArrayCollection):void{
			if(arr.length<=1){
				return;
			}
			for(var i:int=0;i<arr.length;i++){
				for(var j:int=0;j<arr.length-1-i;j++){
					if(instance.getSortId(arr.getItemAt(j).buffBean.typeId)>instance.getSortId(arr.getItemAt(j+1).buffBean.typeId)){
						var tempBufferBean:BaseBuffObj = BaseBuffObj(arr.getItemAt(j));
						arr.setItemAt(arr.getItemAt(j+1),j);
						arr.setItemAt(tempBufferBean,j+1);
					}
					else{
						continue;
					}
				}
			}
		}
		
		/**
		@param progressBg 进度条背景
		@param progressBar 进度条
		@param barWidth 进度条长
		@param barHeight 进度条宽
		@param finishTime 完成时间
		@param timeNeed 总时间长度
		*/
		public function drawTimerBar(progressBg:UIComponent,progressBar:UIComponent,barWidth:Number,barHeight:Number,finishTime:Number,timeNeed:Number):void{
			if(finishTime - new Date().valueOf()+GameContext.instance.getTimeDis()>=0){
				progressBg.graphics.clear();
				progressBg.graphics.beginFill(0x0);
				progressBg.graphics.drawRect(0,0,progressBg.width,progressBg.height);
				progressBar.graphics.clear();
				progressBar.graphics.beginFill(0x00ff00);
				progressBar.graphics.drawRect(0,0,progressBar.width*(timeNeed-(finishTime - new Date().valueOf()+GameContext.instance.getTimeDis())/1000)/timeNeed,progressBar.height);
			}
			
		}
		
		/**
		@param progressBg 进度条背景
		@param progressBar 进度条
		@param barWidth 进度条长
		@param barHeight 进度条宽
		@param finishTime 完成时间
		@param timeNeed 总时间长度
		*/
		public function drawTimerBarInAssumpsit(imgCls:Class,initWidth:Number,progressBar:UIComponent,barWidth:Number,barHeight:Number,finishTime:Number,timeNeed:Number,alpha:Number=1):void{
			progressBar.graphics.clear();
			var background:BitmapAsset = BitmapAsset(new imgCls());
			var tile:BitmapData = background.bitmapData;   
            progressBar.graphics.beginBitmapFill(tile);
			if(finishTime - new Date().valueOf()+GameContext.instance.getTimeDis()>0){
                if(timeNeed>0){
                	progressBar.graphics.drawRect(0,0,initWidth+(progressBar.width-initWidth)*(timeNeed-(finishTime - new Date().valueOf()+GameContext.instance.getTimeDis())/1000)/timeNeed,barHeight);
                }else{
                	progressBar.graphics.drawRect(0,0,initWidth,barHeight);
                }
				
				progressBar.alpha=alpha;
			}else{
				progressBar.graphics.drawRect(0,0,barWidth,barHeight);
			}
			progressBar.graphics.endFill();
		}
		
		private function getSortId(tId:String):int{
			var t:int = 0;
			for(var i:int = 0;i<buff_arr.length;i++){
				if(tId == buff_arr[i]){
					t = i;
					break;
				}
			}
			return t;
		}
		
		/**
		 * 获取时间单位最大的两位显示
		 * 时间长度（秒） 变成 xx天xx日 xx:xx的格式
		 */
		public static function timeToString(t:Number):String{
			var str:String = "";
			var d:int = t / (24 * 60 * 60);
			var h:int = (t / (60*60) )% 24 ;
			var m:int = (t / 60) % 60;
			var s:int = t % 60;
			
			if (d>0) {
				str += d+"D";
				if (h>0) {
					str += h;
				}
			}else if (h>0){
				str += h+"H";
				if (m>0) {
					str += m;
				}
			}else if (m>0){
				str += m+"M";
				if (s<10) {
					str += "0";
				}
				str +=s;
			}else{
				if (s<10) {
					str += "0";
				}
				str +=s+"S";
			}
			return str;
		}
		
	}
}