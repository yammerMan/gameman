package roma.war.render
{
	import flash.display.BitmapData;
	import flash.geom.ColorTransform;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.Dictionary;
	
	import roma.common.constants.BattleConstants;
	import roma.common.constants.TroopForConstants;
	import roma.war.constants.ReportConstants;
	import roma.war.data.BattleHelper;
	import roma.war.data.ReportManager;
	import roma.war.data.actions.ActionATK;
	import roma.war.data.actions.ActionItem;
	import roma.war.render.motion.Army;
	import roma.war.render.motion.Hero;
	import roma.war.resource.EmbedResource;
	import roma.war.ui.DisplayConfig;
	
	
	public class EmbedTroopMaker
	{
		
		private var curHeroList:Dictionary = new Dictionary(true);
		private var heroBmpRemoveDic:Dictionary = new Dictionary(true);
		private var wd:WarDataBuffer;
		
		public function EmbedTroopMaker()
		{
			curHeroList = new Dictionary();
			wd = ReportManager.instance.warData;
			init();
		}
		
		private function init():void{
			var i:int = 0;
			for(i=0;i<6;i++){
				curHeroList[i] = new HeroBMP();
			}
		}
		
		/**
		 * 英雄军队攻击
		 */ 
		private var h:Hero;
		private var hb:HeroBMP;
		internal function heroAtk(a1:Army,action:ActionATK):void{
			h = wd.getBeanByKey(a1.heroKey);
			if(h == null){
				new Error("hero is none for "+a1.heroKey);
			}
			hb = curHeroList[h.location] as HeroBMP;
			if(hb != null){
				if(a1.troopId == TroopForConstants.T_URBAN_COHORT && action.mode == BattleConstants.MODE_RANGE){
					hb.troopMaker(ReportConstants.TROOP_THROW,action.p1);
//					trace("现在的军团步兵的攻击方式是 "+action.mode);
				} 
			else{
				hb.troopMaker(ReportConstants.TROOP_ATK,action.p1);
				}
			}
		}
		
		/**
		 * 英雄受攻击
		 */ 
		internal function heroIsAtked(a2:Army,action:ActionItem):void{
			
		}
		
		/**
		 * 英雄进场
		 */ 
		internal function addHero(h:Hero):void{
			h.heroLogo = EmbedResource.instance.getBeansLogoSrc(h.logoStr);
			h.posPoint = ReportManager.instance.battleFieldPosArr[h.location];
			if(h.group == ReportConstants.RED){
				h.heroLogoPoint = DisplayConfig.BATTLEFIELD_HERO_LOGO_OFFSET_0;
			}else{
				h.heroLogoPoint = DisplayConfig.BATTLEFIELD_HERO_LOGO_OFFSET_1;
			}
			if(curHeroList[h.location] == null)
			curHeroList[h.location] = new HeroBMP();
			hb = curHeroList[h.location];
			hb.updateHeroBmp(h);
			hb.initAlpha = 1;
			hb.isGone = false;
		}
		
		internal function removeHero(h:Hero):void{
			this.heroBmpRemoveDic[0] = curHeroList[h.location] as HeroBMP;
			this.heroBmpRemoveDic[0].initAlpha = 1; 
			curHeroList[h.location] = null;
		}
		
		/**
		 * 外部调用，每一帧的调用
		 */ 
		private var mtxHero:Matrix = new Matrix();
		private var mtxRemoveHero:Matrix = new Matrix();
		private var mtxWall:Matrix = new Matrix();
		private var point:Point = new Point(0,0);
		private var bit:BitmapData;
		private var NUM_FOR_CHANGE:int = 5;
		private var armyMtx:Matrix = new Matrix();
		private var ct:ColorTransform = new ColorTransform(1,1,1,1);
		private var rects:Rectangle = new Rectangle(0,0,100,100);
		private var wallBMP:BitmapData;
		private var tp:Point = new Point();
		private var p:Point = new Point();
		private var a:Army;
		internal function playTroops(cacheBmp:BitmapData):void{
			if(wd.wallLife>0){
				DisplayConfig.WALL_HP.setProgress(wd.wallLife,wd.wallTotalLife,true);
				rects.width = DisplayConfig.WALL_HP.width;
				rects.height = DisplayConfig.WALL_HP.height;
				if(!wallBMP)wallBMP = new BitmapData(DisplayConfig.WALL_HP.width,DisplayConfig.WALL_HP.height,true,0x00000000);
				wallBMP.fillRect(rects,0x00000000);
				wallBMP.draw(DisplayConfig.WALL_HP);
				mtxWall.tx = DisplayConfig.WALL_HP_POINT.x;
				mtxWall.ty = DisplayConfig.WALL_HP_POINT.y;
				cacheBmp.draw(wallBMP,mtxWall);
			} 
			if(ReportManager.instance.warData.getBeanInBattleLength()<0)return;
			for each(hb in curHeroList){
				if(hb == null)continue;
				if(hb.hero == null)continue;
				h = hb.hero;
				tp.x = h.posPoint.x-DisplayConfig.FIELD_SIDE;
				tp.y = h.posPoint.y-DisplayConfig.FIELD_SIDE;
				bit = hb.getTroopsBit();
				if(h.heroStatus == ReportConstants.HERO_ENTER){
					mtxHero.tx = hb.heroInitPoint.x += (tp.x-hb.heroInitPoint.x)/3;
					mtxHero.ty = hb.heroInitPoint.y += (tp.y-hb.heroInitPoint.y)/3;
					if(Point.distance(tp,hb.heroInitPoint) <20){
						h.heroStatus = ReportConstants.HERO_INBATTLE;
					}
					cacheBmp.draw(bit,mtxHero);
				}else{
					mtxHero.tx = tp.x;
					mtxHero.ty = tp.y;
					cacheBmp.draw(bit,mtxHero);
				}
			}
			/** 退出战场的英雄 **/
			if(heroBmpRemoveDic[0] != null){
				heroBmpRemoveDic[0].initAlpha -= 0.1;
				mtxRemoveHero.tx = Hero(heroBmpRemoveDic[0].hero).posPoint.x - DisplayConfig.FIELD_SIDE;
				mtxRemoveHero.ty = Hero(heroBmpRemoveDic[0].hero).posPoint.y - DisplayConfig.FIELD_SIDE;
				bit = heroBmpRemoveDic[0].cache;
				ct.alphaMultiplier = heroBmpRemoveDic[0].initAlpha;
				cacheBmp.draw(bit,mtxRemoveHero,ct);
				if(heroBmpRemoveDic[0].initAlpha <= 0)
				heroBmpRemoveDic[0] = null;
			}
		}
		
	}
}

import roma.war.render.motion.Army;
import flash.display.BitmapData;
import flash.system.System;
import flash.geom.Rectangle;
import flash.geom.Point;
import roma.war.resource.MotionResource;
import flash.geom.Matrix;
import roma.war.resource.Motion;
import roma.war.resource.MotionState;
import roma.common.valueObject.MaterialBean;
import roma.war.resource.embedsObj.TroopsEmbedsObj;
import mx.collections.ArrayCollection;
import roma.war.ui.DisplayConfig;
import roma.war.resource.EmbedResource;
import roma.war.data.BattleHelper;
import roma.war.data.ReportManager;
import roma.war.constants.ReportConstants;
import roma.common.constants.HeroManConstants;
import roma.common.events.CuredTroopUpdate;
import flash.display.Bitmap;
import roma.common.constants.TroopForConstants;
import flash.display.IBitmapDrawable;
import flash.geom.ColorTransform;
import flash.utils.Dictionary;
import roma.war.render.motion.Hero;
import flash.text.TextFormat;
import roma.war.resource.embedsObj.BaseEmbedsObj;
class HeroBMP{
	internal var initAlpha:Number = 1;
	internal var isGone:Boolean = false;
	// 整个英雄的阵地四周分别扩大30像素
	// <TroopsEmbedsObj>
	private var troopsDic:Dictionary = new Dictionary(true);
	internal var heroKey:int;
	internal var hero:Hero;
	internal var heroInitPoint:Point = new Point();
	private var heroNameText:nameTemp = new nameTemp();
	private var tf:TextFormat = new TextFormat("Tahoma");
	private var army:Army;
	
	public function HeroBMP(h:Hero = null){
		if(h != null)
		updateHeroBmp(h);
	}
	
	internal function updateHeroBmp(h:Hero):void{
		troopsDic = new Dictionary();
		hero = h;
		heroKey = h.key;
		heroInitPoint = this.getInitPoint(hero.group);
		for each(army in h.armys){
			troopsDic[army.pos] = TroopsEmbedsObj(EmbedResource.instance.getArmyMotion(army.troopId,army.group).motion.getStateByName(army.troopId+"_"+army.group+ReportConstants.TROOP_MARCH));
		}
	}
	
	internal function dispose():void{
		cache.dispose();
		var o:Object;
		for(o in troopsDic){
			o = null;
		}
		this.troopsDic = new Dictionary();
	}
	
	/**
	 * 对某一个军队的组织
	 */ 
	internal function troopMaker(status:String,pos:int):void{
		army = hero.getArmyByPos(pos);
		delete troopsDic[pos];
		troopsDic[pos] = TroopsEmbedsObj(EmbedResource.instance.getArmyMotion(army.troopId,army.group).motion.getStateByName(army.troopId+"_"+army.group+status));
	}
	
	/**
	 * 画英雄
	 */ 
	private var mtxLogo:Matrix = new Matrix();
	private var mtxName:Matrix = new Matrix();
	private var mtxArmy:Matrix = new Matrix();
	private var point:Point = new Point(0,0);
	private var bit:BitmapData;
	public var cache:BitmapData = new BitmapData(380,230,true,0x0);
	private var troopObj:TroopsEmbedsObj;
	internal function getTroopsBit():BitmapData{
		this.cache.dispose();
		this.cache = new BitmapData(380,230,true,0);
		for each(army in hero.armys){
			troopObj = troopsDic[army.pos] as TroopsEmbedsObj;
			for each(point in army.corpseLineArr){
				bit = BattleHelper.instance.getCorpseBMP(army.troopId,hero.group);
				if(!(bit is IBitmapDrawable))continue;
				mtxArmy.tx = army.posPoint.x+point.x + DisplayConfig.FIELD_SIDE;
				mtxArmy.ty = army.posPoint.y+point.y + DisplayConfig.FIELD_SIDE;
				cache.draw(bit,mtxArmy);
			}
			bit = troopObj.getBit(); 
			if(!(bit is IBitmapDrawable))continue;
			for each(point in army.curLineArr){
				mtxArmy.tx = army.posPoint.x+point.x + DisplayConfig.FIELD_SIDE;
				mtxArmy.ty = army.posPoint.y+point.y + DisplayConfig.FIELD_SIDE;
				cache.draw(bit,mtxArmy);
			}
			
			if(troopObj.curFrame <= 0){
				troopMaker(ReportConstants.TROOP_STAY,army.pos);
			} 
		}
		heroNameText.name_txt.text = hero.name;
		heroNameText.name_txt.setTextFormat(tf);
		if(hero.location>=3){
			mtxName.tx = mtxLogo.tx = hero.heroLogoPoint.x+DisplayConfig.FIELD_SIDE;
			mtxName.ty = mtxLogo.ty = hero.heroLogoPoint.y+DisplayConfig.FIELD_SIDE;
			if(hero.heroLogo != null){
				mtxName.tx += hero.heroLogo.width/2;
				mtxName.ty += hero.heroLogo.height;
			}
		}else{
			mtxName.tx = mtxLogo.tx = hero.heroLogoPoint.x+DisplayConfig.FIELD_SIDE;
			mtxName.ty = mtxLogo.ty = hero.heroLogoPoint.y+DisplayConfig.FIELD_SIDE;
			if(hero.heroLogo != null){
				mtxName.tx += hero.heroLogo.width/2;
				mtxName.ty += hero.heroLogo.height;
			}
		}
		
		if(hero.heroLogo is IBitmapDrawable){
			cache.draw(hero.heroLogo,mtxLogo);
		}
		cache.draw(heroNameText,mtxName);
		
		for each(army in hero.armys){
			if(hero.group == ReportConstants.RED){
				mtxArmy.tx = army.posPoint.x + DisplayConfig.FIELD_SIDE;
				mtxArmy.ty = army.posPoint.y + DisplayConfig.FIELD_SIDE;
			}else{
				mtxArmy.tx = army.posPoint.x + DisplayConfig.FIELD_SIDE;
				mtxArmy.ty = army.posPoint.y + DisplayConfig.FIELD_SIDE;
			}
			if(army.leftCountBit != null)
			cache.draw(army.leftCountBit,mtxArmy);
			mtxArmy.tx += 40;
			if(army.damageCountPerRoundBit != null)
			cache.draw(army.damageCountPerRoundBit,mtxArmy);
		}
		return cache;
	}
	
	private function getInitPoint(g:int):Point{
		if(g == ReportConstants.RED){
			return new Point(100,500);
		}else{
			return new Point(700,50);
		}
	}
}