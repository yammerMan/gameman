package views.windows.functionWins.alliance
{
	import flash.xml.XMLDocument;
	import flash.xml.XMLNode;
	
	import mx.controls.Label;
	import mx.utils.XMLUtil;
	
	import roma.common.constants.AllianceConstant;
	import roma.util.MultiLang;
	
	public class AllianceEventResolveLabel extends Label
	{
		public function AllianceEventResolveLabel()
		{
			super();
		}
		
		public static function getLeagueTitle(l:int):String{
			var title:String="";
			switch(l){
				case AllianceConstant.ALLIANCE_TITLE_CHIEF:
					title=MultiLang.msg("alliance.leader"); 
				break;
				
				case AllianceConstant.ALLIANCE_TITLE_VICE_CHIEF:
					title=MultiLang.msg("alliance.vicehost"); 
				break;
				
				case AllianceConstant.ALLIANCE_TITLE_ELDER:
					title=MultiLang.msg("alliance.presbyter"); 
				break;
				
				case AllianceConstant.ALLIANCE_TITLE_OFFICER:
					title=MultiLang.msg("alliance.officer"); 
				break;
				
				case AllianceConstant.ALLIANCE_TITLE_MEMBER:
					title=MultiLang.msg("alliance.regular"); 
				break;
				
				default:
					title=MultiLang.msg("alliance.regular"); 
			}
			return title;
		}
		
		public static function getLeagueRelation(id:int):String{
			var relation:String="";
			switch(id){
				case AllianceConstant.ALLIANCE_RELATION_FRIENDLY:
					relation=MultiLang.msg("alliance.relationship.friend"); 
				break;
				
				case AllianceConstant.ALLIANCE_RELATION_NEUTRAL:
					relation=MultiLang.msg("alliance.relationship.mid"); 
				break;
				
				case AllianceConstant.ALLIANCE_RELATION_HOSTILE:
					relation=MultiLang.msg("alliance.relationship.enemy"); 
				break;

				default:
					relation=MultiLang.msg("alliance.relationship.mid"); 
			}
			return relation;
		}
		
		override public function set text(value:String):void{
			super.text=value;
			var targetXml:XMLDocument = XMLUtil.createXMLDocument(value);
			for each(var a:XMLNode in targetXml.firstChild.childNodes){
				if(a.nodeName != null){
					switch(a.nodeName){
						case "createEvent":
							this.text=MultiLang.msg("alliance.event.createEvent",a.attributes.person);
							break;
							
						case "quitEvent":
							this.text=MultiLang.msg("alliance.event.quitEvent",a.attributes.person);
							break;
						
						case "joinEvent":
							this.text=MultiLang.msg("alliance.event.joinEvent",a.attributes.person);
							break;
						case "upgradeEvent":
							this.text=MultiLang.msg("alliance.event.upgradeEvent",a.attributes.person,a.attributes.level,a.attributes.memberLimit==undefined?int(a.attributes.level)*10:a.attributes.memberLimit);
							break;
						
						case "titleSetEvent":
							this.text=MultiLang.msg("alliance.event.titleSetEvent",AllianceEventResolveLabel.getLeagueTitle(a.attributes.officerTitle),a.attributes.officer,a.attributes.person,AllianceEventResolveLabel.getLeagueTitle(a.attributes.becomeTitle));
							break;
						
						case "resignEvent":
							this.text=MultiLang.msg("alliance.event.resignEvent",AllianceEventResolveLabel.getLeagueTitle(a.attributes.preTitle),a.attributes.person);
							break;
						
						case "chiefTransferEvent":
							this.text=MultiLang.msg("alliance.event.chiefTransferEvent",a.attributes.preChief,a.attributes.nowChief);
							break;
						
						case "kickOutEvent":
							this.text=MultiLang.msg("alliance.event.kickOutEvent",a.attributes.officer,a.attributes.person);
							break;
						
						case "setRelationEvent":
							if(a.attributes.isBe=="true"){
								this.text=MultiLang.msg("alliance.event.beSetRelationEvent",a.attributes.alliance,a.attributes.person,AllianceEventResolveLabel.getLeagueRelation(a.attributes.relation));
							}else{
								this.text=MultiLang.msg("alliance.event.setRelationEvent",a.attributes.person,a.attributes.alliance,AllianceEventResolveLabel.getLeagueRelation(a.attributes.relation));
							}
							break;
						
						case "cancelRelationEvent":
							if(a.attributes.isBe=="true"){
								this.text=MultiLang.msg("alliance.event.becCancelRelationEvent",a.attributes.alliance,a.attributes.person,AllianceEventResolveLabel.getLeagueRelation(a.attributes.relation));
							}else{
								this.text=MultiLang.msg("alliance.event.cancelRelationEvent",a.attributes.person,a.attributes.alliance,AllianceEventResolveLabel.getLeagueRelation(a.attributes.relation));
							}
							break;
						
						case "beDeclareWarEvent":
							this.text=MultiLang.msg("alliance.event.beDeclareWarEvent",a.attributes.member,a.attributes.enemy);
							break;
						
						case "castleBeSeizedEvent":
							this.text=MultiLang.msg("alliance.event.castleBeSeizedEvent",a.attributes.member,a.attributes.x,a.attributes.y,a.attributes.enemy);
							break;

						
						
						
						break;
						default:
						this.text=a.nodeName;
					}
				}
			}
		}
	}
}