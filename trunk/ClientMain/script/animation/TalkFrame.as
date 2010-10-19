package animation
{
	import flash.display.Bitmap;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import flash.utils.getTimer;
	
	import mx.core.UIComponent;
	
	import roma.resource.ImgManager;
	import roma.util.FiltersUtil;

	public class TalkFrame extends UIComponent
	{
		private var _text:TextField;
		private var _bitMap:Bitmap;

		private var _start:int;
		private var _isMove:Boolean;
		
		private var _resStLowStart:int;
		private var _resLackStart:int;
		private var _resExcessStart:int;
		private var _attackedStart:int;
		private var _supportLowStart:int;
		private var _supportHightStart:int;
		
		private var _isResStLowShow:Boolean;
		private var _isResLackShow:Boolean;
		private var _isResExcessShow:Boolean;
		private var _isAttackedShow:Boolean;
		private var _isSupportLowShow:Boolean;
		private var _isSupportHightShow:Boolean;
		
		private static var TIME_DELAY:Number = 10000;
		private static var TIME_INTERVAL:Number = 1800000;
		
		public function TalkFrame()
		{
			super();
			
			this.visible = false;
			this.x =-100;
			this.y = -100;
			
			_bitMap = this.getBitMap();
			_text = this.drawText();
			addChild(_bitMap);
			addChild(_text);
		}

		public function initProp():void{
			this.isMove = false;
			this.visible = false;
			this.x = -100;
			this.y = -100;
			
			_isResStLowShow = false;
			_isResLackShow= false;
			_isResExcessShow= false;
			_isAttackedShow= false;
			_isSupportLowShow= false;
			_isSupportHightShow= false;
		}
		
		public function setValue($value:String):void{
			_text.text = $value;
			_bitMap.width = _text.width+10;
			_bitMap.height =_text.height+10;
			_text.x =(_bitMap.width - _text.width)/2;
			_text.y = (_bitMap.height - _text.height)/2-5;
		}
		
		
		private function getBitMap():Bitmap{
			var cl:Class = ImgManager.clazz("talk.frame");
			var bm:Bitmap = new cl() as Bitmap;
			bm.smoothing = true;
			return bm;
		}
		
		private function drawText():TextField{
			var tf:TextField = new TextField();
			tf.autoSize = TextFieldAutoSize.LEFT;
			tf.filters = [FiltersUtil.glowFilter];
			tf.defaultTextFormat = this.getFormat();
			tf.border = false;
			return tf;
		}	
		
		private function getFormat():TextFormat{
			var f:TextFormat = new TextFormat();
			f.align = TextFormatAlign.LEFT;
			f.size = 11;
			//format.bold = true;
			f.font = "Tahoma";
			f.color = 0xffffff ;
			return f;
		}
		
		public function set start($s:int):void{
			_start = $s;
		}
	
		public function isTimeOver():Boolean{
			var now:int = getTimer();
			return (now -_start)>TIME_DELAY?true:false;
		}

		public function isIntervalTimeOver():void{
			var now:int = getTimer();
			
			if(now -_resStLowStart>TIME_INTERVAL)_isResStLowShow = false;
			
			if(now -_resLackStart>TIME_INTERVAL)_isResLackShow= false;
			
			if(now -_resExcessStart>TIME_INTERVAL)_isResExcessShow= false;
			
			if(now -_attackedStart>TIME_INTERVAL)_isAttackedShow= false;
			
			if(now -_supportLowStart>TIME_INTERVAL)_isSupportLowShow= false;
			
			if(now -_supportHightStart>TIME_INTERVAL)_isSupportHightShow= false;
		}  
		
		public function set resStLowStart($st:int):void{
			_resStLowStart = $st;
		}

		public function set resLackStart($st:int):void{
			 _resLackStart =$st;
		}
			
		public function set resExcessStart($st:int):void{
			_resExcessStart= $st;
		}

		public function set attackedStart($st:int):void{
			_attackedStart= $st;
		}

		public function set supportLowStart($st:int):void{
			_supportLowStart= $st;
		}

		public function set supportHightStart($st:int):void{
			_supportHightStart = $st;
		}

		public function set isMove(mv:Boolean):void{
			_isMove = mv;
		}
		
		public function get isMove():Boolean{
			return _isMove;
		}
		
		public function set isResStLowShow(b:Boolean):void{
			_isResStLowShow = b;
		}
		
		public function get isResStLowShow():Boolean{
			return _isResStLowShow;		
		}

		public function set isResLackShow(b:Boolean):void{
			_isResLackShow = b;
		}
		
		public function get isResLackShow():Boolean{
			return _isResLackShow;		
		}

		public function set isResExcessShow(b:Boolean):void{
			_isResExcessShow = b;
		}
		
		public function get isResExcessShow():Boolean{
			return _isResExcessShow;		
		}

		public function set isAttackedShow(b:Boolean):void{
			_isAttackedShow = b;
		}
		
		public function get isAttackedShow():Boolean{
			return _isAttackedShow;		
		}

		public function set isSupportLowShow(b:Boolean):void{
			_isSupportLowShow = b;
		}
		
		public function get isSupportLowShow():Boolean{
			return _isSupportLowShow;		
		}

		public function set isSupportHightShow(b:Boolean):void{
			_isSupportHightShow = b;
		}
		
		public function get isSupportHightShow():Boolean{
			return _isSupportHightShow;		
		}
	}
}