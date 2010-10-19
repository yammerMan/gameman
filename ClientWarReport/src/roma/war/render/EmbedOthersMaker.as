package roma.war.render
{
	import flash.display.BitmapData;
	import flash.display.IBitmapDrawable;
	import flash.geom.ColorTransform;
	import flash.geom.Matrix;
	import flash.utils.Dictionary;
	
	import roma.war.constants.ActionConstants;
	import roma.war.constants.ReportConstants;
	import roma.war.data.actions.ActionItem;
	import roma.war.render.motion.Army;
	import roma.war.resource.EmbedResource;
	import roma.war.resource.embedsObj.BaseEmbedsObj;
	
	public class EmbedOthersMaker
	{
		private var curOtherDic:Dictionary= new Dictionary();
		private var countNum:int = 0;
		private var other:BaseEmbedsObj;
		
		public function EmbedOthersMaker()
		{
			curOtherDic = new Dictionary();
		}
		
		internal function addOthers(otherStr:String,a:Army,action:ActionItem):void{
			other = EmbedResource.instance.getOtherMotion(otherStr).motion.getStateByName(otherStr+ReportConstants.EMBEDS_COMMON);
			var o:OthersBMP = new OthersBMP(other,a.posPoint,a,removeOthers);
			o.othersId = countNum ++;
			curOtherDic[o.othersId] = o;
			if(otherStr == ActionConstants.OTHER_TYPE_KILL){
				var oo:OthersBMP = new OthersBMP(other,a.posPoint,a,removeOthers)
				oo.othersId = countNum ++;
				curOtherDic[oo.othersId] = oo;
			}
		}
		
		/**
		 * 每个回合，所有效果都清空
		 */ 
		public function removeAllOthers():void{
			curOtherDic = new Dictionary();
			countNum = 0;
		}
		
		private var ct:ColorTransform= new ColorTransform(1,1,1,1);
		private var mtx:Matrix = new Matrix();
		private var bit:BitmapData;
		public function playOthers(cacheBmp:BitmapData):void{
			var other:OthersBMP;
			for each(other in curOtherDic){
				bit = other.getOthersBit();
				if(bit is IBitmapDrawable){
					mtx.tx = other.army.absolutePoint.x;
					mtx.ty = other.army.absolutePoint.y;
					ct.alphaMultiplier = Math.max(0,(1-other.frame*.1));
					cacheBmp.draw(bit,mtx,ct);
				}
			}
		}
		
		private function removeOthers(id:int):void{
			curOtherDic[id] = null;
			delete curOtherDic[id];
		}
		
	}
}

import roma.war.resource.EmbedResource;
import flash.utils.Dictionary;
import roma.war.resource.embedsObj.BaseEmbedsObj;
import roma.war.render.motion.Army;
import flash.geom.Point;
import flash.display.BitmapData;
import flash.geom.Matrix;
import flash.display.IBitmapDrawable;
import roma.common.events.CuredTroopUpdate;

class OthersBMP{
	private var p:Point = new Point();
	private var embedsObj:BaseEmbedsObj;
	private var callBackFun:Function;
	
	internal var army:Army;
	internal var othersId:int = 0;
	internal var initPoint:Point = new Point(0,0);
	
	internal function dispose():void{
		cache.dispose();
		cache = new BitmapData(128,64,true,0);
	}
	
	public function OthersBMP(other:BaseEmbedsObj,point:Point,a:Army=null,fun:Function=null){
		embedsObj = other;
		p = point;
		army = a;
		
		frame = 0;
		if(fun != null)callBackFun = fun;
	}
	
	internal var frame:int = 0;
	private var bit:BitmapData;
	private var matrix:Matrix = new Matrix();
	private var cache:BitmapData = new BitmapData(128,64,true,0);
	internal function getOthersBit():BitmapData{
		this.dispose();
		bit = embedsObj.embedsArr[frame];
		if(!(bit is IBitmapDrawable))return null;
		frame ++;
		
		if(army == null){
			cache.draw(bit,null);
		}
		else{
			var p:Point = new Point(0,0);
			for each(p in army.lineupArr){
				matrix.tx = p.x+40;
				matrix.ty = p.y+20;
				cache.draw(bit,matrix);
			}
		}
		
		if(this.frame >= embedsObj.frame){
			callBackFun.call(this,[othersId]);
		}
		return cache;
	}
	
}