package roma.war.ui.result
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	import mx.collections.ArrayCollection;
	
	import roma.common.constants.ResourceConstant;
	import roma.war.data.ReportManager;
	import roma.war.data.bean.BattleReportType;
	import roma.war.data.bean.ResourceType;
	import roma.war.resource.MultiLang;
	import roma.war.resource.MyResourceManager;
	
	public class ReportResult extends MovieClip
	{
		public static var size_width:int = 780;
		public static var size_height:int = 330;
		
		[Embed(source="../../resource/embeds/resourceBG.png",mimeType="image/png")]
		public var ResultBg:Class;
		
		private var resultTitle:popUpWinTitle2BtnUp;
		private var reportBg:BitmapScale9Grid;
		
		private var contentsView:Sprite;
		private var contentsMc:Sprite;
		private var contentsMask:Sprite;
		
		private var castleInfo:CastleInfoMC;
		private var attList:ArrayCollection = new ArrayCollection();
		private var defList:ArrayCollection = new ArrayCollection();
		private var attContainer:Sprite;
		private var defContainer:Sprite;
		
		private var scrollBar:ResultScrollbar;
		
		private var reportDescText:TextField;
		private var textFormat:TextFormat = new TextFormat();
		
		public function ReportResult()
		{
			super();			
			
			textFormat = new TextFormat();
			textFormat.font = "Tahoma";
			
			reportBg = new BitmapScale9Grid(Bitmap(new ResultBg()),12,228,12,180);
			reportBg.width = size_width;
			reportBg.height = size_height;
			this.addChild(reportBg);
			resultTitle = new popUpWinTitle2BtnUp();
			this.addChild(resultTitle); 
			resultTitle.x = (reportBg.width-resultTitle.width)/2;
			resultTitle.y = 0;
			resultTitle.reportLabel.text = MultiLang.msg('war.ui.report.label');
			resultTitle.reportLabel.setTextFormat(textFormat);
			
			contentsView = new Sprite();
			
			contentsMask = new Sprite();
			contentsMc = new Sprite();
			castleInfo = new CastleInfoMC();
			attContainer = new Sprite();
			defContainer = new Sprite();
			scrollBar = new ResultScrollbar();
			
			reportDescText = new TextField();
			reportDescText.height = 22;
			reportDescText.width = size_width-30;
			reportDescText.text = "战报结果";
			reportDescText.setTextFormat(textFormat);
			
			this.addChild(reportDescText);
			this.addChild(contentsView);
			this.contentsView.addChild(contentsMc);
			this.contentsView.addChild(contentsMask);
			this.contentsView.addChild(scrollBar);
			
			initClass();
		}
		
		private function initClass():void{
			reportDescText.x = 12;
			reportDescText.y = 34;
			contentsView.x = 12;
			contentsView.y = reportDescText.y+reportDescText.height;
			
			contentsMask.graphics.beginFill(0x0,0);
			contentsMask.graphics.drawRect(0,0,reportBg.width-24,reportBg.height-reportDescText.y-reportDescText.height-12);
			
			scrollBar.x = reportBg.width-24-scrollBar.width;
			contentsMc.mask = contentsMask;
			
			addEventListener(MouseEvent.MOUSE_WHEEL,mouseWheelHandler);
			scrollBar.addEventListener(Event.SCROLL,scrollHandler);
		}
		
		public function setContent():void{
			setReportDesc(ReportManager.instance.battleReportType.getResultDesc());
			var b:BattleReportType = ReportManager.instance.battleReportType;
			if(b.lootResource){
				setCastleInfo(b.lootResource);
			}else if(b.lostRes){
				setCastleInfo(b.lostRes);
			}else{
				castleInfo = null;
			}
		}
		
		private function setReportDesc(str:String):void{
			this.reportDescText.text = str;
			this.reportDescText.setTextFormat(textFormat);
		}
		
		private function setCastleInfo(res:ResourceType):void{
			var f:BitmapData = MyResourceManager.instance.getResourceIcon(ResourceConstant.TYPE_FOOD) as BitmapData;
			castleInfo.food.graphics.clear();
			castleInfo.food.graphics.beginBitmapFill(f);
			castleInfo.food.graphics.drawRect(0,0,25,25);
			castleInfo.foodText.text = String(res.food);
			var w:BitmapData = MyResourceManager.instance.getResourceIcon(ResourceConstant.TYPE_WOOD) as BitmapData;
			castleInfo.wood.graphics.clear();
			castleInfo.wood.graphics.beginBitmapFill(w);
			castleInfo.wood.graphics.drawRect(0,0,25,25);
			castleInfo.woodText.text = String(res.wood);
			var s:BitmapData = MyResourceManager.instance.getResourceIcon(ResourceConstant.RESOURCE_TYPE_STONES) as BitmapData;
			castleInfo.stone.graphics.clear();
			castleInfo.stone.graphics.beginBitmapFill(s);
			castleInfo.stone.graphics.drawRect(0,0,25,25);
			castleInfo.stoneText.text = String(res.stone);
			var i:BitmapData = MyResourceManager.instance.getResourceIcon(ResourceConstant.TYPE_IRON) as BitmapData;
			castleInfo.iron.graphics.clear();
			castleInfo.iron.graphics.beginBitmapFill(i);
			castleInfo.iron.graphics.drawRect(0,0,25,25);
			castleInfo.ironText.text = String(res.iron);
			var g:BitmapData =  MyResourceManager.instance.getResourceIcon(ResourceConstant.RESOURCE_TYPE_MONEY) as BitmapData;
			castleInfo.gold.graphics.clear();
			castleInfo.gold.graphics.beginBitmapFill(g);
			castleInfo.gold.graphics.drawRect(0,0,25,25);
			castleInfo.goldText.text = String(res.gold);
		}
		
		public function addTroops(isAtt:Boolean,troop:TroopsItemUi):void{
			if(isAtt){
				attContainer.addChild(troop);
				attList.addItem(troop);
			}else{
				defContainer.addChild(troop);
				defList.addItem(troop);
			}
		}
		
		public function resetContent():void{
			for(var i:int=0;i<attList.length;i++){
				var a:TroopsItemUi = attList[i] as TroopsItemUi;
				a.y = a.height*i;
				a.x = 5;
			}
			for(var j:int=0;j<defList.length;j++){
				var d:TroopsItemUi = defList[j] as TroopsItemUi;
				d.y = d.height*j;
				d.x = 5;
			}
			contentsMcAddChild();
		}
		
		private function contentsMcAddChild():void{
			contentsMc.graphics.clear();
			contentsMc.graphics.beginFill(0xdccea9,1);
			contentsMc.graphics.drawRect(0,0,this.width-24,1);
			
			if(castleInfo != null) 
			{
				contentsMc.addChild(castleInfo);
				castleInfo.y = 1+5;
				contentsMc.graphics.drawRect(0,castleInfo.y+castleInfo.height+5,this.width-24,1);
			}
			
			contentsMc.addChild(attContainer);
 			contentsMc.graphics.beginFill(0xdccea9,1);
			contentsMc.addChild(defContainer);
			defContainer.x = reportBg.width/2+1;
			if(castleInfo != null)
			contentsMc.graphics.drawRect(contentsMc.width/2,castleInfo.y+castleInfo.height+5+1+5,1,contentsMc.height);
			else
			contentsMc.graphics.drawRect(contentsMc.width/2,0,1,contentsMc.height);
			attContainer.y = defContainer.y = castleInfo == null?1+5:castleInfo.y+castleInfo.height+5+1+5;
		}
		
		private function scrollHandler(event:Event):void{
			if(contentsMask.height<contentsMc.height)
			listScroll(scrollBar.position * (contentsMask.height-contentsMc.height) - contentsMc.y);
		}
		
		private function mouseWheelHandler(event:MouseEvent):void{
			if(contentsMask.height<contentsMc.height)
			listScroll(event.delta*2)
		}
		
		private function listScroll(delta:Number):void{
			var tn:Number = contentsMc.y + delta;
			if(tn>0)tn = 0;
			if(tn<contentsMask.height-contentsMc.height){
				tn = contentsMask.height-contentsMc.height
			}
			contentsMc.y = tn;
			
			//update scrollBar
			scrollBar.scrollTo(contentsMc.y>>0,contentsMask.height - contentsMc.height);
		}
		
	}
}