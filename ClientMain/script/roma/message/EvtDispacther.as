package roma.message
{
	import flash.events.EventDispatcher;
	
	import roma.message.events.MsgEvent;
	import roma.message.events.WindowSwitchEvent;
	
	
	public class EvtDispacther extends EventDispatcher
	{

		public static const PIC_RES_LOADED:String = "划分的图片资源加载完成";
				
		public static const ALL_MODULE_LOADED:String = "开始的时候，全部模块都加载完成";
		
		/** 切换当前城堡事件。 当用户点击城堡图标的时候发生 */
		public static const CUR_CASTLE_CHANGE_EVENT:String = "当前城堡改变";
		
		public static const PLAYER_INFO_UPDATE_EVENT:String = "playerInfo 更新";
		
		public static const AFTER_BUY_ITEM_AT_SHOP:String = "在商店买了物品";
		
		public static const ITEM_ADD_OR_REMOVE:String = "物品增加或者删除";
		
		public static const PLAYER_BUFF_CHANGE:String = "player buff change";
		
		public static const PLAYER_LOGIN:String = "player Login";
		
		public static const CASTLE_ADD_OR_REMOVE:String = "castle 增加或者删除";
		
		public static const PRODUCE_UPDATE:String = "produce.update";
		
		public static const CASTLE_BUFF_UPDATE:String = "castle.buff.update";
		
		public static const FIELD_NUM_CHANGE:String = "野地数量变化了";

		public static const HERO_NUM_CHUANGE:String = "英雄的数量变化了"; 
		
		public static const HERO_ARMY_CHANGE:String = "英雄的部队发生了变化";

		public static const HERO_STATUS_CHANGE:String = "英雄状态变化了";
		
		public static const HERO_BUFF_CHANGE:String = "英雄Buff变化了";

		public static const ASSIGN_TROOP_DROP:String = "分配英雄兵力时，选择好两个英雄后";
		
		public static const ENEMY_ARMY_CHANGE:String = "敌人情况发生变化";
		
		public static const ALLIANCE_ARMY_CHANGE:String = "盟友情况发生变化";

		public static const SCOUTS_CHANGE:String = "侦察情况发生变化";

		public static const WORKER_TRAINNING_UPDATE:String = "worker.trainning.update";
		
		public static const FIELD_FAVOTITE_UPDATE:String = "field.favorite.update";
		
		public static const LOGIN_RESPONSE:String = "登录结果";
		
		public static const FREE_CENTENCE_TIME:String = "聊天最后一句免费的时间";

		public static const TURNTABLE_RAFFLE_NOTICE:String ="轮盘中奖通知";
		
		public static const GM_FORBID_TALK:String ="禁言公告";
		
		public static const TRAINROOM_REPORT:String ="训练场公告";
		
		public static const NPC_ADD_CHANGE:String ="npc城更新";
		
		public static const SYS_HOST_BEATTACK:String = "宗主国被打公告";
		
		public static const WALKING_ROLE_CLICK:String = "点击走动的工人";
		
		public static const OPEORATE_CHANGE:String = "修改开工率";
		
		public static const TRAINING_WORKER:String = "训练工人";
		
		public static const EXTEND_SUCCESS:String = "扩建城池成功";
		
		public static const NEW_SYSTEM_MSG:String = "有新的系统信息";
		
		public static const HERO_SORT_CHANGE:String = "英雄排序改变了";
		
		public static const ITEMRULE_CHANGE:String = "物品规则改变了";
		
		public static const ITEM_USE_COOKIE:String = "itemBuySetting";
		
		public static const SYS_ANNOUNCE_REPORT:String = "有报告的通告";
		
		public static const HERO_LEADERSHIP_CHANGE:String = "英雄统帅值改变了";
		
		public static const HERO_EQUIP_CHANGE:String = "英雄装备改变了";
		
		public static var instance:EvtDispacther = new EvtDispacther();
		
		public var enemyArmyCount:int = 0;

		public var newMailCount:int = 0;
		
		public static function sendEvent(str:String , data:Object=null):void {
			instance.dispatchEvent(new MsgEvent(str , data));
		} 
		
		public function eventDispatch(id:String,data:Object=null,b:Boolean = false):void{
			var e:WindowSwitchEvent = new WindowSwitchEvent(id,data,b);
			this.dispatchEvent(e);
		}
		
	}
}