package views.windows.functionWins.diplomacy
{
	import mx.controls.Label;
	
	import roma.common.valueObject.RelatedCastleBean;
	import roma.logic.GameContext;

	public class DiplomacyRenderLabel extends Label
	{
		public function DiplomacyRenderLabel()
		{
			super();
		}
		
		public function set pos(pId:int):void{
			this.text = GameContext.getFieldPostionString(pId);
		}
		
		public function set cityStr(data:RelatedCastleBean):void{
			this.text = data.castleName+GameContext.getFieldPostionString(data.fieldId);
		}
		
		public function set textStyle(data:RelatedCastleBean):void{
			if(!data.conquestByWar){
				//  主动附庸的
				this.styleName = "chatUnionPlayer";
			}else{
				this.styleName = "playInfoLabel";
			}
		}
		
/* 		public function set myCityStr(id:int):void{
			var c:CastleObj = GameContext.instance.getPlayerObj().getCastleObjById(id);
			this.text = c.name+GameContext.getFieldPostionString(c.idField);
		} */
		
		public function set timeStr(t:Number):void{
			this.text = GameContext.toLocalTimeStr(t);
		}
	}
}