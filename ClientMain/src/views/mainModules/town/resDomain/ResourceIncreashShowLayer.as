package views.mainModules.town.resDomain
{
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import flash.utils.getTimer;
	
	import mx.core.UIComponent;
	
	import roma.common.constants.ResourceConstant;
	import roma.logic.GameContext;
	import roma.logic.object.castle.CastleResourceManager;
	import roma.util.FiltersUtil;

	public class ResourceIncreashShowLayer extends UIComponent
	{
		private var coorAry:Array =[[10,340,ResourceConstant.TYPE_FOOD],[678,20,ResourceConstant.RESOURCE_TYPE_STONES],
									[885,100,ResourceConstant.TYPE_IRON],[890,220,ResourceConstant.TYPE_WOOD],
									[480,130,ResourceConstant.RESOURCE_TYPE_MONEY]];
		
		private var txtAry:Array = [];

		public static var TEXT_WIDTH:int = 50;
		public static var TEXT_HEIGHT:int = 20;
		
		private var now:Number;
		private var start:Number;

		public function ResourceIncreashShowLayer()
		{
			super();
			this.start = getTimer();
			this.initTxtCoordinate();
		}

		private function initTxtCoordinate():void{
			var format:TextFormat = this.getFormat();
			for(var i:int =0;i<coorAry.length;i++){
				var textField:TextField = this.creatTextField(coorAry[i][0],coorAry[i][1],format);
				this.addChild(textField);
				this.txtAry.push(textField);
			}		
		}

		public function aniPlay():void{
			this.now = getTimer();

			if(this.now - this.start >=3000){
				this.start = this.now;
				
				var res:*;
				var resManager:CastleResourceManager = GameContext.instance.getPlayerObj().getCurCastleObj().resourceManager;
				
				for(var i:int = 0;i<txtAry.length;i++){
					txtAry[i].y = coorAry[i][1];
					txtAry[i].alpha = 1.0;
					
					switch(coorAry[i][2]){
						case ResourceConstant.TYPE_FOOD:
							res = resManager.food;
							break;
						case ResourceConstant.RESOURCE_TYPE_STONES:
							res = resManager.stone;
							break;
						case ResourceConstant.TYPE_IRON:
							res = resManager.iron;
							break;
						case ResourceConstant.TYPE_WOOD:
							res = resManager.wood;
							break;
						case ResourceConstant.RESOURCE_TYPE_MONEY:
							res = resManager.golds;
							break;
					}	
					
					var resIncrease:Number = res.totalProduce*(3/3600);
					if(resIncrease>0){
						txtAry[i].htmlText = "<font color='#c0ff3a'>"+"+"+resIncrease.toFixed(2)+"</font>";				
					}else{
						txtAry[i].htmlText ="<font color='#ff0000'>"+resIncrease.toFixed(2)+"</font>";				
					}
				}
				
			}else{
				for(var t:int = 0;t<txtAry.length;t++){
					txtAry[t].y -=1;
					txtAry[t].alpha -= 0.05;
				}				
			}
		}
		
		private function getFormat():TextFormat{
			var f:TextFormat = new TextFormat();
			f.align = TextFormatAlign.CENTER;
			f.size = 11;
			f.bold = true;
			f.font = "Arial";
			//format.color = 0xc0ff3a;
			return f;
		}
		
		private function creatTextField($x:int,$y:int,$format:TextFormat):TextField{
			var tf:TextField = new TextField();
			tf.filters = [FiltersUtil.glowFilter];
			tf.height = TEXT_HEIGHT;
			tf.width = TEXT_WIDTH;
			tf.defaultTextFormat = $format;
			tf.x = $x;
			tf.y = $y;
			return tf;
		}
	}
}