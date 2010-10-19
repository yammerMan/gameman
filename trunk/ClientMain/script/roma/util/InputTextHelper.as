package roma.util
{
	import mx.utils.StringUtil;
	
	public class InputTextHelper
	{
		public function InputTextHelper()
		{
		}
		
		public static function specialCharFilter(string:String):Boolean{
			var _true:Boolean = false;
			var s:String = "~!@#$% ^&*()/[]{}=\/|+?><\"';:";
			var arr:Array = string.split("");
			for(var i:int = 0;i<arr.length;i++){
				if(s.indexOf(arr[i]) > -1){
					_true = true;
					break;
				}
			}
			return _true;
		}
		
		public static function specialCharFilterWithSpace(str:String):Boolean{
			var _true:Boolean = false;
			var tempStr:String = "~!@#$%^&*()/[]{}=\/|+?><\"';:";
			var arr:Array = str.split("");
			for(var i:int = 0;i<arr.length;i++){
				if(tempStr.indexOf(arr[i]) > -1){
					_true = true;
					break;
				}
			}
			return _true;
		}
		
		public static function isDoubleByte(c:String):Boolean {
		    if (c == null) {
		     return false;
		    }
		    c = StringUtil.trim(c);
		    var pattern:RegExp = /^[\u0391-\uFFE5]+$/; 
		    var resultObject:Object = pattern.exec(c);
		    if (resultObject == null) {
		     	return false;
		    }
		    return true;
	   }
	   
	   public static function getByteLength(str:String):int{
	   		var l:int =0;
			
			var arr1:Array = str.match(/[\u0391-\uFFE5]/g);
			var arr2:Array = str.split(/[\u0391-\uFFE5]/);
			if(arr1 == null){
				l = arr2.join("").length;
			}else{
				l = arr1.join("").length*2+arr2.join("").length;
			}
	   		return l;
	   }
	   
	   public static function getChatLength(str:String,max:Number):int{
	   		var arr:Array = str.split("");
	   		var cl:int = 0;
	   		var l:int = 0;
	   		for(var i:int=0;i<arr.length;i++){
	   			if(isDoubleByte(arr[i])){
	   				cl += 2;
	   			}else{
	   				cl ++;
	   			}
	   			if(cl>=max){
	   				l = i;
	   				break;
	   			}
	   			l = i;
	   		}
	   		return l;
	   }
	   
	   public static function takeOutSpace(s:String):String{
		   	var str:String=s;
		   	if(str.charAt(str.length-1)=="?"){
		   		str=str.slice(0,str.length-1);
		   		for(var i:int=str.length;i>=1;i--){
		   			if(str.charAt(i-1)==" "){
		   				str=str.slice(0,str.length-1);
		   			}else{
		   				break;
		   			}
		   		}
		   		str+="?";
		   	}
		   	return str;
		  }
		  
		public static function takeOutPunctuation(s:String):String{
			var str:String=s;
			for(var i:int=1;i<str.length;i++){
				if(str.charAt(i-1)==" "&&(str.charAt(i)==","||str.charAt(i)=="?")){
					str=str.slice(0,i-1)+str.slice(i,str.length);
				}
			}
			return str;
		}
		
		
		public static function reviseEmailContentHandle(str:String):String{
			var newString:String="";
			var c:int = 0;
			
			for(var i:int=0;i<str.length;i++){
				var tempStr:String = str.substr(i,1);
				if(tempStr=="<"){
					newString+="&lt;";
					c +=1;
				}else if(tempStr==">"){
					newString+="&gt;";
					c +=1;
				}else{
					
					if(isDoubleByte(tempStr)){
						c +=2;
					}
					else{
						c +=1;
					}
					if(tempStr=="\n"||tempStr=="\t"){
						c=0;
					}
				}
				newString+=tempStr;
				
				if(c>=79&&(tempStr==" "||specialCharFilterWithSpace(tempStr)||isDoubleByte(tempStr))){
					c=0;
					newString+="\n";
				}					
			}
			return newString;
		}
		
		public static function reviseAppointNumContentHandle(str:String,appointNum:int,increment:Number=2):String{
			var newString:String="";
			var textCount:Number = 0;
			
			for(var i:int=0;i<str.length;i++){
				var tempStr:String = str.substr(i,1);
				newString+=tempStr;
				if(isDoubleByte(tempStr)){
					textCount +=increment;
				}
				else{
					textCount +=1;
				}
				if(tempStr=="\n"||tempStr=="\t"){
					textCount=0;
				}
				
				if(textCount>=appointNum&&(tempStr==" "||specialCharFilterWithSpace(tempStr)||isDoubleByte(tempStr))){
					newString+=" ("+MultiLang.msg("public.label.more")+")";
					break;
				}					
			}
			return newString;
		}
	}
}