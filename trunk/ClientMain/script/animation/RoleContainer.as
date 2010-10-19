package animation
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	import mx.core.UIComponent;
	
	import roma.message.EvtDispacther;

	public class RoleContainer extends UIComponent
	{
		private static const ROLE_WIDTH:int = 42;
		private static const ROLE_HEIGHT:int = 42;

		private var scene:Bitmap = new Bitmap();
		private var roleAni:AniPlayer;
		
		private var xMovePix:Number =0;
		private var YmovePix:Number=0;
		
		private var initXmovePix:Number =0;
		private var initYmovePix:Number =0;
				
		public function RoleContainer(ani:AniPlayer,xPix:Number =0,yPix:Number =0)
		{
			super();

			this.roleAni = ani;
			this.initXmovePix = xPix;
			this.initYmovePix = yPix;
			//this.drawRect();
			this.hitArea = this.getHitArea();
			this.addChild(hitArea);
			this.addChild(this.scene);
			this.buttonMode = true;
			this.useHandCursor = true;
			
			this.addEventListener(MouseEvent.MOUSE_DOWN,mouseDownHandler);
			this.addEventListener(MouseEvent.MOUSE_OVER,overHandler);
			this.addEventListener(MouseEvent.MOUSE_OUT,outHandler);
		}
		
		private function overHandler(event:MouseEvent):void{
			this.alpha = 0.7;
		}
		
		private function outHandler(event:MouseEvent):void{
			this.alpha = 1.0;
		}
		
		private function mouseDownHandler(event:MouseEvent):void{
			EvtDispacther.sendEvent(EvtDispacther.WALKING_ROLE_CLICK,this);
		}
		
		public function drawToRoleAniData():void{
			var cache:BitmapData = new BitmapData(ROLE_WIDTH, ROLE_HEIGHT, true , 0);
			
			//妇女最后一行要向上挪动3个相素
			if(this.roleAni.curFrame>=28){
				this.roleAni.gotoAndPlay(cache,0,-3);
			}else{
				this.roleAni.gotoAndPlay(cache,0,0);
			}
				
			var old:BitmapData = this.scene.bitmapData;
			this.scene.bitmapData = cache;

			if (old!=null) {
				old.dispose();
			}
			
			if(this.xMovePix ==0 && this.YmovePix ==0){
				this.xMovePix = this.initXmovePix;
				this.YmovePix = this.initYmovePix;
			}
			
			if(this.xMovePix !=0 && this.YmovePix !=0){
				this.x+= this.xMovePix;
				this.y+= this.YmovePix;
			}
		}
		
		public function changeRoleAni(ani:AniPlayer,xPix:Number,yPix:Number):void{
			this.roleAni = ani;
			this.xMovePix = xPix;
			this.YmovePix = yPix;
		}

		public function getRoleAni():AniPlayer{
			return this.roleAni;
		}
		
		private function drawRect():void{
			var sprite:Sprite = new Sprite();
			sprite.graphics.beginFill(0xffff00);
			sprite.graphics.drawRect(0,0,ROLE_WIDTH,ROLE_HEIGHT);
			sprite.graphics.endFill();
			this.addChild(sprite);
		}
		
		private function getHitArea():Sprite{
			var sp:Sprite =new Sprite();
			sp.graphics.beginFill(0xffff00,0);
			sp.graphics.drawRect(8,6,26,30);
			sp.graphics.endFill();
			sp.mouseEnabled = false;
			return sp;
		}		
		
		public function getXSpeed():Number{
			return xMovePix;
		}
		
		public function getYSpeed():Number{
			return YmovePix;		
		}
	}
}