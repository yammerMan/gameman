package roma.data
{
	import mx.collections.ArrayCollection;
	
	public class NpcUpdateInfoData
	{
		
		public var npcArr:ArrayCollection;
		public var npcType:int;
		public function NpcUpdateInfoData(arr:ArrayCollection,type:int)
		{
			this.npcArr=arr;
			this.npcType=type;
		}

	}
}