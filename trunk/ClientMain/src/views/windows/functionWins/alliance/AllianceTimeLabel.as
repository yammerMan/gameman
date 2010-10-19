package views.windows.functionWins.alliance
{
	import mx.controls.Label;
	
	import roma.common.valueObject.PlayerInfoDataBean;
	import roma.logic.GameContext;
	import roma.util.MultiLang;
	
	public class AllianceTimeLabel extends Label
	{
		public function AllianceTimeLabel() 
		{
		}
		
		override public function set text(value:String):void{
			if (value=="" || value=="0") {
				super.text = MultiLang.msg('alliance.timeLabel.onLine');
			} else {
				super.text = getDateString(Number(value));
			}
		}
		
		public function set lastTime(obj:Object):void{
			var p:PlayerInfoDataBean = PlayerInfoDataBean(obj);
			if(p.online){
				this.text = "";
			}else{
				text = String(p.lastLogoutTime);
			}
		}
		
		private function getDateString(time:Number):String {
				var now:Number = new Date().valueOf();
				var diff:Number = GameContext.instance.getTimeDis();
				var remain:Number = (now-time - diff)/1000 ;
				
				var str:String = "";
				var day:int = remain / (24 * 60 * 60);
				if(day>30){
					str=MultiLang.msg("alliance.timeLabel.inFewDay",30);
				}else if(day>=7){
					str=MultiLang.msg("alliance.timeLabel.inFewDay",7);
				}else if(day>3&&day<7){
					str=MultiLang.msg("alliance.timeLabel.inFewDay",3);
				}else if(day>1){
					str=MultiLang.msg("alliance.timeLabel.oneDayAgo");
				}else{
					var hour:int = (remain / (60*60) )% 24 ;
					if(hour>3){
						str=MultiLang.msg("alliance.timeLabel.inFewHour",24);
					}else{
						str=MultiLang.msg("alliance.timeLabel.inFewHour",3);
					}
				}
			return str;
			}

	}
}