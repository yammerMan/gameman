package roma.war.ui.result
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.text.TextFormat;
	
	import mx.collections.ArrayCollection;
	
	import roma.war.data.bean.BattleTroopType;
	import roma.war.resource.MyResourceManager;

	public class TroopsItemUi extends MovieClip
	{
		private static var size_width:int = 360;
		private static var size_hero:int = 90;
		private static var size_troopItem:int = 42;
		
		private var bitmap:Bitmap = new Bitmap();
		private var tf:TextFormat = new TextFormat();
		
		public function TroopsItemUi()
		{
			super();
			tf = new TextFormat();
			tf.font = "Tahoma";
		}
		
		public function setTroops(t:BattleTroopType):void{
			setHeroMes(t);
			setTroopMes(t.troops);
			
			this.graphics.beginFill(0xdccea9,1);
			this.graphics.drawRect(0,this.height,size_width,1);
		}
		
		private function setHeroMes(t:BattleTroopType):void{
			var h:HeroMesItem = new HeroMesItem();
			// 这里无法判断哪个玩家浏览的，所以没法显示英雄图标（需要以后完善，在数据中加入属于哪个玩家的战报）
			h.heroIcon.visible = false;
			h.heroName.text = t.heroName;
			h.city.text = t.lordName;
			h.heroName.setTextFormat(tf);
			h.city.setTextFormat(tf);
			this.addChild(h);
		}
		
		private function setTroopMes(arr:ArrayCollection):void{
			for(var i:int=0;i<arr.length;i++){
				var a:Object = arr[i];
				if(a.typeId <=0){continue;}
				var t:TroopsItem = new TroopsItem();
				var b:BitmapData = MyResourceManager.instance.getTroopIcon(a.typeId) as BitmapData;
				MovieClip(t.troopIcon).graphics.clear();
				MovieClip(t.troopIcon).graphics.beginBitmapFill(b);
				MovieClip(t.troopIcon).graphics.drawRect(0,0,30,30);
				t.troopsCount.text = String(int(a.count)+int(a.lose));
				t.troopsLose.text = a.lose; 
				t.troopsCount.setTextFormat(tf);
				t.troopsLose.setTextFormat(tf);
				
				t.x = size_hero+size_troopItem * i;
				t.y = 8;
				this.addChild(t);
			}
		}
		
	}
}