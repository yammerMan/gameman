package roma.war.render
{
	import flash.display.BitmapData;
	import flash.display.IBitmapDrawable;
	import flash.geom.ColorTransform;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.utils.Dictionary;
	
	import net.riahelp.game.utility.Math.MapPath;
	
	import roma.common.constants.BattleConstants;
	import roma.war.constants.ActionConstants;
	import roma.war.constants.ReportConstants;
	import roma.war.data.ActionHelper;
	import roma.war.data.actions.ActionATK;
	import roma.war.data.actions.ActionItem;
	import roma.war.render.motion.Army;
	import roma.war.resource.EmbedResource;
	import roma.war.resource.embedsObj.WeaponEmbedsObj;
	import roma.war.ui.DisplayConfig;
	
	public class EmbedWeaponMaker
	{
		private var curWeaponActionList:Dictionary = new Dictionary(true);
		
		private var w:WeaponEmbedsObj;
		private var weaponId:String = "";
		
		public function EmbedWeaponMaker()
		{
			curWeaponActionList = new Dictionary();
		}
		
		public function removeAllWeapons():void{
			this.curWeaponActionList = new Dictionary();
		}
		
		/**
		 * 军队的攻击
		 */ 
		internal function addWeaponAtoA(a1:Army,a2:Army,action:ActionATK):void{
			weaponId = ActionHelper.getAtkMode(a1.troopId,action.mode);
			if(weaponId == ActionConstants.ATT_TYPE_NORMAL){
				// 普通的攻击没有效果
				return ;
			}
			w = EmbedResource.instance.getWeapon(weaponId).motion.getStateByName(weaponId+ReportConstants.EMBEDS_COMMON) as WeaponEmbedsObj;
			w.posX = a1.absolutePoint.x;w.posY = a1.absolutePoint.y;
			w.offsetX = a2.absolutePoint.x;w.offsetY = a2.absolutePoint.y;
			if(w.posX == 0){
				new Error("a1 pos is wrong");
			}
			if(w.offsetX ==0){
				new Error("a2 pos is wrong");
			}
			curWeaponActionList[action.actionId] = new WeaponBMP(w,action,a1,removeWeapon);
		}
		
		/**
		 * 军队对城防的攻击
		 */ 
		internal function addWeaponAtoB(a1:Army,action:ActionATK):void{
			weaponId = ActionHelper.getAtkMode(a1.troopId);
			if(weaponId == ActionConstants.ATT_TYPE_NORMAL){
				// 军队的普通攻击没有效果
				return;
			}
			w = EmbedResource.instance.getWeapon(weaponId).motion.getStateByName(weaponId+ReportConstants.EMBEDS_COMMON) as WeaponEmbedsObj;
			var tp:Point = new Point(0,0);
			w.posX = a1.absolutePoint.x;
			w.posY = a1.absolutePoint.y;
			switch(action.k2){
				case BattleConstants.KEY_ARROW_TOWER:
					var r:int = Math.random()*4;
					tp = DisplayConfig.ARROW_TOWER_POINTS[r];
					w.offsetX = tp.x;
					w.offsetY = tp.y;
				break;
				case BattleConstants.KEY_WALL:
					w.offsetX = DisplayConfig.WALL_HIT_POINT[0].x;
					w.offsetY = DisplayConfig.WALL_HIT_POINT[0].y;
				break;
			}
			curWeaponActionList[action.actionId] = new WeaponBMP(w,action,a1,removeWeapon);
		}
		
		/**
		 * 其他对军队的攻击
		 */
		private var sp:Point = new Point(0,0);
		private var tp:Point = new Point(0,0);
		private var r:int;
		internal function addWeapon(weaponId:String,a2:Army,action:ActionItem):void{
			w = EmbedResource.instance.getWeapon(weaponId).motion.getStateByName(weaponId+ReportConstants.EMBEDS_COMMON) as WeaponEmbedsObj;
			sp = new Point(a2.absolutePoint.x,a2.absolutePoint.y);
			tp = new Point(a2.absolutePoint.x,a2.absolutePoint.y);
			if(action is ActionATK){
				switch(ActionATK(action).k1){
					case BattleConstants.KEY_ARROW_TOWER:
						r = Math.random()*4;
						sp =  DisplayConfig.ARROW_TOWER_POINTS[r];
					break;
					case BattleConstants.KEY_ROCK_FALL:
						sp.y -= 100;
					break;
				}
			}else{}
			w.posX = sp.x;w.posY = sp.y;
			w.offsetX = tp.x;w.offsetY = tp.y;
			
			this.curWeaponActionList[action.actionId] = new WeaponBMP(w,action,null,removeWeapon);
		}
		
		private var bit:BitmapData;
		private var mtx:Matrix = new Matrix();
		private var ct:ColorTransform = new ColorTransform(1,1,1,1);
		private var weaponOffsetX:int = 30;
		private var weaponOffsetY:int = -20;
		private var wb:WeaponBMP;
		private var p:Point = new Point(0,0);
		public function playWeapon(cacheBmp:BitmapData):void{
			for each(wb in curWeaponActionList){
				bit = wb.getWeaponBit();
				sp = new Point(wb.weaponObj.posX,wb.weaponObj.posY);
				tp = new Point(wb.weaponObj.offsetX,wb.weaponObj.offsetY);
				if(!(bit is IBitmapDrawable))continue;
				if(Math.abs(wb.weaponObj.offsetY-wb.weaponObj.posY)>5){
					if(Math.abs(wb.weaponObj.offsetX-wb.weaponObj.posX) >5){
						wb.offsetPoint = MapPath.getArrowPathPoint(sp,tp,wb.frame,wb.weaponObj.frame,50);
						mtx.tx = wb.offsetPoint.x+weaponOffsetX;
						mtx.ty = wb.offsetPoint.y+weaponOffsetY;
						cacheBmp.draw(bit,mtx);
					}
					else{
						mtx.tx = wb.weaponObj.posX+weaponOffsetX;
						mtx.ty = wb.weaponObj.posY + 100*wb.frame/wb.weaponObj.frame+weaponOffsetY;
						cacheBmp.draw(bit,mtx);
					}
				}else{
					mtx.tx = wb.weaponObj.posX+weaponOffsetX;
					mtx.ty = wb.weaponObj.posY+weaponOffsetY;
					ct.alphaMultiplier = Math.max(0,(1-wb.frame*0.05));
					cacheBmp.draw(bit,mtx,ct)
				}
			}
		}
		
		/**
		 * 删除攻击效果
		 */ 
		private function removeWeapon(aId:int):void{
			curWeaponActionList[aId] = null;
			delete curWeaponActionList[aId]; 
		}
	}
}

import roma.war.render.motion.Army;
import roma.war.resource.EmbedResource;
import flash.utils.Dictionary;
import roma.war.resource.embedsObj.WeaponEmbedsObj;
import flash.geom.Point;
import flash.display.BitmapData;
import flash.display.IBitmapDrawable;
import flash.geom.Matrix;
import roma.war.data.actions.ActionItem;
	
class WeaponBMP{
	private var army:Army;
	internal var weaponObj:WeaponEmbedsObj;
	internal var offsetPoint:Point = new Point(0,0);
	private var action:ActionItem;
	internal var callBackFun:Function;
	
	public function WeaponBMP(w:WeaponEmbedsObj,ai:ActionItem,a:Army=null,fun:Function = null){
		army = a;
		weaponObj = w;
		action = ai;
		offsetPoint = new Point(w.posX,w.posY);
		
		callBackFun = fun;
		
		this.frame = 0;
	}
	
	internal function dispose():void{
		this.cache.dispose();
		this.cache = new BitmapData(100,100,true,0);
	}
	
	internal var frame:int = 0;
	private var bit:BitmapData;
	private var p:Point = new Point(0,0);
	private var matrix:Matrix = new Matrix();
	private var cache:BitmapData = new BitmapData(100,100,true,0);
	private var ran:int = Math.random()*4;
	internal function getWeaponBit():BitmapData{
		this.dispose();
		bit = weaponObj.embedsArr[frame];
		if(!(bit is IBitmapDrawable))return null;
		frame ++;
		
		if(army == null){
			cache.draw(bit,matrix);
		}
		else{
			for each(p in army.curLineArr){
				matrix.tx = p.x/3+ran;
				matrix.ty = p.y/3+ran;
				cache.draw(bit,matrix);
			}
		}
		
		if(frame >= weaponObj.frame){
			frame = weaponObj.curFrame = 0;
			if(callBackFun != null){
				callBackFun.call(this,[action.actionId])
			}
		}
		return cache;
	}
}