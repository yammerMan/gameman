package views.windows.functionWins.alliance
{
	import mx.collections.ArrayCollection;
	
	import roma.common.action.ControllerFactory;
	import roma.common.constants.AllianceConstant;
	import roma.common.controller.alliance.AllianceRelactionResponse;
	import roma.common.valueObject.AllianceInfoDataBean;
	import roma.common.valueObject.AllianceRelationBean;
	import roma.util.MultiLang;
	
	public class AllianceHelper
	{
		public static var instance:AllianceHelper=new AllianceHelper()
		
		private var relationArr:ArrayCollection = new ArrayCollection();                    // 联盟关系数组
		
		public var friendsArr:ArrayCollection=new ArrayCollection();//友好联盟

		public var enemyArr:ArrayCollection=new ArrayCollection();//敌对联盟
		
		public var allianceObj:AllianceInfoDataBean;                                            // 联盟的信息
			
		public function AllianceHelper()
		{
		}
		/*获取玩家联盟职位名称 */
		public function getLeagueLevelName(l:int):String{
			var levelName:String="";
			switch(l){
				case AllianceConstant.ALLIANCE_TITLE_MEMBER:
					levelName=MultiLang.msg('alliance.regular');
					break;
				case AllianceConstant.ALLIANCE_TITLE_OFFICER:
					levelName=MultiLang.msg('alliance.officer');
					break;
				case AllianceConstant.ALLIANCE_TITLE_ELDER:
					levelName=MultiLang.msg('alliance.presbyter');
					break;
				case AllianceConstant.ALLIANCE_TITLE_VICE_CHIEF:
					levelName=MultiLang.msg('alliance.vicehost');
					break;
				case AllianceConstant.ALLIANCE_TITLE_CHIEF:
					levelName=MultiLang.msg('alliance.leader');
					break;
				default:
					levelName=MultiLang.msg('alliance.regular');
			}
			return levelName;			
		}
		
		public function haveRelation(type:int,leagueName:String):Boolean{
			var relation:Boolean=false;
			switch(type){
				case AllianceConstant.ALLIANCE_RELATION_FRIENDLY:
					for each(var friends:AllianceRelationBean in friendsArr){
						if(friends.leagueName==leagueName){
							relation=true;
							break;
						}
					}
				break;
				
				case AllianceConstant.ALLIANCE_RELATION_HOSTILE:
					for each(var enemy:AllianceRelationBean in enemyArr){
						if(enemy.leagueName==leagueName){
							relation=true;
							break;
						}
					}
				break;
				
				case AllianceConstant.ALLIANCE_RELATION_NEUTRAL:
					relation=true;
					for each(var friends2:AllianceRelationBean in friendsArr){
						if(friends2.leagueName==leagueName){
							relation=false;
							break;
						}
					}
					for each(var enemy2:AllianceRelationBean in enemyArr){
						if(enemy2.leagueName==leagueName){
							relation=false;
							break;
						}
					}
				break;
				
				default:
				
			}
			return relation;
		}
		
		public function reFreshRelation():void{
			ControllerFactory.getInstance().getAllianceController().getAllianceRalation(onGetAllianceRelation,false);   	
		}
		
		/**
		 * 联盟关系的响应
		 */ 
		private function onGetAllianceRelation(event:AllianceRelactionResponse):void{
			if(event.isSuccess()){
	 			this.relationArr=event.allianceRelationsArray;
	 			this.assortAlliance();
	 		}
		}
		
		private function assortAlliance():void{
			this.friendsArr.removeAll();
			this.enemyArr.removeAll();
			if(this.relationArr.length>0){
				for each(var bean:AllianceRelationBean in this.relationArr){
					if(bean.relationType==AllianceConstant.ALLIANCE_RELATION_FRIENDLY){
						this.friendsArr.addItem(bean);
					}else if(bean.relationType==AllianceConstant.ALLIANCE_RELATION_HOSTILE){
						this.enemyArr.addItem(bean);
					}
				}
			}
		}

	}
}