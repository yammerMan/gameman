package views.spreadUI.playerInfo
{
	import mx.controls.Label;
	
	import roma.util.InputTextHelper;
	
	public class AllianceNameLabel extends Label
	{
		public function AllianceNameLabel()
		{
		}
		
		override public function set text(value:String):void{
			var c:int = 0;
			var str:String="";
 				
			for(var i:int=0;i<value.length;i++){
				var tempStr:String = value.substr(i,1);
				if(InputTextHelper.isDoubleByte(tempStr)){
					c+=2;
				}
				else{
					c+=1;
				}
				if(c>8){
					break;
				}else{
					str+=tempStr;
				}
			}
			
			super.text=str;

		}	
	}
}