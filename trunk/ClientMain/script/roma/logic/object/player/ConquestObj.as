package roma.logic.object.player
{
	import roma.common.valueObject.RelatedCastleTimeBean;
	import roma.logic.GameContext;
	import roma.logic.object.castle.CastleObj;
	
	public class ConquestObj
	{
		public var selfCastleId:int;
		public var isSelect:Boolean = false;
		public var relatedCityBean:RelatedCastleTimeBean;
		
		public function ConquestObj(r:RelatedCastleTimeBean)
		{
			relatedCityBean = r;
		}
		
		public function get castleStr():String{
			var c:CastleObj = GameContext.instance.getPlayerObj().getCastleObjById(selfCastleId);
			return c.name+GameContext.getFieldPostionString(c.idField);
		}
		
	}
}