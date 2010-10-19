package roma.war.resource
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	
	import roma.war.constants.ReportConstants;
	import roma.war.resource.embedsObj.BlazeEmbedsObj;
	import roma.war.resource.embedsObj.CorpseEmbedsObj;
	import roma.war.resource.embedsObj.KillEmbedsObj;
	import roma.war.resource.embedsObj.TroopsEmbedsObj;
	import roma.war.resource.embedsObj.WeaponEmbedsObj;
	
	public class EmbedResource
	{
		static public const TROOP_COUNT:Number = 20;
		public static var instance:EmbedResource = new EmbedResource();
		
		public function dispose():void
		{
			var n:String;
			for each(n in logos){
				try{
					BitmapData(logos[n]).dispose();
				}catch(e:Error){trace(this,e);}
				
			}
			logos = null;
		
			for each(n in troop){
				try{
					BitmapData(troop[n]).dispose();
				}catch(e:Error){trace(this,e);}
				
			}
			troop = null;
		
			for each(n in city){
				try{
					BitmapData(city[n]).dispose();
				}catch(e:Error){trace(this,e);}
				
			}
			city = null;
		
			for each(n in others){
				try{
					BitmapData(others[n]).dispose();
				}catch(e:Error){trace(this,e);}
				
			}
			others = null;
		
		}
		
		public var logos:Object;
		public var troopIcon:Object = {};
		public var troop:Object;
		public var city:Object;
		public var others:Object;
		public var place:Object;
		public var troopMotion:Object;
		public var weapon:Object;
		public var otherMotion:Object;
		
		public var resultBtnBit:BitmapData;
		public var resultBg:BitmapData;
		
		public function load():void{
			init();
		}
		
		private function init():void{
			//heros
			logos = new Object();
			logos["logo.hero.1"] = Bitmap(new LOGO_HERO_1()).bitmapData;
			logos["logo.hero.2"] = Bitmap(new LOGO_HERO_2()).bitmapData;
			logos["logo.hero.3"] = Bitmap(new LOGO_HERO_3()).bitmapData;
			logos["logo.hero.4"] = Bitmap(new LOGO_HERO_4()).bitmapData;
			logos["logo.hero.5"] = Bitmap(new LOGO_HERO_5()).bitmapData;
			logos["logo.hero.6"] = Bitmap(new LOGO_HERO_6()).bitmapData;
			logos["logo.hero.7"] = Bitmap(new LOGO_HERO_7()).bitmapData;
			logos["logo.hero.8"] = Bitmap(new LOGO_HERO_8()).bitmapData;
			logos["logo.hero.9"] = Bitmap(new LOGO_HERO_9()).bitmapData;
			logos["logo.hero.10"] = Bitmap(new LOGO_HERO_10()).bitmapData;
			logos["logo.hero.21"] = Bitmap(new LOGO_HERO_21()).bitmapData;
			logos["logo.hero.22"] = Bitmap(new LOGO_HERO_22()).bitmapData;
			logos["logo.hero.23"] = Bitmap(new LOGO_HERO_23()).bitmapData;
			logos["logo.hero.24"] = Bitmap(new LOGO_HERO_24()).bitmapData;
			logos["logo.hero.25"] = Bitmap(new LOGO_HERO_25()).bitmapData;
			logos["logo.hero.26"] = Bitmap(new LOGO_HERO_26()).bitmapData;
			logos["logo.hero.27"] = Bitmap(new LOGO_HERO_27()).bitmapData;
			logos["logo.hero.28"] = Bitmap(new LOGO_HERO_28()).bitmapData;
			logos["logo.hero.29"] = Bitmap(new LOGO_HERO_29()).bitmapData;
			logos["logo.hero.30"] = Bitmap(new LOGO_HERO_30()).bitmapData;
			logos["tf.castle"] = Bitmap(new LOGO_HERO_29()).bitmapData;
			
			//arms
			troop = new Object();
			troop["2"] = Bitmap(new A_ARCHERS()).bitmapData;
			troop["3"] = Bitmap(new A_BALLISTAS()).bitmapData;
			troop["4"] = Bitmap(new A_CAVALRY()).bitmapData;
			troop["5"] = Bitmap(new A_ONAGERS()).bitmapData;
			troop["7"] = Bitmap(new A_TRIARII()).bitmapData;
			troop["8"] = Bitmap(new A_URBAN_COHORT()).bitmapData;
			
			troopMotion = new Object();
			//弓箭 MotionResource(Motion(motionState()));
			troopMotion["2_1"] = new MotionResource(
								Motion.make(troop["2"],100,100,60,70,[
									new TroopsEmbedsObj("2_1"+ReportConstants.TROOP_STAY,[0,0,0,0,1,1,1,1,2,2,2,2,3,3,3,3]),
									new TroopsEmbedsObj("2_1"+ReportConstants.TROOP_MARCH,[10,11,12,13,14,15,16,17]),
									new TroopsEmbedsObj("2_1"+ReportConstants.TROOP_ATK,[30,31,32,33,34,35,36,37,38,39]),
								]));
			troopMotion["2_0"] = new MotionResource(
								Motion.make(troop["2"],100,100,60,70,[
									new TroopsEmbedsObj("2_0"+ReportConstants.TROOP_STAY,[4,4,4,4,5,5,5,5,6,6,6,6,7,7,7,7]),
									new TroopsEmbedsObj("2_0"+ReportConstants.TROOP_MARCH,[20,21,22,23,24,25,26,27]),
									new TroopsEmbedsObj("2_0"+ReportConstants.TROOP_ATK,[40,41,42,43,44,45,46,47,48,49]),
								]));
			//弩车
			troopMotion["3_1"] = new MotionResource(
								Motion.make(troop["3"],100,100,45,80,[
									new TroopsEmbedsObj("3_1"+ReportConstants.TROOP_STAY,[0,0,0,0,1,1,1,1,2,2,2,2,3,3,3,3]),
									new TroopsEmbedsObj("3_1"+ReportConstants.TROOP_MARCH,[10,11,12,13,14,15,16,17,18,19,19,19]),
									new TroopsEmbedsObj("3_1"+ReportConstants.TROOP_ATK,[30,31,32,33,34,34,34,35,36,37,38,39]),
								]));
			troopMotion["3_0"] = new MotionResource(
								Motion.make(troop["3"],100,100,60,70,[
									new TroopsEmbedsObj("3_0"+ReportConstants.TROOP_STAY,[4,4,4,4,5,5,5,5,6,6,6,6,7,7,7,7]),
									new TroopsEmbedsObj("3_0"+ReportConstants.TROOP_MARCH,[20,21,22,23,24,25,26,27,28,29,29,29]),
									new TroopsEmbedsObj("3_0"+ReportConstants.TROOP_ATK,[40,41,42,43,44,44,44,45,46,47,48,49]),
								]));
			//骑兵
			troopMotion["4_1"] = new MotionResource(
								Motion.make(troop["4"],100,100,40,70,[
									new TroopsEmbedsObj("4_1"+ReportConstants.TROOP_STAY,[0,0,0,0,1,1,1,1,2,2,2,2,3,3,3,3]),
									new TroopsEmbedsObj("4_1"+ReportConstants.TROOP_MARCH,[10,11,12,13,14,15,16,17]),
									new TroopsEmbedsObj("4_1"+ReportConstants.TROOP_ATK,[30,31,32,33,34,35,36,37,38,39]),
								]));
			troopMotion["4_0"] = new MotionResource(
								Motion.make(troop["4"],100,100,60,65,[
									new TroopsEmbedsObj("4_0"+ReportConstants.TROOP_STAY,[4,4,4,4,5,5,5,5,6,6,6,6,7,7,7,7]),
									new TroopsEmbedsObj("4_0"+ReportConstants.TROOP_MARCH,[20,21,22,23,24,25,26,27]),
									new TroopsEmbedsObj("4_0"+ReportConstants.TROOP_ATK,[40,41,42,43,44,45,46,47,48,49]),
								]));
			//投石车
			troopMotion["5_1"] = new MotionResource(
								Motion.make(troop["5"],100,100,28,95,[
									new TroopsEmbedsObj("5_1"+ReportConstants.TROOP_STAY,[0,0,0,0,1,1,1,1,2,2,2,2,3,3,3,3]),
									new TroopsEmbedsObj("5_1"+ReportConstants.TROOP_MARCH,[10,11,12,13,14,15,16,17,18,19,19,19]),
									new TroopsEmbedsObj("5_1"+ReportConstants.TROOP_ATK,[30,31,32,33,34,34,34,35,36,37,38,39]),
								]));
			troopMotion["5_0"] = new MotionResource(
								Motion.make(troop["5"],100,100,28,95,[
									new TroopsEmbedsObj("5_0"+ReportConstants.TROOP_STAY,[4,4,4,4,5,5,5,5,6,6,6,6,7,7,7,7]),
									new TroopsEmbedsObj("5_0"+ReportConstants.TROOP_MARCH,[20,21,22,23,24,25,26,27,28,29,29,29]),
									new TroopsEmbedsObj("5_0"+ReportConstants.TROOP_ATK,[40,41,42,43,44,44,44,45,46,47,48,49]),
								]));
			//枪兵
			troopMotion["7_1"] = new MotionResource(
								Motion.make(troop["7"],100,100,60,67,[
									new TroopsEmbedsObj("7_1"+ReportConstants.TROOP_STAY,[0,0,0,0,1,1,1,1,2,2,2,2,3,3,3,3]),
									new TroopsEmbedsObj("7_1"+ReportConstants.TROOP_MARCH,[10,11,12,13,14,15,16,17]),
									new TroopsEmbedsObj("7_1"+ReportConstants.TROOP_ATK,[30,31,32,33,34,35,36,37,38,39,39,39]),
								]));
			troopMotion["7_0"] = new MotionResource(
								Motion.make(troop["7"],100,100,60,67,[
									new TroopsEmbedsObj("7_0"+ReportConstants.TROOP_STAY,[4,4,4,4,5,5,5,5,6,6,6,6,7,7,7,7]),
									new TroopsEmbedsObj("7_0"+ReportConstants.TROOP_MARCH,[20,21,22,23,24,25,26,27]),
									new TroopsEmbedsObj("7_0"+ReportConstants.TROOP_ATK,[40,41,42,43,44,45,46,47,48,49,49,49]),
								]));
			//军团步兵
			troopMotion["8_1"] = new MotionResource(
								Motion.make(troop["8"],100,100,60,70,[
									new TroopsEmbedsObj("8_1"+ReportConstants.TROOP_STAY,[0,0,0,0,1,1,1,1,2,2,2,2,3,3,3,3]),
									new TroopsEmbedsObj("8_1"+ReportConstants.TROOP_MARCH,[10,11,12,13,14,15,16,17]),
									new TroopsEmbedsObj("8_1"+ReportConstants.TROOP_ATK,[30,31,32,33,34,35,36,37,38,39]),
									new TroopsEmbedsObj("8_1"+ReportConstants.TROOP_THROW,[50,51,52,53,54,55,56,57,58,59]),
								]));
			troopMotion["8_0"] = new MotionResource(
								Motion.make(troop["8"],100,100,60,70,[
									new TroopsEmbedsObj("8_0"+ReportConstants.TROOP_STAY,[4,4,4,4,5,5,5,5,6,6,6,6,7,7,7,7]),
									new TroopsEmbedsObj("8_0"+ReportConstants.TROOP_MARCH,[20,21,22,23,24,25,26,27]),
									new TroopsEmbedsObj("8_0"+ReportConstants.TROOP_ATK,[40,41,42,43,44,45,46,47,48,49]),
									new TroopsEmbedsObj("8_0"+ReportConstants.TROOP_THROW,[60,61,62,63,64,65,66,67,68,69]),
								]));
			
			//city defense
			city = new Object();
			city["19"] = new C_WALL() as BitmapData;
			//place
			place = new Object();
			
			//others
			others = new Object();
			others["blaze"] = Bitmap(new O_BLAZE()).bitmapData;
			others["corpse"] = Bitmap(new O_CORPSE()).bitmapData;
			others["pit"] = Bitmap(new O_PIT()).bitmapData;
			others["smoke"] = Bitmap(new O_SMOKE()).bitmapData;
			others["weapon"] = Bitmap(new O_WEAPON()).bitmapData;
			others["kill"] = Bitmap(new O_KILL()).bitmapData;
			
			//weapon
			weapon = new Object();
			weapon["arrow"] = new MotionResource(
								Motion.make(others["weapon"],100,100,40,49,[new WeaponEmbedsObj("arrow"+ReportConstants.EMBEDS_COMMON,[0,0,0,0,0,0,0,0,0,99])]));
			weapon["javelin"] = new MotionResource(
								Motion.make(others["weapon"],100,100,20,49,[new WeaponEmbedsObj("javelin"+ReportConstants.EMBEDS_COMMON,[1,1,1,1,1,1,1,1,1,99])]));
			weapon["peg"] = new MotionResource(
								Motion.make(others["weapon"],100,100,24,49,[new WeaponEmbedsObj("peg"+ReportConstants.EMBEDS_COMMON,[2,2,2,2,2,2,2,2,2,99])]));
			weapon["stone"] = new MotionResource(
								Motion.make(others["weapon"],100,100,50,50,[new WeaponEmbedsObj("stone"+ReportConstants.EMBEDS_COMMON,[3,3,3,3,3,3,3,3,4,5])]));
			weapon["wallStone"] =new MotionResource(
								Motion.make(others["weapon"],100,100,50,50,[new WeaponEmbedsObj("wallStone"+ReportConstants.EMBEDS_COMMON,[6,6,6,6,6,4,5])]));
			weapon["trap"] = new MotionResource(
								Motion.make(others["weapon"],100,100,50,50,[new WeaponEmbedsObj("trap"+ReportConstants.EMBEDS_COMMON,[7,7,7,7,7,7,7,7])]));
			weapon["towerArrow"] = new MotionResource(
								Motion.make(others["weapon"],100,100,5,5,[new WeaponEmbedsObj("towerArrow"+ReportConstants.EMBEDS_COMMON,[8,8,8,8,8,8,8,8,8,99])]));
								
			//otherMotion
			otherMotion = new Object();
			otherMotion["blaze"] = new MotionResource(
								Motion.make(others["blaze"],60,60,30,50,[new BlazeEmbedsObj("blaze"+ReportConstants.EMBEDS_COMMON,[0,1,2,3,4,5,6,7,8])]));
			otherMotion["smoke"] = new MotionResource(
								Motion.make(others["smoke"],100,100,50,50,[new TroopsEmbedsObj("smoke"+ReportConstants.EMBEDS_COMMON,[0,1,2,3,4,5,6,7,8,9])]));
			otherMotion["corpse"] = new MotionResource(
								Motion.make(others["corpse"],100,100,50,50,[new CorpseEmbedsObj("corpse"+ReportConstants.EMBEDS_COMMON,[0,1,2,3,4,5,10,11,12,13,14,15])]));
			otherMotion["pit"] = new MotionResource(
								Motion.make(others["pit"],100,100,50,50,[new TroopsEmbedsObj("pit"+ReportConstants.EMBEDS_COMMON,[0,1,0,1,0,1,0,1,0,0])]));
			otherMotion["kill"] = new MotionResource(
								Motion.make(others["kill"],50,50,20,50,[new KillEmbedsObj("kill"+ReportConstants.EMBEDS_COMMON,[99,99,99,99,99,0,1,2,3,4])]));
		}
		
		/**
		 * getter function
		 **/
		public function getBeansLogoSrc(url:String):BitmapData{
			return logos[url] as BitmapData;
		}
		
		public function getArmsSrc(typeId:int):BitmapData{
			var rs:BitmapData;
			rs = troop[typeId.toString()] as BitmapData;
			return rs;
		}
		
		public function getCitySrc(typeId:int):BitmapData{
			var rs:BitmapData;
			rs = city[typeId.toString()] as BitmapData;
			return rs;
		}
		
		public function getOthersSrc(nameType:String):BitmapData{
			var rs:BitmapData;
			rs = others[nameType] as BitmapData;
			return rs;
		}
		
		/**
		 * 获得攻击效果的帧
		 */ 
		public function makeWeaponBMP(s:String,frame:int):BitmapData{
			var mr:MotionResource = weapon[s];
			if(mr){
				throw new Error("makeWeaponBMP s="+s+",frame = "+frame);
			}
			return mr.motion.getStateByName(ReportConstants.EMBEDS_COMMON).embedsArr[frame] as BitmapData;
		} 
		
		/**
		 * 攻击效果MotionResource
		 */ 
		public function getWeapon(str:String):MotionResource{
			return weapon[str] as MotionResource;
		}
		
		/**
		 * 获得死尸
		 */
		private var mr:MotionResource;
		public function getCorpseBMP(id:Number):BitmapData{
			mr = getOtherMotion("corpse");
			if(!mr){
				throw new Error("getCorpseBMP id="+id);
			}
			return mr.motion.getStateByName("corpse"+ReportConstants.EMBEDS_COMMON).embedsArr[id]; 
		}
		
		public function getArmyMotion(typeId:Number,group:Number):MotionResource{
			return troopMotion[typeId+"_"+group];
		}
		
		public function getOtherMotion(s:String):MotionResource{
			return otherMotion[s];
		}
		
		public function getCastleBg(isBroken:Boolean):BitmapData{
			if(isBroken){
				return bgCastleWallBroken.bitmapData;
			}
			else{
				return bgCastleWithWall.bitmapData;
			}
		}
		
		public function getCastleNoWallBg():BitmapData{
			return bgCastleNoWall.bitmapData;
		}
		
		public function getFieldBg():BitmapData{
			return bgField.bitmapData;
		}
		
		/**
		 * heroes logo resource
		 **/
		
		[Embed(source="embeds/faceB1.png",mimeType="image/jpg")]
		public var LOGO_HERO_1:Class;
		[Embed(source="embeds/faceB2.png",mimeType="image/jpg")]
		public var LOGO_HERO_2:Class;
		[Embed(source="embeds/faceB3.png",mimeType="image/jpg")]
		public var LOGO_HERO_3:Class;
		[Embed(source="embeds/faceB4.png",mimeType="image/jpg")]
		public var LOGO_HERO_4:Class;
		[Embed(source="embeds/faceB5.png",mimeType="image/jpg")]
		public var LOGO_HERO_5:Class;
		[Embed(source="embeds/faceB6.png",mimeType="image/jpg")]
		public var LOGO_HERO_6:Class;
		[Embed(source="embeds/faceB7.png",mimeType="image/jpg")]
		public var LOGO_HERO_7:Class;
		[Embed(source="embeds/faceB8.png",mimeType="image/jpg")]
		public var LOGO_HERO_8:Class;
		[Embed(source="embeds/faceB9.png",mimeType="image/jpg")]
		public var LOGO_HERO_9:Class; 
		[Embed(source="embeds/faceB10.png",mimeType="image/jpg")]
		public var LOGO_HERO_10:Class;
		
		[Embed(source="embeds/faceA1.png",mimeType="image/jpg")]
		public var LOGO_HERO_21:Class;
		[Embed(source="embeds/faceA2.png",mimeType="image/jpg")]
		public var LOGO_HERO_22:Class;
		[Embed(source="embeds/faceA3.png",mimeType="image/jpg")]
		public var LOGO_HERO_23:Class;
		[Embed(source="embeds/faceA4.png",mimeType="image/jpg")]
		public var LOGO_HERO_24:Class;
		[Embed(source="embeds/faceA5.png",mimeType="image/jpg")]
		public var LOGO_HERO_25:Class;
		[Embed(source="embeds/faceA6.png",mimeType="image/jpg")]
		public var LOGO_HERO_26:Class;
		[Embed(source="embeds/faceA7.png",mimeType="image/jpg")]
		public var LOGO_HERO_27:Class;
		[Embed(source="embeds/faceA8.png",mimeType="image/jpg")]
		public var LOGO_HERO_28:Class;
		[Embed(source="embeds/faceA9.png",mimeType="image/jpg")]
		public var LOGO_HERO_29:Class;
		[Embed(source="embeds/faceA10.png",mimeType="image/jpg")]
		public var LOGO_HERO_30:Class;
		
		/**
		 * troop resource
		 **/
		 //2 弓箭手
		[Embed(source="embeds/troop_archers.png",mimeType="image/png")]
		public var A_ARCHERS:Class;
		//3 弩车
		[Embed(source="embeds/troop_ballistas.png",mimeType="image/png")]
		public var A_BALLISTAS:Class;
		//4 骑兵
		[Embed(source="embeds/troop_cavalry.png",mimeType="image/png")]
		public var A_CAVALRY:Class;
		//5 投石车
		[Embed(source="embeds/troop_onagers.png",mimeType="image/png")]
		public var A_ONAGERS:Class;
		//6 斥候
		//[Embed(source="embeds/tem=plate.png",mimeType="image/png")]
		//public var A_SCOUT:Class;
		//7 枪兵
		[Embed(source="embeds/troop_triarii.png",mimeType="image/png")]
		public var A_TRIARII:Class;
		//8 军团步兵
		[Embed(source="embeds/troop_cohort.png",mimeType="image/png")]
		public var A_URBAN_COHORT:Class;
		
		
		/**
		 *  city defense resource
		 **/
		//19 城墙
		[Embed(source="embeds/template.png",mimeType="image/png")]
		public var C_WALL:Class;
		
		// 死尸
		[Embed(source="embeds/others_corpse.png",mimeType="image/png")]
		public var O_CORPSE:Class;          
		
		/**
		 * others resource 攻击效果
		 **/
		[Embed(source="embeds/others_blaze.png",mimeType="image/png")]
		public var O_BLAZE:Class;                  
		[Embed(source="embeds/others_pit.png",mimeType="image/png")]
		public var O_PIT:Class;
		[Embed(source="embeds/others_smoke.png",mimeType="image/png")]
		public var O_SMOKE:Class;
		[Embed(source="embeds/others_weapon.png",mimeType="image/png")]
		public var O_WEAPON:Class;
		[Embed(source="embeds/others_kill.png",mimeType="image/png")]
		public var O_KILL:Class;
		 
		/**
		 * 场景背景
		 */ 
		[Embed(source="embeds/castleWithWall.jpg",mimeType="image/jpg")]
		public var BG_CASTLEWITHWALL:Class;
		private var bgCastleWithWall:Bitmap = new BG_CASTLEWITHWALL() as Bitmap;
		[Embed(source="embeds/castleWallBroken.jpg",mimeType="image/jpg")]
		public var BG_CASTLEWALLBROKEN:Class;
		private var bgCastleWallBroken:Bitmap = new BG_CASTLEWALLBROKEN() as Bitmap; 
		[Embed(source="embeds/castleNoWall.jpg",mimeType="image/jpg")]
		public var BG_CASTLENOWALL:Class;
		private var bgCastleNoWall:Bitmap = new BG_CASTLENOWALL() as Bitmap; 
		[Embed(source="embeds/field.jpg",mimeType="image/jpg")]
		public var BG_FIELD:Class;
		private var bgField:Bitmap = new BG_FIELD() as Bitmap; 
		
		/**
		 * 城防图标
		 */ 
		
	}
}