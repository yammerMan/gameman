/**
* 生成时间 1 
*/

package roma.common.valueObject
{
	import mx.collections.ArrayCollection;
	import framework.util.CopyAryUtil;
	import roma.common.valueObject.*;
	import flash.utils.ByteArray;

	[Bindable]
	public class GmInfoBean
	{
		public function GmInfoBean(data:Object=null)
		{
			if (data!=null){
				if (data.lastLoginIp!=null) {
					this.lastLoginIp = data.lastLoginIp;
				}
				if (data.password!=null) {
					this.password = data.password;
				}
				if (data.rights!=null) {
					this.rights = data.rights;
				}
				if (data.userName!=null) {
					this.userName = data.userName;
				}
			}
		}
		

		public var lastLoginIp:String;
		public var password:String;
		public var rights:String;
		public var userName:String;

		public function copyToBe(target:GmInfoBean):void {
			target.lastLoginIp = this.lastLoginIp 
			target.password = this.password 
			target.rights = this.rights 
			target.userName = this.userName 
		}
		
		public function toBeObject():Object {
			var obj:Object = new Object();
			obj.lastLoginIp = this.lastLoginIp;
			obj.password = this.password;
			obj.rights = this.rights;
			obj.userName = this.userName;
			return obj;
		}

		public function toBeString(pre:String=""):String {
			var str:String = "";
			str += pre + "lastLoginIp = " + this.lastLoginIp + "\n" ;
			str += pre + "password = " + this.password + "\n" ;
			str += pre + "rights = " + this.rights + "\n" ;
			str += pre + "userName = " + this.userName + "\n" ;

			return str;  
		}
	}
}