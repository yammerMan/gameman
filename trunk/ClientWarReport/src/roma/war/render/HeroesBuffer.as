package roma.war.render
{
	import flash.display.BitmapData;
	import flash.events.EventDispatcher;
	
	import roma.war.*;
	import roma.war.constants.ReportConstants;
	import roma.war.data.actions.ActionItem;
	import roma.war.data.bean.BattleTroopType;
	import roma.war.render.motion.Army;
	import roma.war.render.motion.Hero;
	import roma.war.resource.EmbedTroopMaker;
	import roma.war.ui.DisplayConfig;
	
	public class HeroesBuffer extends EventDispatcher
	{
		public function HeroesBuffer()
		{
			
		}
		
		public function dispose():void{
			
		}
		
	}
}
	import flash.display.BitmapData;
	import roma.war.render.motion.Hero;
	import roma.war.render.motion.Army;
	import roma.war.resource.EmbedTroopMaker;
	import flash.geom.Rectangle;
	import flash.geom.Matrix;
	import roma.war.ui.DisplayConfig;
	import flash.geom.Point;
	import flash.display.DisplayObject;
	import roma.war.ui.LineHP;
	import roma.war.ui.BarHP;
	import roma.war.render.motion.Alert;
	import flash.display.Sprite;
	import flash.geom.ColorTransform;
	import roma.war.resource.EmbedResource;
	import flash.display.IBitmapDrawable;
	import roma.war.constants.ReportConstants;
	import roma.war.data.BattleHelper;
	import flash.text.TextFormat;

	
class HeroesTemp{
	private var tf:TextFormat = new TextFormat("Tahoma");
	
	function HeroesTemp(width:Number,height:Number,group:Number){
		_bmp = new BitmapData(width,height,true,0x00000000);
		rect = new Rectangle(0,0,width,height);
		_nameTemp = new nameTemp();
		_countTemp = new countTemp();
		_countDamage = new countDamageMC();
		
		_nameTemp.name_txt.setTextFormat(tf);
		_countTemp.num_txt.setTextFormat(tf);
		_countDamage.num_txt.setTextFormat(tf);
		// 双方英雄的血槽，但是没有实现的
		switch(group){
			case ReportConstants.RED:
				_lineHP = new redhp_mc() as BarHP;
			break;
			case ReportConstants.BLUE:
				_lineHP = new bluehp_mc() as BarHP;
			break;
		}
	}
	
	//名字文本
	private var _nameTemp:nameTemp;
	//数量文本
	private var _countTemp:countTemp;
	// 伤害数量的文本
	private var _countDamage:countDamageMC;
	
	//血条
	private var _lineHP:BarHP;
	
	internal var rect:Rectangle;
	
	private var _bmp:BitmapData;
	internal function get bmp():BitmapData{
		return _bmp;
	}
	
	internal function updateBMP(hero:Hero):BitmapData{
		_bmp.fillRect(rect,0x00000000);
		/* var mtx:Matrix = new Matrix();
		if(hero.group == ReportConstants.RED){
			mtx.tx = DisplayConfig.BATTLEFIELD_HERO_LOGO_OFFSET_0.x;
			mtx.ty = DisplayConfig.BATTLEFIELD_HERO_LOGO_OFFSET_0.y;
		}else{
			mtx.tx = DisplayConfig.BATTLEFIELD_HERO_LOGO_OFFSET_1.x;
			mtx.ty = DisplayConfig.BATTLEFIELD_HERO_LOGO_OFFSET_1.y;
		}
		if(hero.logo is IBitmapDrawable)
		_bmp.draw(hero.logo,mtx);
		
		_nameTemp.name_txt.text = hero.name;
		_nameTemp.name_txt.setTextFormat(tf);
		if(hero.logo != null){
			mtx.ty+=hero.logo.height;
			mtx.tx+=hero.logo.width/2;
			_bmp.draw(_nameTemp,mtx);
		}
		
		for(var i:Number = 0;i<hero.army.length;i++){
			var tn:Number = hero.group == ReportConstants.RED ? i : hero.army.length-i-1;
			var a:Army = hero.army[tn];
			if(a){
				var ap:Point = DisplayConfig["BATTLEFIELD_AMRY_POINT_"+hero.group][tn];
				//trace(a.troopId,i)
				var la:Array = a.lineup;
				var lax:Array = a.linpupMax;
				var count:Number = a.lineup.length;
				var countMax:Number = a.linpupMax.length;
				var tmp:BitmapData = EmbedTroopMaker.make(a);
				var tmpd:BitmapData = EmbedTroopMaker.makeCorpseBMP(a.troopId,a.group);
				var mt:Matrix = new Matrix();
				for(var j:Number = 0;j<countMax;j++){
					var tm:Number = hero.group == ReportConstants.RED ? j : countMax - j -1;
					var p1:Point = la[tm];
					if(p1){
					 	mt.tx = p1.x+ ap.x - a.offset.x;
						mt.ty = p1.y+ ap.y - a.offset.y;
						_bmp.draw(tmp,mt);
					}else{
					 	p1 = lax[tm];
						mt.tx = p1.x+ ap.x - a.offset.x;
						mt.ty = p1.y+ ap.y - a.offset.y;
						_bmp.draw(tmpd,mt);
					}
				}
				if(a.count > 0){
					//血条
					_lineHP.setProgress(a.life,a.lifeMax,true);
					//_lineHP.update();
					var lp:Point = DisplayConfig["BATTLEFIELD_AMRY_LIFE_OFFSET_"+hero.group];
					var se:Number = BattleHelper.getTroopScaleNum(a.count);
					//mt.scale(se,se);
					mt.tx = ap.x + lp.x;
					mt.ty = ap.y + lp.y;
					//_bmp.draw(_lineHP,mt);
					mt.scale(1,1);
					//数量
					_countTemp.num_txt.text = a.count.toString();
					mt.ty += -2-_lineHP.height;
					_bmp.draw(_countTemp,mt);
					
					mt.tx += 30;
					// 这里需要作出死掉的军队的计算
					if(a.damageCount<0){
						_countDamage.num_txt.text = String(int(a.damageCount));
						_bmp.draw(_countDamage,mt);
					}
					//
						
				}
				var mtty:Number = mt.ty;
				for(var m:Number = 0;m<a.alertStates.length;m++){
					var alt:Alert = a.alertStates[m];
					var dobj:Sprite;
					var alte:Number = alt.position/alt.length;
					var base:Number = 40;
					switch(alt.type){
						case Alert.ALERT_DAMAGE:
							dobj = DisplayConfig.DAMAGE_TEXT;
							DisplayConfig.DAMAGE_TEXT.num_txt.text = alt.value;
						break;
						case Alert.ALERT_SKILL:
							dobj = DisplayConfig.SKILL_NAME_TEXT;
							DisplayConfig.SKILL_NAME_TEXT.name_txt.text = alt.value;
						break;
						case Alert.ALERT_BYSKILL:
							dobj = DisplayConfig.BY_SKILL_NAME_TEXT;
							DisplayConfig.BY_SKILL_NAME_TEXT.name_txt.text = alt.value;
						break;
						case Alert.ALERT_OTHERS:
							dobj = DisplayConfig.OTHERS_TEXT;
							DisplayConfig.OTHERS_TEXT.name_txt.text = alt.value;
						break;
						case Alert.ALERT_DEAD:
							dobj = DisplayConfig.DEAD_TEXT;
							DisplayConfig.DEAD_TEXT.num_txt.text = alt.value;
							mtty+=50;
							base+=50;
						break;
					}
					mt.ty = mtty - base * alte;
					_bmp.draw(dobj,mt,new ColorTransform(1,1,1,1.3-alte));
				}
				a.removeOverTimeAlerts();
			}
		} */
		return _bmp;
	}
}