package roma.war.controler
{
	import flash.display.BitmapData;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.geom.Rectangle;
	import flash.utils.Timer;
	
	import mx.logging.ILogger;
	import mx.logging.Log;
	
	import roma.war.WareplayerSettings;
	import roma.war.constants.ActionConstants;
	import roma.war.constants.ReportConstants;
	import roma.war.data.ReportManager;
	import roma.war.data.actions.ActionItem;
	import roma.war.data.bean.BattleReportType;
	import roma.war.data.bean.BattleTroopType;
	import roma.war.render.RenderOfWars;
	import roma.war.render.WarDataBuffer;
	import roma.war.render.WarMesBuffer;
	import roma.war.render.motion.Army;
	import roma.war.render.motion.Hero;
	import roma.war.resource.EmbedResource;
	import roma.war.resource.MultiLang;
	import roma.war.ui.MainSkin;
	import roma.war.ui.PlayStateBtn;
	import roma.war.ui.ProgressLine;
	import roma.war.ui.UiEvent;
	import roma.war.ui.result.ReportResult;
	import roma.war.ui.result.ResultButton;
	import roma.war.ui.result.TroopsItemUi;

	public class WarPlayer extends EventDispatcher
	{
		public var log:ILogger=Log.getLogger("warPlayer");

		private var _fps:Number;

		public function get fps():Number
		{
			return _fps;
		}

		public function set fps(fps:Number):void
		{
			if (_fps != fps)
			{
				_fps=fps;
				_roundSpace=_roundTimes * fps;
			}
		}
		//回合间隔时间
		private var _roundTimes:Number;

		public function get roundTimes():Number
		{
			return _roundTimes;
		}

		public function set roundTimes(_rt:Number):void
		{
			if (_roundTimes != _rt)
			{
				_roundTimes=_rt;
				_roundSpace=_roundTimes * fps;
				_totalTime = (_length - stepLeft) * _roundSpace;
			}
		}

		//回合帧数
		public function get stepFrames():Number
		{
			return fps * roundTimes;
		}

		//快速播放
		private var _rapid:Number;

		public function set rapid(n:Number):void
		{
			if (_rapid != n)
			{
				_rapid=n;
				if (_rapid > 8)
				{
					_rapid=8;
				}
				else if (_rapid < .5)
				{
					_rapid=.5;
				}
			}
		}

		public function get rapid():Number
		{
			return _rapid;
		}

		//stage offset
		public var stageSize:Rectangle;

		/** 以 MainSkin 及以衍生类型为此播放器的皮肤 **/
		private var _skin:MainSkin;

		public function set skin(ms:MainSkin):void
		{
			if (_skin != ms)
			{
				if (_skin)
				{
					removeSkinEventsListener(_skin);
				}

				_skin=ms;
				addSkinEventsListener(_skin);
				//update stageSize
				stageSize.width=_skin.box.width;
				stageSize.height=_skin.box.height;
				while (_skin.box.numChildren)
					_skin.box.removeChildAt(0);
				
				skin.roundText = "<font color='#ffffff'>" + MultiLang.msg("war.ui.text.round",1)+"</font> \n";
				skin.setResultButton(resultBtn);
				skin.setResultView(resultView);
				this.setResult(); 
			}
		}

		public function get skin():MainSkin
		{
			return _skin;
		}

		private var _source:BattleReportType;
		public function get source():BattleReportType
		{
			return _source;
		} 

		private var _position:Number;

		public function get position():Number
		{
			return _position;
		}

		private var _length:Number; // 行为长度

		public function get length():Number
		{
			return _length;
		}

		private var _roundSpace:Number=0;

		public function get roundSpace():Number
		{
			return _roundSpace;
		}

		//总时间
		private var _totalTime:Number;

		public function get totalTime():Number
		{
			return _totalTime;
		}
		private var _currentTime:Number;

		public function get currentTime():Number
		{
			return _currentTime;
		}

		private var stepLeft:Number=0;

		private var _render:RenderOfWars;
		private var _playerTimer:Timer = new Timer(1000);
		private var _loop:Number;
		private var _repeat:Number;
		private var _hb:WarDataBuffer;
		private var warMes:WarMesBuffer;
		private var _timebackIndex:Number=0;
		
		private var bgBmp:BitmapData;
		
		private var isEchoUpdate:Boolean=true;
		
		private var resultView:ReportResult;
		private var resultBtn:ResultButton;
		
		// 上一回合id		
		private var lastRound:Number=-1;
		private var isGameOver:Boolean = false;
		
		public function WarPlayer(fps:Number=12)
		{
			super();

			this.fps=fps;
			this.roundTimes=10;
			this.rapid=1;
			
			this._source = ReportManager.instance.battleReportType;
			
			stepLeft=0;
			
			_position=-1;
			_length=_source.battle.frames.action.length;
			_loop=1;
			_currentTime=0;
			_totalTime=0;
			
			this.stageSize=new Rectangle();
			
			resultBtn = new ResultButton();
			resultBtn.mouseChildren = false;
			resultBtn.addEventListener(MouseEvent.MOUSE_DOWN,onResultShow);
			resultView = new ReportResult();
			
			MsgComDispatch.instance.addEventListener(UiEvent.SCROLL_STAY,onTextStayLine);
		}

		public function dispose():void
		{
			if (_skin)
			{
				removeSkinEventsListener(_skin);
			}

			_skin=null;
			_source=null;

			_render=null;

			if (_playerTimer)
			{
				removeTimerEventsListener(_playerTimer);
				_playerTimer.stop();
				_playerTimer=null;
			}
			//reset
			this.fps=8;
			this.roundTimes=10;
			this.rapid=1;
			this.skin.reset();

			stepLeft=0;
			_currentTime=0;
			_totalTime=0;

			this.stageSize=new Rectangle();
			_hb=new WarDataBuffer();
			warMes = new WarMesBuffer(_skin);
		}

		/** 从指定时间处开始播放 并循环多少次**/
		public function play(step:int=0, repeatCount:uint=1):void
		{
			trace(" ----------------- play start ------------ ");
			trace("step : "+step+" , repeatCount : "+repeatCount);
			if (_playerTimer)
			{
				removeTimerEventsListener(_playerTimer);
				
				_playerTimer.stop();
				_playerTimer.reset();
			}
			else
			{
				_playerTimer=new Timer(1000);
			}
			if (step < 0)
				step=0;
			if (step >= length - stepLeft - 1)
			{
				step=length - stepLeft - 5;
			}
			
			addTimerEventsListener(_playerTimer);
			_loop=repeatCount;
			_repeat=0;
			_playerTimer.delay=1000 / fps;
			
			_timebackIndex=0;
			_currentTime=0;

			skin.reset();
			if(ReportManager.instance.isInCastle()){
				if(source.battle.wall != null){
					bgBmp = EmbedResource.instance.getCastleBg(false);
				}else{
					bgBmp = EmbedResource.instance.getCastleNoWallBg();
				}
			}
			else{
				bgBmp = EmbedResource.instance.getFieldBg();
			}
			skin.setPlaceGraphics(bgBmp); 
			_playerTimer.start();
			
			if (_render)
			{
				removeRenderEventsListener(_render);
				_render=null;
			}
			_render = new RenderOfWars(stageSize.width, stageSize.height);
			_render.makeEmbedMaker();

			// 跳转播放
 			if (step > 0)
			{
				_position = 0;
				if(_playerTimer.running)
				_playerTimer.stop();
				_hb.initWarData();
				var ai:ActionItem;
				for (_position; _position<= step; _position++)
				{
					ai = source.battle.frames.action.getItemAt(_position) as ActionItem;
					updateAction(ai,true);
				} 
				_position = step;
				_currentTime=step * roundSpace;
				
				warMes.echo(_position);
				updateBattleScene();
				updateDead();
				updateHeroesList();
				skin.view.scrollToBottom();
				if(!_playerTimer.running)
				_playerTimer.start();
				return;
			}
			
			_hb.initWarData();
			updateHeroesList();
			updateDead();
		}
		
		public function initClass():void{
			_hb=ReportManager.instance.warData;
			roundArr = ReportManager.instance.battleReportType.battle.frames.getRoundAction();
			warMes = new WarMesBuffer(skin);
			
			for each(var h:BattleTroopType in source.battle.attackerTroop){
				var hi:heroItem = new heroItem();
				hi.key=h.key;
				hi.heroName=h.heroName;
				hi.state=MultiLang.msg("troop.heroes.wait");
				hi.logo=EmbedResource.instance.getBeansLogoSrc(h.heroUrl);

				skin.redList.addHero(hi);
			}
			for each(var h2:BattleTroopType in source.battle.defenderTroop){
				var hi2:heroItem = new heroItem();
				hi2.key=h2.key;
				hi2.heroName=h2.heroName;
				hi2.state=MultiLang.msg("troop.heroes.wait");
				hi2.logo=EmbedResource.instance.getBeansLogoSrc(h2.heroUrl);   

				skin.blueList.addHero(hi2);
			}
			
			var a:ActionItem;
			for each(a in ReportManager.instance.battleReportType.battle.frames.action){
				_hb.addAction(a,true);
				warMes.addAction(a);
			}
			if (source.battle.isAttackSuccess)
				warMes.addWinMes(ReportConstants.RED);
			else warMes.addWinMes(ReportConstants.BLUE);
			
			wallGoId = ReportManager.instance.wallRemoveId;
			updateHeroesList();
			_hb.initWarData();
		}
		
		public function stop():void
		{
			if (_playerTimer)
			{
				if (_playerTimer.hasEventListener(TimerEvent.TIMER))
				{
					removeTimerEventsListener(_playerTimer);
				}
				_playerTimer.stop();
				_playerTimer.reset();
				dispatchEvent(new FrameEvent(FrameEvent.PLAYER_STOP));
				_playerTimer=null;
			}
			_position=-1;
			stepLeft=0;
		}

		public function pause():void
		{
			if (_playerTimer)
			{
				if (_playerTimer.hasEventListener(TimerEvent.TIMER))
				{
					removeTimerEventsListener(_playerTimer);
					dispatchEvent(new FrameEvent(FrameEvent.PLAYER_PAUSE));
				}
			}
		}

		public function resume():void
		{
			if (_playerTimer)
			{
				if (!_playerTimer.hasEventListener(TimerEvent.TIMER))
				{
					addTimerEventsListener(_playerTimer);
					dispatchEvent(new FrameEvent(FrameEvent.PLAYER_RESUME));
				}
			}
			else
			{
				play();
			}
		}

		private function addRenderEventsListener(ied:IEventDispatcher):void
		{
			
		}

		private function removeRenderEventsListener(ied:IEventDispatcher):void
		{
		}

		private function addSkinEventsListener(ied:IEventDispatcher):void
		{
			ied.addEventListener(PlayStateBtn.STATE_NEXT, playStateHandler);
			ied.addEventListener(PlayStateBtn.STATE_PAUSE, playStateHandler);
			ied.addEventListener(PlayStateBtn.STATE_PLAY, playStateHandler);
			ied.addEventListener(PlayStateBtn.STATE_PREVIOUS, playStateHandler);

			ied.addEventListener(ProgressLine.STATE_CHANGE, playStateHandler);
		}

		private function removeSkinEventsListener(ied:IEventDispatcher):void
		{
			ied.removeEventListener(PlayStateBtn.STATE_NEXT, playStateHandler);
			ied.removeEventListener(PlayStateBtn.STATE_PAUSE, playStateHandler);
			ied.removeEventListener(PlayStateBtn.STATE_PLAY, playStateHandler);
			ied.removeEventListener(PlayStateBtn.STATE_PREVIOUS, playStateHandler);

			ied.removeEventListener(ProgressLine.STATE_CHANGE, playStateHandler);
		}

		private function playStateHandler(event:Event):void
		{
			var pos:Number;
			switch (event.type)
			{
				case PlayStateBtn.STATE_NEXT:
					pos=position;
					stop();
					play(pos + 2);
					break;
				case PlayStateBtn.STATE_PAUSE:
					pause();
					break;
				case PlayStateBtn.STATE_PLAY:
					resume();
					break;
				case PlayStateBtn.STATE_PREVIOUS:
					pos=position;
					stop();
					play(pos - 1);
					break;
				case ProgressLine.STATE_CHANGE:
					pos=Math.ceil(skin.playBar.position * (length - stepLeft - 1));
					stop();
					play(pos);
					break;
			}
		}

		private function addTimerEventsListener(ied:IEventDispatcher):void
		{
			ied.addEventListener(TimerEvent.TIMER, update);
		}

		private function removeTimerEventsListener(ied:IEventDispatcher):void
		{
			ied.removeEventListener(TimerEvent.TIMER, update);
		}

		private function initTroops():void
		{
			//heroes
			_timebackIndex=0;
			updateHP(true);
		}
		
		/**
		 * 结果显示
		 */ 
		private function setResult():void{
			resultView.setContent();
			for each(var a:BattleTroopType in source.battle.attackerTroop){
				var t:TroopsItemUi = new TroopsItemUi();
				t.setTroops(a);
				resultView.addTroops(true,t);
			}
			for each(var d:BattleTroopType in source.battle.defenderTroop){
				var t1:TroopsItemUi = new TroopsItemUi();
				t1.setTroops(d);
				resultView.addTroops(false,t1);
			}
			resultView.resetContent();
		}
		
		/**
		 * 动画的每一秒的更新(每一秒一个行为)
		 */ 
		private function update(event:TimerEvent=null):void
		{
			_currentTime+=rapid;
			
			// 每一行为（判断每一个行为时间）
			if ((_timebackIndex+=rapid) >= roundSpace && _timebackIndex <= roundSpace+rapid)
			{
				_position ++;
				_timebackIndex=0;
//				trace(_position +"update"+source.battle.frames.action.length);
				if (_position < source.battle.frames.action.length){
					var ai:ActionItem=source.battle.frames.action.getItemAt(_position) as ActionItem;
					updateTime();
					updateAction(ai);
					skin.update();
				}
			} 
			
			if((_timebackIndex) >= roundSpace/2){
				skin.roundMcShow();
			} 
			
			if (_position >= source.battle.frames.action.length)
			{
				//游戏结束，显示输赢
				_repeat++;
				if (_repeat < _loop)
				{
					_position=0;
				}
				else
				{
					winner();
					stop();
					return;
				}
			}
			rend();
//			dispatchEvent(new FrameEvent(FrameEvent.PLAYER_PLAYING));
		}
		
		/**
		 * 所有图形更新
		 */ 
		private function rend():void
		{
			// 英雄，军队，攻击效果，每行为掉血设定
			if(_position >-1)
			_render.render(skin.g.graphics);
		}
		
		/**
		 * 更新时间，并刷新进度，播放进度等
		 */ 
		private function updateTime():void{
//			trace("updateTime() "+_currentTime+" "+totalTime);
			skin.playBar.setProgress(_currentTime, totalTime);
		}
		

		private var wallGoId:int;
		private function updateAction(a:ActionItem,isSkip:Boolean = false):void
		{
			//action update
			if(isSkip){
				checkAction(a,true);
			}else{
				checkAction(a);
			}			
			
			// 回合的切换
			if(checkIsRoundAction(a.actionId)){
				_render.roundInit();
				warMes.showRoundFlow(a.round+2,isSkip);
				updateHeroesList();
				updateDead();
			}
			
			// 这时切换到城内的作战
			if(_position>= wallGoId && source.battle.wall != null && wallGoId != -1){
				this.bgBmp = EmbedResource.instance.getCastleBg(true);
			}
			skin.setPlaceGraphics(bgBmp); 
		}
		
		/**
		 * 判断是否为回合的临界点
		 */ 
		private var i:int = 0;
		private var roundArr:Array = [];
		private function checkIsRoundAction(id:int):Boolean{
			for each(i in roundArr){
				if(id == i)return true;
			}
			return false;
		}
		
		/**
		 * 跳转时更新战场英雄情况
		 */ 
		private function updateBattleScene():void{
			_render.updateFieldScene();
		}
		
		/**
		 * 每一回合计算死亡人数
		 */
		private function updateDead():void
		{
			/* var h:Hero;
			var a:Army;
			for each(h in _hb.heroesInBattle)
			{
				if(h == null)continue;
				for each(a in h.armys)
				{
					if (a)
					{
						h.lifeLeft(a.lifeDamage);
						_hb.armyDamage(h.group,a.lifeDamage);
					}
				}
			} */
			updateWallNumbers();
			updateHP(); 
		}


		/**
		 * 更新skin中herosList
		 */
		private function updateHeroesList():void
		{
			var aArr:Array = [];
			var dArr:Array = [];
			var h:Hero;
			var hi:heroItem;
			for each(h in _hb.heroes)
			{
				if (_hb.isHeroInBattle(h.key)){
					continue;
				}else{
					if(h.group == ReportConstants.RED && skin.redList.heroDic[h.key] != null){
						hi = skin.redList.heroDic[h.key];
						if(h.heroStatus == ReportConstants.HERO_QUIT){
							hi.state = MultiLang.msg('troop.heroes.quit');
							hi.dead();
						}
						else if(h.heroStatus == ReportConstants.HERO_RETREAT){
							hi.state=MultiLang.msg("troop.heroes.retreat");
							hi.dead();
						}
						else{
							hi.state=MultiLang.msg("troop.heroes.wait");
							hi.logo = h.heroLogo;
						}
						aArr.push(skin.redList.heroDic[h.key]);
					}
					else if(h.group == ReportConstants.BLUE && skin.blueList.heroDic[h.key] != null)
					{
						hi = skin.blueList.heroDic[h.key];
						if(h.heroStatus == ReportConstants.HERO_QUIT){
							hi.state = MultiLang.msg('troop.heroes.quit');
							hi.dead();
						}
						else if(h.heroStatus == ReportConstants.HERO_RETREAT){
							hi.state=MultiLang.msg("troop.heroes.retreat");
							hi.dead();
						}
						else{
							hi.state=MultiLang.msg("troop.heroes.wait");
							hi.logo=h.heroLogo;
						}
						dArr.push(skin.blueList.heroDic[h.key]);
					}
				}
			}
			skin.redList.clear();
			skin.redList.addHeroList(aArr);
			skin.blueList.clear();
			skin.blueList.addHeroList(dArr); 
		}

		/**
		 * replay check handler
		 * Number Note: [1-9]
		 **/
		private function checkAction(action:ActionItem,isSkip:Boolean=false):void
		{
			_hb.addAction(action,isSkip);
			if(isSkip){
				return;
			}
			if(!isStayLine){
				warMes.echo(action.actionId);
			}
			// 图形的控制
			_render.addAction(action);
			warMes.setRoundTextShow(action.round);
			
			if(action.type == ActionConstants.ACTION_TYPE_MOVE || action.type == ActionConstants.ACTION_TYPE_QUIT  ||
				action.type == ActionConstants.ACTION_TYPE_RETREAT){
				//更新英雄列表
				updateHeroesList();
			} 
		}

		/**
		 * 所有血槽的更新
		 */ 
		private function updateHP(noAction:Boolean=false):void
		{
			//hp
			/* trace(_hb.getGroupHp(ReportConstants.RED)+" , "+_hb.getGroupHpTotal(ReportConstants.RED));
			trace(_hb.getGroupHp(ReportConstants.BLUE) +" ,  "+_hb.getGroupHpTotal(ReportConstants.BLUE)); */
			skin.setHPByGroup(_hb.getGroupHp(ReportConstants.RED), _hb.getGroupHpTotal(ReportConstants.RED), ReportConstants.RED, noAction);
			skin.setHPByGroup(_hb.getGroupHp(ReportConstants.BLUE), _hb.getGroupHpTotal(ReportConstants.BLUE), ReportConstants.BLUE, noAction);
		}
		
		/**
		 * 城防 数值更新显示
		 */
		private function updateWallNumbers():void
		{
			skin.updateWallNumbers(_hb.wallLife, _hb.towerLife, _hb.stoneNumber, _hb.trapNumber);
		}
		
		private function winner():void
		{
			isGameOver = true;
			var group:Number;
			var languegeStr:String = WareplayerSettings.instance.langStr;
			// 这里只有攻击方是否胜利的判断就行
			if (source.battle.isAttackSuccess)
			{
				group=ReportConstants.RED;
			}
			else 
			{
				group=ReportConstants.BLUE;
			}
			skin.showWinner(group == ReportConstants.RED,languegeStr);
		}
		
		/**
		 * 显示战斗结果 
		 */ 
		private function onResultShow(event:MouseEvent):void{
			if(resultView)
			this._skin.setResultView(resultView);
		}
		
		private var isStayLine:Boolean = false;
		private function onTextStayLine(e:UiEvent):void{
			this.isStayLine = Boolean(e.eventData);
		}
		
	}
}