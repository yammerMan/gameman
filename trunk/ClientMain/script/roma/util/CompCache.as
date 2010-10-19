package roma.util
{
	import flash.display.DisplayObject;
	
	public class CompCache
	{
		public function CompCache(measure:int)
		{
			this.measure = measure;
			this.compCacheArray = new Array();
		}
		
		private var measure:int;
		private var compCacheArray:Array ;
		private var index:int = 0;
		
		public function getUI(clazz:Class):DisplayObject {
			index ++;
			if (index>measure) {
				index=0;
			}
			if (this.compCacheArray[index] == null) {
				this.compCacheArray[index] = new clazz();
			}
			
			return this.compCacheArray[index];
		}

		public function reset():void{
			this.index = 0;
		}
	}
}