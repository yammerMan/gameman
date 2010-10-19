package roma.war.render.motion
{
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.text.TextFormat;
	
	import roma.war.data.BattleHelper;
	import roma.war.ui.DisplayConfig;
	
	public class Army
	{
		// 队形
		public var lineupArr:Array = [];
		// 剩下的队形，即更新后的队列
		public var curLineArr:Array = [];
		public var corpseLineArr:Array = [];
		// 军队所处相对位置
		public var posPoint:Point = new Point(0,0);
		// 军队所处的绝对位置
		public var absolutePoint:Point = new Point(0,0);
		
		// troop mes
		public var heroKey:int = 0;
		public var troopId:int;
		public var pos:int;
		public var count:int;
		public var group:int;
		
		public var lifeTotal:Number = 0;
		// 损失的生命值
		public var lifeDamage:Number = 0;
		public var singleLife:Number = 0;
		
		//troop action
		public var action:Action;
		
		// 每一回个的总的死伤人数
		public var damageBuffer:Number = 0;
		public var damageCount:Number = 0;
		
		public var leftCountBit:BitmapData;
		public var damageCountPerRoundBit:BitmapData;
		
		public function Army(o:Object)
		{
			troopId = o.typeId;
			count = int(o.count)+int(o.lose);
			singleLife = o.life;
			lifeTotal = count*singleLife;
			
			var temp:countTemp = DisplayConfig.LEFT_COUNT;
			temp.num_txt.text = count.toString();
			
			var tf:TextFormat = new TextFormat();
			tf.color = BattleHelper.getCountColor(count);
			temp.num_txt.setTextFormat(tf);

			leftCountBit = new BitmapData(128,25,true,0);
			leftCountBit.draw(temp);
			damageCountPerRoundBit = new BitmapData(128,25,true,0);
			
			damageBuffer = 0; 
			damageCount = 0;
			corpseLineArr = [];
		}
		
		public function setDamage(n:Number):void{
			lifeDamage += n;
			
//			damageCount = Math.floor(lifeDamage/singleLife);
			damageBuffer += int(n/singleLife);
		}
		
		public function get hasDamage():Boolean{
			return damageBuffer>0;
		}
		
		/**
		 * 军队的更新
		 */ 
		private var c:int = 0;
		public function updateLineup():void{
			damageCount = Math.ceil(lifeDamage/singleLife);     // 负数应该去上限
			c = count + damageCount;
			curLineArr = BattleHelper.getLineUp(troopId,c,group);
			corpseLineArr = getDeadLine();
		}
		
		private var p1:Point;
		private var p2:Point;
		private var arr:Array;
		private function getDeadLine():Array{
			arr = [];
			for each(p1 in lineupArr){
				if(hasPoint(p1) == false){
					arr.push(p1);
				}
			}
			return arr;
		}
		
		private function hasPoint(p:Point):Boolean{
			for each(p2 in curLineArr){
				if(p2.x == p.x && p2.y == p.y)
				return true;
			}return false;
		}
		
	}
}