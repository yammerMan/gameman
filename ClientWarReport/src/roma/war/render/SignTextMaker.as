package roma.war.render
{
	import flash.display.BitmapData;
	import flash.geom.ColorTransform;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.text.TextFormat;
	import flash.utils.Dictionary;
	
	import roma.common.constants.BattleConstants;
	import roma.war.constants.ActionConstants;
	import roma.war.data.BattleHelper;
	import roma.war.data.ReportManager;
	import roma.war.data.actions.ActionATK;
	import roma.war.data.actions.ActionItem;
	import roma.war.data.actions.ActionTrapATK;
	import roma.war.render.motion.Army;
	import roma.war.render.motion.Hero;
	import roma.war.ui.DisplayConfig;
	
	public class SignTextMaker
	{
		private var textNum:int = 0;
		private var textDic:Dictionary = new Dictionary();
		
		public function SignTextMaker()
		{
			textDic = new Dictionary();
		}
		
		/**
		 * 兵种攻击效果
		 */ 
		private var bit:BitmapData;
		private var t:atkNameTemp;
		internal function armyAtkEffectSign(a1:Army,action:ActionATK):void{
			bit = new BitmapData(128,25,true,0);
			t= DisplayConfig.SKILL_NAME_TEXT;
			t.name_txt.text = BattleHelper.instance.getAttackMode(action.mode);
			bit.draw(t);
			textNum ++;
			textDic[textNum] = new SignText(a1,bit);
		}
		
		/**
		 * 每一回合英雄所有军队的损失个数
		 */ 
		private var h:Hero;
		private var a:Army;
		private var t1:countTemp;
		private var t2:deadNumberTemp;
		private var tf:TextFormat;
		internal function heroDamageCount():void{
			for each(h in ReportManager.instance.warData.heroesInBattle){
				if(h == null) continue;
				for each(a in h.armys){
					bit = new BitmapData(128,25,true,0);
					t2 = DisplayConfig.DEAD_TEXT;
					t2.num_txt.text = a.damageBuffer.toString();
					bit.draw(t2);
					
					a.damageBuffer = 0;
					
					textNum ++;
					textDic[textNum] = new SignText(a,bit);
					// 更新剩下的数据
					t1 = DisplayConfig.LEFT_COUNT;
					t1.num_txt.text = int(a.count+a.damageCount).toString();
					
					var tf:TextFormat = new TextFormat();
					tf.color = BattleHelper.getCountColor(int(a.count+a.damageCount));
					t1.num_txt.setTextFormat(tf);
					
					a.leftCountBit.dispose();
					a.leftCountBit = new BitmapData(128,25,true,0);
					a.leftCountBit.draw(t1);
					
					a.damageCountPerRoundBit.dispose();
					a.damageCountPerRoundBit = new BitmapData(128,25,true,0);
				}
			}
		}
		
		internal function heroByAtkSign(a2:Army,action:ActionItem):void{
			 if(action.type == ActionConstants.ACTION_TYPE_ATK){
				if(ActionATK(action).k1 == BattleConstants.KEY_ROCK_FALL){
					armyDamageBuffCount(a2);
					armyDamageCount(a2,ActionATK(action).dmg);
				}else{
					armyDamageBuffCount(a2);
					armyDamageCount(a2,ActionATK(action).dmg/a2.singleLife);
				}
			}else if(action.type == ActionConstants.ACTION_TYPE_TRAPATTACK){
				armyDamageBuffCount(a2);
				armyDamageCount(a2,ActionTrapATK(action).count);
			}
		}
		
		private var t3:countDamageMC;
		private function armyDamageBuffCount(a2:Army):void{
			t3 = DisplayConfig.DAMAGE_COUNT_PERROUND;
			if(Math.abs(a2.damageBuffer) > 0){
				t3.num_txt.text = a2.damageBuffer.toString();
				// 显示战斗中死亡人数（每一回合才更新）
				a2.damageCountPerRoundBit.dispose();
				a2.damageCountPerRoundBit = new BitmapData(128,25,true,0);
				a2.damageCountPerRoundBit.draw(t3);
			}
		}
		
		private var t4:damageTemp;
		private function armyDamageCount(a2:Army,c:int):void{
			// 掉血,干脆小于零的就不显示了
			if(c <= 0)return;
			bit = new BitmapData(128,25,true,0);
			t4 = DisplayConfig.DAMAGE_TEXT;
			t4.num_txt.text = String(c);
			bit.draw(t4);
			textNum ++;
			textDic[textNum] = new SignText(a2,bit);
		}
		
		private var NUM_FOR_CHANGE:int = 10;
		private var tb:SignText;
		private var mtx:Matrix = new Matrix();
		private var ct:ColorTransform = new ColorTransform(1,1,1,1);
		public function playText(cacheBmp:BitmapData):void{
			for each(tb in textDic){
				bit = tb.getBit();
				mtx.tx = tb.basePoint.x;
				mtx.ty = tb.basePoint.y - 10*tb.frame;
				ct.alphaMultiplier = (1-0.1*tb.frame);
				cacheBmp.draw(bit,mtx,ct);
				if(tb.frame % NUM_FOR_CHANGE == 0){
					dispose(tb.signId);
				}
			}
		}
		
		private function dispose(id:int):void{
			if(textDic[id] != null){
				textDic[id] = null;
				delete textDic[id];
			}
		}
		
	}
}

import flash.display.BitmapData;
import flash.geom.Point;
import roma.war.render.motion.Army;
import roma.war.data.BattleHelper;
import roma.common.constants.BattleConstants;
import roma.war.constants.ReportConstants;

class SignText{
	internal var signId:int = 0;
	internal var frame:int = -1;
	internal var basePoint:Point = new Point(0,0);
	
	public function SignText(a:Army,bit:BitmapData){
		if(a.group == ReportConstants.BLUE)
		basePoint = new Point(a.absolutePoint.x,a.absolutePoint.y);
		else
		basePoint = new Point(a.absolutePoint.x+64,a.absolutePoint.y+32);
		cache.draw(bit);
	}
	
	internal function dispose():void{
		cache.dispose();
		cache = new BitmapData(128,25,true,0);
	}

	private var cache:BitmapData = new BitmapData(128,25,true,0);
	internal function getBit():BitmapData{
		this.frame ++;
		return cache;
	}
}