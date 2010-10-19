package roma.war.ui
{
	import flash.display.BitmapData;
	import flash.display.Graphics;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.external.ExternalInterface;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	public class MainSkin extends Sprite
	{
		private static var SIZE_WIDTH:int = 1000;
		private static var SIZE_HEIGHT:int = 600;
		
		/**
		 *	关于战斗部分的UI接口 
		 **/
		public function get wallNumberMc():Sprite{
			return this["wall_numbers_mc"];
		}
		
		public function get winnerMc():MovieClip{
			return this["winner_mc"];
		}
		
		/**
		 * 回合浮动框
		 */ 
		public function get roundMc():Sprite{
			return this["round_mc"];
		}
		
		public function set roundText(s:String):void{
			roundMc["round_txt"].htmlText = s;
			roundTxt.htmlText = s;
		}

		public function get roundTxt():TextField{
			return this["round_txt"];
		}
		
		public function get redText():TextField{
			return this["red_txt"] as TextField;
		}
		public function get blueText():TextField{
			return this["blue_txt"] as TextField;
		}
		
		public function get redLine():LineHP{
			return this["redline_mc"] as LineHP;
		}
		
		public function get blueLine():LineHP{
			return this["blueline_mc"] as LineHP;
		}
		
		/** 战斗UI容器 **/
		public function get box():Sprite{
			return this["box_mc"] as Sprite;
		}
		
		/** 双方阵地 **/
		public function get g():Sprite{
			return this["war_mc"] as Sprite;	
		}
		
		/** 战场 **/
		public function get place():Sprite{
			return this["place_mc"];
		}
		
		/** 红方队列显示容器 **/
		public function get redList():HeroesList{
			return this["heroesRed_mc"];
		}
		
		/** 蓝方队列显示容器 **/
		public function get blueList():HeroesList{
			return this["heroesBlue_mc"];
		}
		
		/**  播放控制界面 **/
		public function get playBar():PlayBar{
			return this["playBar_mc"];
		}
		
		private function get viewShort():ReportViews{
			return this["reportView_mc"];
		}
		private function get viewAll():ReportViews{
			return this["reportViewAll_mc"];
		}
		
		/** 战报显示大小窗 **/
		private var viewString:String = "";
		private var _isViewAll:Boolean;
		
		public function get view():ReportViews{
			return _isViewAll?viewAll:viewShort;
		}
		
		public function get roundText():String{
			return roundTxt.text;
		}
		
		public function set isViewAll(b:Boolean):void{
//			if(_isViewAll!=b){
			_isViewAll = b;
			if(_isViewAll){
				viewShort.visible = false;
				viewAll.visible = true;
			}else{
				viewAll.visible = false;
				viewShort.visible = true;
			}
			updateEcho();
//			}
		}
		public function get isViewAll():Boolean{
			return _isViewAll;
		}
		
		/**
		 *	关于播放控制器的界面接口 
		 **/
		public function MainSkin()
		{
			reset();
			addEventsHandler();
			
			var tf:TextFormat = new TextFormat("Tahoma");
			roundMc["round_txt"].setTextFormat(tf);
			roundTxt.setTextFormat(tf);
			
			isViewAll = false;
		}
		
		private function addEventsHandler():void{
			addEventListener(WindowStateBtn.STATE_MAXIMIZE,windowStateHandler);
			addEventListener(WindowStateBtn.STATE_MINIMIZE,windowStateHandler);
		}
		
		private function exitBtnHandler(event:MouseEvent):void{
			try{
				ExternalInterface.call("exitPlayer");
			}catch(e:*){trace(this,e)}
		}
		
		private function windowStateHandler(event:Event):void{ 
			switch(event.type){
				case WindowStateBtn.STATE_MAXIMIZE:
					playBar.y = 31;
					isViewAll = true;
				break;
				case WindowStateBtn.STATE_MINIMIZE:
					playBar.y = 504;
					isViewAll = false;
				break;
			}
			view.scrollToBottom();
		}
		
		public function reset():void{
			while(g.numChildren){
				g.removeChildAt(0);
			}
			
			g.graphics.clear();
			box.graphics.clear();
			
			echoClear();
			
			redList.clear();
			blueList.clear();
			
			winnerMc.visible = false;
			
			updateWallNumbers(0,0,0,0);
			roundMc.visible = false;
		}
		/**
		 * 
		 * 界面提示 
		 * 
		 **/
		 public function updateWallNumbers(wallHp:Number,towerHp:Number,stoneNumber:Number,trapNumber:Number):void{
		 	wallNumberMc["wall_txt"].text = wallHp<0?0:wallHp;
		 	wallNumberMc["tower_txt"].text = towerHp<0?0:towerHp;
		 	wallNumberMc["stone_txt"].text = stoneNumber<0?0:stoneNumber;
		 	wallNumberMc["trap_txt"].text = trapNumber<0?0:trapNumber;
		 }
		 
		 public function showWinner(isAttackWin:Boolean,l:String):void{
		 	winnerMc.visible = true;
			if(isAttackWin)
			winnerMc.gotoAndStop(l+"_aWin");
		 	else winnerMc.gotoAndStop(l+"_dWin");
		 	
		 	roundMc.visible = false;
		 }
		 
		 private var viewFrame:Number = 24;
		 public function showRound():void{
		 	roundMc.visible = true;
		 	roundMc.x = -200;
		 	viewFrame = 24;
		 }
		/**
		 * 战报显示
		 **/
		public function echo(s:String,isUpdate:Boolean = true):void{
			viewString = s;
			updateEcho();
		}
		public function echoClear():void{
			viewString = "";
			view.viewText = "";
		}
		public function updateEcho():void{
			view.viewText = viewString;
		}
		
		public function roundMcShow():void{
			if(--viewFrame>0)roundMc.x += (500 - roundMc.x)*.5;
			else roundMc.x+= (1200-roundMc.x)*.5;
			if(roundMc.x >=1150){
				roundMc.visible = false;
			}
		}
		
		public function update():void{
			playBar.update();
			redLine.update();
			blueLine.update();
			
			//troop hpbar update
			redText.text = Math.ceil(redLine.currentNumber).toString();
			blueText.text = Math.ceil(blueLine.currentNumber).toString();
		}
		
		public function setHPByGroup(currentHp:Number,totalHp:Number,group:Number,noAction:Boolean = false):void{
			switch(group){
				case 0:
					redLine.setProgress(currentHp,totalHp);
					if(!noAction)redLine.currentNumber = currentHp;
				break;
				case 1:
					blueLine.setProgress(currentHp,totalHp);
					if(!noAction)blueLine.currentNumber = currentHp;
				break;
			}
		}
		
		public function setPlaceGraphics(bmp:BitmapData):void{
			fillBMP(place.graphics,bmp);
		}
		
		public function fillBMP(g:Graphics,bmp:BitmapData):void{
			g.clear();
			if(g && bmp){
				g.beginBitmapFill(bmp);
				g.drawRect(0,0,bmp.width,bmp.height);
				g.endFill(); 
			}
		}
		
		public function setResultButton(btn:MovieClip):void{
			this.addChild(btn);
			btn.x = 870;
			btn.y = 170;
		}
		
		public function setResultView(view:MovieClip):void{
			this.addChild(view);
			view.x = (SIZE_WIDTH-780)/2;
			view.y = (SIZE_HEIGHT-330)/2-20;
			view.visible = !view.visible;
		}
		
	}
}