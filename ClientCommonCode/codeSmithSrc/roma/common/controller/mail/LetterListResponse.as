/**
* 生成时间 1 
*/
package roma.common.controller.mail
{
	import framework.game.BaseResponse;
	import roma.common.valueObject.*;
	import mx.collections.ArrayCollection;
	import framework.util.CopyAryUtil;
	import flash.utils.ByteArray;
	
	public class LetterListResponse extends BaseResponse
	{
		public function LetterListResponse(type:String, data:Object,bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.setResponseData(data);
				if (data.mailType!=null) {
					this.mailType = data.mailType;
				}
				if (data.pageNo!=null) {
					this.pageNo = data.pageNo;
				}
				if (data.totalPage!=null) {
					this.totalPage = data.totalPage;
				}
				if (data.success!=null) {
					this.success = data.success;
				}
			
				var n:int;
				if (data.letters) {
					for (n=0; n<data.letters.length; n++) {
						var _letters:LetterBean = new LetterBean(data.letters[n]);
						this.lettersArray.addItem(_letters);
					}
				}
			
		}

		public var mailType:int;
		public var pageNo:int;
		public var totalPage:int;
		public var success:Boolean;

		public var lettersArray:ArrayCollection = new ArrayCollection();
			
		public function getLetters(index:int):LetterBean {
			var res:LetterBean = LetterBean(this.lettersArray[index]);
			return res; 
		}
		public function setLetters(bean:LetterBean, index:int):void {
			this.lettersArray[index] = bean;
		}

		public function copyToBe(target:LetterListResponse):void {
			target.mailType = this.mailType 
			target.pageNo = this.pageNo 
			target.totalPage = this.totalPage 
			target.success = this.success 
		}
		
		public function toBeObject():Object {
			var obj:Object = new Object();
			obj.mailType = this.mailType;
			obj.pageNo = this.pageNo;
			obj.totalPage = this.totalPage;
			obj.success = this.success;
			return obj;
		}

		public override function toBeString(pre:String=""):String {
			var str:String = "---- LetterListResponse ----\n"  + this.toBeErrorString();
			str += pre + "mailType = " + this.mailType + "\n" ;
			str += pre + "pageNo = " + this.pageNo + "\n" ;
			str += pre + "totalPage = " + this.totalPage + "\n" ;
			str += pre + "success = " + this.success + "\n" ;

			var i:int;
			for (i=0; i<this.lettersArray.length; i++) {
				str += this.getLetters(i).toBeString(pre + "letters[" + i + "].") ;
			}
			

			return str;  
		}
	}
}