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
	public class LetterBean
	{
		public function LetterBean(data:Object=null)
		{
			if (data!=null){
				if (data.content!=null) {
					this.content = data.content;
				}
				if (data.isRead!=null) {
					this.isRead = data.isRead;
				}
				if (data.mailId!=null) {
					this.mailId = data.mailId;
				}
				if (data.mailType!=null) {
					this.mailType = data.mailType;
				}
				if (data.md5Key!=null) {
					this.md5Key = data.md5Key;
				}
				if (data.receiveTime!=null) {
					this.receiveTime = data.receiveTime;
				}
				if (data.receiver!=null) {
					this.receiver = data.receiver;
				}
				if (data.sender!=null) {
					this.sender = data.sender;
				}
				if (data.title!=null) {
					this.title = data.title;
				}
				if (data.selected!=null) {
					this.selected = data.selected;
				}
			}
		}
		

		public var content:String;
		public var isRead:int;
		public var mailId:String;
		public var mailType:int;
		public var md5Key:String;
		public var receiveTime:Number;
		public var receiver:String;
		public var sender:String;
		public var title:String;
		public var selected:Boolean;

		public function copyToBe(target:LetterBean):void {
			target.content = this.content 
			target.isRead = this.isRead 
			target.mailId = this.mailId 
			target.mailType = this.mailType 
			target.md5Key = this.md5Key 
			target.receiveTime = this.receiveTime 
			target.receiver = this.receiver 
			target.sender = this.sender 
			target.title = this.title 
			target.selected = this.selected 
		}
		
		public function toBeObject():Object {
			var obj:Object = new Object();
			obj.content = this.content;
			obj.isRead = this.isRead;
			obj.mailId = this.mailId;
			obj.mailType = this.mailType;
			obj.md5Key = this.md5Key;
			obj.receiveTime = this.receiveTime;
			obj.receiver = this.receiver;
			obj.sender = this.sender;
			obj.title = this.title;
			obj.selected = this.selected;
			return obj;
		}

		public function toBeString(pre:String=""):String {
			var str:String = "";
			str += pre + "isRead = " + this.isRead + "\n" ;
			str += pre + "mailId = " + this.mailId + "\n" ;
			str += pre + "mailType = " + this.mailType + "\n" ;
			str += pre + "md5Key = " + this.md5Key + "\n" ;
			str += pre + "receiveTime = " + this.receiveTime + "\n" ;
			str += pre + "receiver = " + this.receiver + "\n" ;
			str += pre + "sender = " + this.sender + "\n" ;
			str += pre + "title = " + this.title + "\n" ;
			str += pre + "selected = " + this.selected + "\n" ;

			return str;  
		}
	}
}