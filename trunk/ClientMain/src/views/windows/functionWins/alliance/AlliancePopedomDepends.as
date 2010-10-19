package views.windows.functionWins.alliance
{
	import roma.util.MultiLang;
	
	[Bindable]
	public class AlliancePopedomDepends
	{
		public var position:String;//职位
		public var voice:Boolean;//发言权
		public var ruler:Boolean;//成员管理
		public var demission:Boolean;//辞职
		public var modifyInfo:Boolean;//修改信息
		public var soldiership:Boolean;//军事外交
		public var dub:Boolean;//权限授予
		public var demise:Boolean;//禅让
		public var quitAlliance:Boolean;//退出联盟
		public var disbandAlliance:Boolean;//解散联盟
		
		public function AlliancePopedomDepends(l:int)
		{
			switch(l){
				case 1:
					this.position=MultiLang.msg("alliance.regular");
					this.voice=true;
					this.ruler=false;
					this.demission=false;
					this.modifyInfo=false;
					this.soldiership=false;
					this.dub=false;
					this.demise=false;
					this.quitAlliance=true;
					this.disbandAlliance=false;
				break;
				
				case 2:
					this.position=MultiLang.msg("alliance.officer");
					this.voice=true;
					this.ruler=true;
					this.demission=true;
					this.modifyInfo=false;
					this.soldiership=false;
					this.dub=false;
					this.demise=false;
					this.quitAlliance=false;
					this.disbandAlliance=false;
				break;
				
				case 3:
					this.position=MultiLang.msg("alliance.presbyter");
					this.voice=true;
					this.ruler=true;
					this.demission=true;
					this.modifyInfo=true;
					this.soldiership=false;
					this.dub=false;
					this.demise=false;
					this.quitAlliance=false;
					this.disbandAlliance=false;
				break;
				
				case 4:
					this.position=MultiLang.msg("alliance.vicehost");
					this.voice=true;
					this.ruler=true;
					this.demission=true;
					this.modifyInfo=true;
					this.soldiership=true;
					this.dub=true;
					this.demise=false;
					this.quitAlliance=false;
					this.disbandAlliance=false;
				break;
				
				case 5:
					this.position=MultiLang.msg("alliance.leader");
					this.voice=true;
					this.ruler=true;
					this.demission=false;
					this.modifyInfo=true;
					this.soldiership=true;
					this.dub=true;
					this.demise=true;
					this.quitAlliance=false;
					this.disbandAlliance=true;
				break;
				
				default:
			}
		}

	}
}