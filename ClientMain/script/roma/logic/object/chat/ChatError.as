package roma.logic.object.chat
{
	import roma.util.MultiLang;
	
	public class ChatError
	{
		public static const TIME_LIMIT_ERROR:String = "timeLimitError";
		public static const MSG_REPEAT_ERROR:String = "msgRepeatError";
		public static const MSG_ISEMPTY_ERROR:String = "megIsemptyError";
		public static const HASNOEnough_SPEAKER:String = "hasNoEnoughSpeaker";
		public static const SAY_WITH_YOURSELF_ERROR:String = "sayWithYourselfError";
		public static const NOT_JOIN_ALLIANCE:String = "notJoinAlliance";
		
		public function ChatError()
		{
		}

		public static function showErrorMes(t:String):String{
	    	var str:String = "";
	    	switch(t){
	    		case TIME_LIMIT_ERROR:
	    		str = "<b><font color='#848484'>" + MultiLang.msg("chat.error.forLimit") + "</font></b>";
	    		break;
	    		case MSG_ISEMPTY_ERROR:
	    		str = "<b><font color='#848484'>" + MultiLang.msg("chat.error.mesIsEmpty") + "</font></b>";
	    		break;
	    		case MSG_REPEAT_ERROR:
	    		str = "<b><font color='#848484'>" + MultiLang.msg("chat.error.canNotToRepeat") + "</font></b>";
	    		break;
	    		case SAY_WITH_YOURSELF_ERROR:
	    		str = "<b><font color = '#848484'>"+MultiLang.msg("chat.error.doNotSpeakToYouself")+"</font></b>";
	    		break;
	    		case NOT_JOIN_ALLIANCE:
	    		str = "<b><font color = '#848484'>"+MultiLang.msg("chat.error.hasNoAlliance")+"</font></b>";
	    		break;
	    		case HASNOEnough_SPEAKER:
	    		str = "<font color='#6644bc'>"+MultiLang.msg('chat.system.lable') + MultiLang.msg('chat.noEnoughSpeaker.tips')+"</font>";
	    		break;
	    	}
	    	return str;
	    }
	    
	}
}