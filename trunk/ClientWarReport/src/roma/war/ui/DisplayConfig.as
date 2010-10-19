package roma.war.ui
{
	import flash.geom.Point;
	import flash.text.TextFormat;
	
	import net.riahelp.game.utility.display.Size;
	
	/**
	 * 定义所有的位置
	 */ 
	public class DisplayConfig
	{
		//放技能名字文字模板
		public static const SKILL_NAME_TEXT:atkNameTemp = new atkNameTemp();
		//受技能名字文字模板
		public static const BY_SKILL_NAME_TEXT:byATKNameTemp = new byATKNameTemp();
		//掉血数量文字模板
		public static const DAMAGE_TEXT:damageTemp = new damageTemp();
		//每一回合死伤人数文字模板
		public static const DEAD_TEXT:deadNumberTemp = new deadNumberTemp();
		public static const LEFT_COUNT:countTemp = new countTemp();
		public static const DAMAGE_COUNT_PERROUND:countDamageMC = new countDamageMC(); 
	
		//其他文字模板
		public static const OTHERS_TEXT:otherNameTemp = new otherNameTemp();
		
		//城墙血条模板
		public static const WALL_HP:BarHP = new wallhp_mc();
		
		public function DisplayConfig(){
			var tf:TextFormat = new TextFormat();
			tf.font = "Tahoma";
			SKILL_NAME_TEXT.name_txt.setTextFormat(tf);
			BY_SKILL_NAME_TEXT.name_txt.setTextFormat(tf);
			DAMAGE_TEXT.num_txt.setTextFormat(tf);
			OTHERS_TEXT.name_txt.setTextFormat(tf);
			DEAD_TEXT.num_txt.setTextFormat(tf);
			LEFT_COUNT.num_txt.setTextFormat(tf);
			DAMAGE_COUNT_PERROUND.num_txt.setTextFormat(tf);
		}
		
		
		//军队数量放大参考表
		public static const TROOP_SCALE_NUM:Array = [1,1.25,1.5,1.75,2];
		
		//战地四周分别扩大30；
		public static const FIELD_SIDE:int = 40;
		//战场双方阵地的基点（第一个位置的点）(92,171),(384,25)
		public static const BATTLEFIELD_POINT:Array = [
														new Point(112,171),
														new Point(380,23)
														];
		//每英雄军队区域
		public static const BATTLEFIELD_HERO_SPACE:Size = new Size(300,150);
		//英雄logo的位置 位于英雄军队区域相对坐标
		public static const BATTLEFIELD_HERO_LOGO_OFFSET_0:Point = new Point(0,110);
		public static const BATTLEFIELD_HERO_LOGO_OFFSET_1:Point = new Point(220,-10);
		//每英雄六个部队顶点坐标 位于英雄军队区域的相对坐标
		//每部队血条的位置 相对于每个兵种
		public static const BATTLEFIELD_AMRY_LIFE_OFFSET_0:Point = new Point(10,-50);
		public static const BATTLEFIELD_AMRY_LIFE_OFFSET_1:Point = new Point(10,-80);
		
		/**
		 * 阵地中六小块位置的相对坐标
		 * 基点坐标{（0，39）（78，0）横坐标相距（50，25）}
		 */ 
/*  	public static const BATTLEFIELD_AMRY_POINT_0:Array = [
													new Point(78,0),
													new Point(128,25),
													new Point(178,50),
													new Point(0,39),
													new Point(50,64),
													new Point(100,89)
															]; 
		public static const BATTLEFIELD_AMRY_POINT_1:Array = [
													new Point(0,39),
													new Point(50,64),
													new Point(100,89),
													new Point(78,0),
													new Point(128,25),
													new Point(178,50)
															];  */
 		public static const BATTLEFIELD_AMRY_POINT_0:Array = [
													new Point(78,0),
													new Point(134,28),
													new Point(190,56),
													new Point(-20,49),
													new Point(36,77),
													new Point(90,108)
															]; 
		public static const BATTLEFIELD_AMRY_POINT_1:Array = [
													new Point(0,39),
													new Point(56,67),
													new Point(92,83),
													new Point(118,-20),
													new Point(174,2),
													new Point(230,36)
															]; 
		//各兵种数量队形
		public static const HEROES_TROOPS_POINT_INFANTRY_0:Array = [
													[new Point(25,-35)],
													[new Point(9,-40),new Point(25,-35),new Point(40,-30)],
													[new Point(9,-40),new Point(25,-35),new Point(40,-30),
													new Point(-5,-33),new Point(10,-27),new Point(25,-20)],
													[new Point(9,-40),new Point(25,-35),new Point(40,-30),
													new Point(-5,-33),new Point(10,-27),new Point(25,-20),
													new Point(-20,-25),new Point(-5,-19),new Point(10,-12)],
													[new Point(9,-40),new Point(25,-35),new Point(40,-30),
													new Point(-5,-33),new Point(10,-27),new Point(25,-20),
													new Point(-20,-25),new Point(-5,-19),new Point(10,-12),
													new Point(-35,-17),new Point(-20,-11),new Point(-5,-5)]
													];
		//骑兵队形
		public static const HEROES_TROOPS_POINT_CAVALRY_0:Array = [
													[new Point(10,-27)],
													[new Point(-5,-33),new Point(10,-27)],
													[new Point(-5,-33),new Point(10,-27),new Point(25,-20)],
													[new Point(-5,-33),new Point(10,-27),new Point(25,-20),
													new Point(-5,-33)],
													[new Point(-5,-33),new Point(10,-27),new Point(25,-20),
													new Point(-35,-17),new Point(-20,-11),new Point(-5,-5)]
																];
		//机械部队队形	
		public static const HEROES_TROOPS_POINT_MECHS_0:Array = [
													[new Point(25,-20)],
													[new Point(-5,-33),new Point(25,-20)],
													[new Point(-5,-33),new Point(25,-20),
													new Point(-5,-33)],
													[new Point(-5,-33),new Point(25,-20),
													new Point(-35,-17),new Point(-5,-5)],
													[new Point(-5,-33),new Point(25,-20),
													new Point(-35,-17),new Point(-5,-5)]
																];
		//blue 阵营的队形
		public static const HEROES_TROOPS_POINT_INFANTRY_1:Array = [
																[new Point(-20,-11)],
																[new Point(-35,-17),new Point(-20,-11),new Point(-5,-5)],
																[new Point(-20,-25),new Point(-5,-19),new Point(10,-12),
																new Point(-35,-17),new Point(-20,-11),new Point(-5,-5)],
																[new Point(-5,-33),new Point(10,-27),new Point(25,-20),
																new Point(-20,-25),new Point(-5,-19),new Point(10,-12),
																new Point(-35,-17),new Point(-20,-11),new Point(-5,-5)],
																[new Point(9,-40),new Point(25,-35),new Point(40,-30),
																new Point(-20,-25),new Point(-5,-19),new Point(10,-12),
																new Point(-5,-33),new Point(10,-27),new Point(25,-20),
																new Point(-35,-17),new Point(-20,-11),new Point(-5,-5)]
																];
		//骑兵队形
		public static const HEROES_TROOPS_POINT_CAVALRY_1:Array = [
																[new Point(-20,-11)],
																[new Point(-20,-11),new Point(-5,-5)],
																[new Point(-35,-17),new Point(-20,-11),new Point(-5,-5)],
																[new Point(10,-27),
																new Point(-35,-17),new Point(-20,-11),new Point(-5,-5)
																],
																[new Point(-5,-33),new Point(10,-27),new Point(25,-20)
																,new Point(-35,-17),new Point(-20,-11),new Point(-5,-5)]
																];
		//机械部队队形	
		public static const HEROES_TROOPS_POINT_MECHS_1:Array = [
																[new Point(-5,-5)],
																[new Point(-35,-17),new Point(-5,-5)],
																[new Point(25,-20),
																new Point(-35,-17),new Point(-5,-5)
																],
																[new Point(-5,-33),new Point(25,-20),
																new Point(-35,-17),new Point(-5,-5)
																],
																[new Point(-5,-33),new Point(25,-20),
																new Point(-35,-17),new Point(-5,-5)]
																];
		
		//城墙血条显示的位置
		public static const WALL_HP_POINT:Point = new Point(460,200);
		
		//城墙的攻击点，当远程攻击城墙时随机取一点，做为攻击地址。
		public static const WALL_HIT_POINT:Array = [
													new Point(500,260)
													];
		//箭塔的显示位置，箭塔攻击和被攻击时将以这些坐标为动作依据
		public static const ARROW_TOWER_POINTS:Array = [
													new Point(320,130),
													new Point(470,160),
													new Point(540,190),
													new Point(690,210)
													];
		//雷石出现的位置 
		public static const FALLROCK_POINTS:Array = [
													new Point(225,80),
													new Point(275,110),
													new Point(325,140),
													
													new Point(375,170),
													new Point(425,200),
													new Point(475,230),
													
													new Point(525,260),
													new Point(575,290),
													new Point(625,320),
													];
											
		/**
		 * 阵地坐标列表
		 */ 		
		public static function getFieldArray(group:int):Array{
			var arr:Array = [];
			arr.push(BATTLEFIELD_POINT[group]);
			for(var i:int=0;i<2;i++){
				var p:Point = new Point(arr[arr.length-1].x+300/2,arr[arr.length-1].y+150/2);
				arr.push(p);
			}
			return arr;
		}
		
	}
}