package roma.loader
{
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.utils.getDefinitionByName;
	
	public class MyLoader extends MovieClip
	{
		private var loadingSprite:LoadingSprite;
		
		public function MyLoader()
		{
			stop();
			stage.scaleMode=StageScaleMode.NO_SCALE;
			stage.align=StageAlign.TOP_LEFT;
			this.createLoading();
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}

		public function onEnterFrame(event:Event):void
		{
			graphics.clear();
			if (framesLoaded >= totalFrames)
			{
				removeEventListener(Event.ENTER_FRAME, onEnterFrame);
				nextFrame();
				init();
			}
			else
			{
				var percent:Number=Math.floor(root.loaderInfo.bytesLoaded / root.loaderInfo.bytesTotal*100);
				if(loadingSprite.stage)
				loadingSprite.setProgress(percent);
			}
		}


		private function createLoading():void
		{	
			if(this.loaderInfo.parameters.hasOwnProperty("l"))
				this.loadingSprite = new LoadingSprite(this.loaderInfo.parameters["l"]);
			else
				this.loadingSprite = new LoadingSprite("en");
			loadingSprite.x = 260;
			loadingSprite.y = 150;
			this.addChild(loadingSprite);		
		}
		
		
		private function init():void
		{
			var mainClass:Class=Class(getDefinitionByName("wareplay"));
			if (mainClass)
			{
				var app:Object=new mainClass();
				addChild(app as DisplayObject);
			}
		}
}

}