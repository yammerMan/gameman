package roma.war.render.motion
{
	public class Alert
	{
		public static const ALERT_DEAD:String = "alert_dead";
		public static const ALERT_DAMAGE:String = "alert_damage";
		public static const ALERT_SKILL:String = "alert_skill";
		public static const ALERT_BYSKILL:String = "alert_by_skill";
		public static const ALERT_OTHERS:String = "alert_others";
		
		public function Alert(type:String,value:String,position:Number,length:Number)
		{
			this.type = type;
			this.value = value;
			this.position = position;
			this.length = length;
		}
		
		public var type:String;
		public var value:String;
		public var position:Number = 0;
		public var length:Number = 0;
		
		public function leave():Boolean{
			return ++position > length;
		}
	}
}