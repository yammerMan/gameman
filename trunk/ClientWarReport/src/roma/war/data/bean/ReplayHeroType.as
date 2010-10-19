package roma.war.data.bean
{
	import mx.collections.ArrayCollection;
	import mx.utils.ObjectProxy;
	
	public class ReplayHeroType
	{
		public var key:int;
		public var position:int;
		public var u:ArrayCollection = new ArrayCollection();
		public function ReplayHeroType(o:Object)
		{
			key = o.key;
			position = o.position;
			u = setU(o.u);
		}
		
		private function setU(o:Object):ArrayCollection{
			var arr:ArrayCollection = new ArrayCollection();
			if(o is ObjectProxy){
				arr.addItem(o);
			}else if(o is ArrayCollection){
				for each(var oo:ObjectProxy in o){
					if(oo != null){
						var bb:ObjectProxy = new ObjectProxy(oo);
						arr.addItem(bb);
					}
				}
			}
			return arr;
		}
	}
}