package roma.war.render.motion
{
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.utils.Dictionary;
	
	import mx.collections.ArrayCollection;
	
	import roma.war.constants.ReportConstants;
	import roma.war.data.BattleHelper;
	import roma.war.data.bean.BattleTroopType;
	import roma.war.resource.MultiLang;
	import roma.war.ui.DisplayConfig;
	
	public class Hero
	{
		public var name:String = "";
		
		public var totalHp:Number = 0;
		public var hp:Number = 0;
		
		public var key:Number;
		public var action:Action;
		public var location:int;
		public var group:int = 0;
		
		//point
		public var p:Point = new Point(0,0);
		public var sp:Point = new Point(0,0);
		public var tp:Point = new Point(0,0);
		//army
		public var armys:Dictionary;
		
		public var heroStatus:String = "";
		public var heroLogo:BitmapData;
		public var logoStr:String = "";
		
		// 英雄所处位置点
		public var posPoint:Point = new Point(0,0);
		public var heroLogoPoint:Point = new Point(0,0);
		
		public function Hero(h:BattleTroopType)
		{
			this.name = h.heroName;
			
			armys = new Dictionary();
			totalHp = hp = h.totalHP;
			key = h.key;
			group = h.group;
			logoStr = h.heroUrl;
			setArmy(h.troops);
		}
		
		private function setArmy(t:ArrayCollection):void{
			for(var i:int =0;i<t.length;i++){
				var o:Object = t[i];
				var a:Army = new Army(o);
				if(a.troopId == -1)continue;
				a.pos = i;
				a.group = group;
				a.posPoint = DisplayConfig["BATTLEFIELD_AMRY_POINT_"+a.group][a.pos];
				a.heroKey = key;
				armys[i] = a;
				a.lineupArr = BattleHelper.getLineUp(a.troopId,a.count,a.group);
				a.updateLineup();
			}
		}
		
		//hp left
		public function lifeLeft(n:Number):void{
			hp-=n;
		}
		
		public function getArmyByPos(pos:int):Army{
			return this.armys[pos] as Army;
		}
		
		/**
		 * 设置英雄状态（死亡，战斗，等待）
		 */ 
		public function getBeanStatusStr(statusStr:String):String{
			switch(statusStr){
				case ReportConstants.HERO_QUIT:
				return MultiLang.msg('troop.heroes.quit');
				case ReportConstants.HERO_RETREAT:
				return MultiLang.msg('troop.heroes.quit');
				case ReportConstants.HERO_ENTER:
				return MultiLang.msg('troop.heros.inBattle');
				case ReportConstants.HERO_INBATTLE:
				return MultiLang.msg('troop.heros.inBattle');
				case ReportConstants.HERO_WAIT:
				return MultiLang.msg('troop.heroes.wait');
				default:
				return MultiLang.msg('troop.heroes.wait');
			}
		}
		
	}
}