package roma.logic.rule.ruleCheck
{
	import mx.collections.ArrayCollection;
	import mx.resources.ResourceManager;
	
	import roma.logic.GameContext;
	import roma.util.MultiLang;
	
	[Bindable]
	public class ItemCheck extends BaseCheck
	{
		public var itemId:String;
		public var reqNum:int;

		
		public function ItemCheck(itemId:String, reqNum:int) {
			super(reqNum);
			this.itemId = itemId;
			this.reqNum = reqNum;
			
			this.dispName = MultiLang.msg("condition.building");
			this.dispReq = ResourceManager.getInstance().getString("item" , itemId + ".name")+" x " + this.reqNum ;
		}
		
		override public function check():void{
			var itemAry:ArrayCollection = GameContext.instance.getPlayerObj().itemManager.itemArray;
			var curNum:int=0;
			
			for(var i:int =0;i<itemAry.length;i++){
				if(itemAry.getItemAt(i).id == this.itemId){
					curNum = itemAry.getItemAt(i).count;
					break;
				}
			}
			
			this.isMatch =(curNum>= this.reqNum);
			this.dispCur = MultiLang.msg("market.amount") + curNum;
		} 
	}
}