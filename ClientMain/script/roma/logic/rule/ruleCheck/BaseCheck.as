package roma.logic.rule.ruleCheck
{
	[Bindable]
	public class BaseCheck
	{
		public var dispName:String;
		public var dispReq:String;
		public var dispCur:String;
		public var isMatch:Boolean;
		public var isRequest:Boolean;

		public function BaseCheck(reqNum:int=1) {
			this.isRequest = (reqNum>0); 
		}
		
		/**
		 * 需要覆盖的方法，校验是否满足条件
		 */
		public function check():void {
			
		}
	}
}