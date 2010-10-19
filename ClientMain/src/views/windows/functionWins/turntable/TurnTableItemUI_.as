// ActionScript file

	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.events.MouseEvent;
	
	import gs.TweenLite;
	import gs.easing.Back;
	
	import mx.core.UIComponent;
	import mx.logging.ILogger;
	import mx.logging.Log;
	
	import roma.common.valueObject.RoletteAppearItemBean;
	import roma.logic.rule.GameRuleHelper;
	import roma.logic.rule.ItemRule;
	import roma.resource.ImgManager;
	
	import views.spreadUI.tips.SpeedUpItemTooltip;
	
	private static var log:ILogger = Log.getLogger("views.windows.functionWins.turntable.TurnTableItemUI_");

	private var itemRule:ItemRule;
	
	[Bindable]
	private var _bean:RoletteAppearItemBean;

	[Bindable]
	private var itemNum:String;
	
	public var isFirst:Boolean;
	
	public var isOpen:Boolean;
	
	private var circleMc:MovieClip;
	
	private var itemMc:MovieClip;
	
	private function init():void{
		this.addItemMC();
				
		if(isFirst){
			this.img1.source = ImgManager.clazz("turntable.lidLeft.first");
			this.img2.source = ImgManager.clazz("turntable.lidRight.first");
		}else{
			this.img1.source = ImgManager.clazz("turntable.lidLeft");
			this.img2.source = ImgManager.clazz("turntable.lidRight");
		}
		
		this.addCircleMc();
		this.imgContainer.mask = this.drawCircle();
		
		this.addEventListener(MouseEvent.MOUSE_OVER,onMouseOver)
		this.addEventListener(MouseEvent.MOUSE_MOVE,onMouseMove);
		this.addEventListener(MouseEvent.MOUSE_OUT,onMouseOut);
	}
	
	private function addCircleMc():void{
		var circleAniC:Class =ImgManager.clazz('turntable.circleAni');
		circleMc = new circleAniC() as MovieClip;
		circleMc.gotoAndStop(17);
		this.MCcontainer.addChild(circleMc);
	}
	
	private function addItemMC():void{
		[Embed(source="fla/itemResource.swf",symbol="itemMc")]	
		var imgSrc:Class;
		itemMc = new imgSrc() as MovieClip; 
		itemMc.gotoAndStop(1);
		this.imgComponent.addChild(itemMc);
		this.imgComponent.scaleY = 0.8;
		this.imgComponent.scaleX = 0.8;
	}
	
	private function drawCircle():Shape{
		var shape:Shape = new Shape();
		shape.graphics.beginFill(0xffff00);
		shape.graphics.drawCircle(32,32,25);
		shape.graphics.endFill();
		
		var comp:UIComponent = new UIComponent();
		comp.addChild(shape);
		this.addChild(comp);
		return shape; 
	}
	
	public function set bean(b:RoletteAppearItemBean):void{
		_bean = b;
		this.itemRule = GameRuleHelper.instance.getItemRuleById(_bean.itemId);
		
		if(_bean !=null){
			log.debug("每轮更新的物品id:"+"\t"+_bean.itemId);
			this.itemMc.gotoAndStop(_bean.itemId);
		}else{
			log.debug("每轮更新物品时出现bean为null");
		}
		
		if(_bean.itemId.length>7 && _bean.itemId.substr(0,7) == "_number"){
			var ary:Array =_bean.itemId.split(".");
			var resNum:Number = ary[ary.length-1];
			if(resNum.toString().length>=5){
				this.itemNum = String(resNum.toString().substr(0,resNum.toString().length-3)+"k"+"x"+_bean.count); 
			}else{
				this.itemNum = String(resNum); 
			}
		}else{
			this.itemNum = String(_bean.count);
		}
	}
	
	public function get bean():RoletteAppearItemBean{
		return _bean;
	}
	
	public function getItemNum():String{
		return this.itemNum;
	}
	
	public function get roletteItemRule():ItemRule{
		return this.itemRule;
	}
	
	public function circleAniPlay():void{
		this.circleMc.gotoAndPlay(1);
	}
	
	public function circleAniEndStop():void{
		if(this.circleMc.currentFrame>=17){
			this.circleMc.gotoAndStop(this.circleMc.currentFrame);
		}
	}
	
	public function circleAniNowStop():void{
		this.circleMc.gotoAndStop(17);
	}
	
  	private function onMouseOver(event:MouseEvent):void {
  		if(this.itemRule!=null && this.isOpen){
	  		SpeedUpItemTooltip.show(this.itemRule);
			SpeedUpItemTooltip.instance.onMouseOver(event);
  		}
	}
	
	private function onMouseMove(event:MouseEvent):void{
		if(this.isOpen){
			SpeedUpItemTooltip.instance.onMouseMove(event);
		}
	}
	
	private function onMouseOut(event:MouseEvent):void{
		SpeedUpItemTooltip.instance.onMouseOut();
	}
	
	public function openItemLid():void{
		TweenLite.killTweensOf(img1);
		TweenLite.to(img1, 1, {x:img1.x -30,ease:Back.easeOut,onUpdate:update});	
		TweenLite.killTweensOf(img2);
		TweenLite.to(img2, 1, {x:img2.x+30,ease:Back.easeOut,onUpdate:update});	
	}
	
	public function closeItemLid():void{
		TweenLite.killTweensOf(img1);
		TweenLite.to(img1, 1, {x:img1.x+30,ease:Back.easeIn,onUpdate:update});	
		TweenLite.killTweensOf(img2);
		TweenLite.to(img2, 1, {x:img2.x-30,ease:Back.easeIn,onUpdate:update});	
	}
	
	private function update():void{
	}	