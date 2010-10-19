package views.windows.functionWins.mail
{
	import flash.utils.Dictionary;
	
	import mx.collections.ArrayCollection;
	import mx.containers.Canvas;
	
	import roma.common.ResponseEvtDispatcher;
	import roma.common.action.ControllerFactory;
	import roma.common.constants.LetterConstant;
	import roma.common.controller.CommonResponse;
	import roma.common.controller.mail.LetterListResponse;
	import roma.common.controller.mail.LetterResponse;
	import roma.common.valueObject.LetterBean;
	import roma.util.MultiLang;
	
	import views.spreadUI.MyAlert;
	import views.windows.functionWins.mail.ReportUi.ReportManager;

	public class BaseMailCanvas extends Canvas
	{
		private static const page_size:int = 10;
		
		[Bindable]
		public var lookUpStr:String = MultiLang.msg("public.label.checkOut");
		[Bindable]
		public var lookUpCourseStr:String = MultiLang.msg("public.label.process");

		[Bindable]
		protected var cur_page:int = 1;                               //当前页
	
		[Bindable]
		protected var total_page:int = 1;                          //当前信箱的总页数
	
		[Bindable]
		protected var curLetterBean:LetterBean;
		
		[Bindable]
		protected var viewSelectedIndex:int = 0;
		
		[Bindable]
		protected var dataArr:ArrayCollection;                          //信的列表
	
		private var isSelectAll:Boolean = false;       
		protected var curMailIndex:int;    //当前所处的邮箱
		
		private var tempType:int;
		
		private var callBackFun:Function;

		public function BaseMailCanvas()
		{
			super();
			this.curMailIndex = LetterConstant.LETTER_RECEIVE;
		}
		
		/**
		 * 选择全部信件
		 */ 
		protected function onSelectAll():void{
			this.isSelectAll = !this.isSelectAll;
			if (this.dataArr!=null) {
				for each(var bean:LetterBean in this.dataArr) {
					bean.selected = this.isSelectAll;
			    }
			}
		}
	
		/**
		 * 删除选中的信件
		 */ 
		protected function onDelectMailSelected():void{
			if (this.dataArr!=null) {
				var str:String = "";
				for each(var b:LetterBean in this.dataArr) {
					if (b.selected) {
						if(str.length > 0){
							str += ",";
						}
						str += b.mailId;
					}						
				}
			}
			if (str.length>0){
				ControllerFactory.getInstance().getLetterController().deleteMails(this.tempType,str,onMailDelete);
			}
		}
	
		/**
		 * 删除信件返回
		 */ 
		private function onMailDelete(event:CommonResponse):void{
			if (event.isSuccess()){
				this.getMailFromServer();
				this.isSelectAll=false;
			} else {
				MyAlert.showError(event);
			}
		}
	
		public function refresh(type:int,fun:Function=null):void {
			this.isSelectAll=false;
			this.cur_page = 1;
			this.total_page = 1;
	    	this.curMailIndex = type;
	    	callBackFun = fun;
	    	ReportManager.instance.reportTitleDic = new Dictionary();
	    	this.getMailFromServer();
		}
	
		/**
		 * 在查看邮件时，点击了返回
		 */
		protected function back():void {
			this.viewSelectedIndex = 0;
			this.getMailFromServer();
		}
	    
	    /**
	    * 从服务器中读取数据
	    */
	    protected function getMailFromServer():void {
	    	this.viewSelectedIndex = 0;
	    	if (this.dataArr!=null) {
	    		this.dataArr.removeAll();
	    	}
	    	if (!ResponseEvtDispatcher.getInstance().sending) {
	    		this.tempType = this.curMailIndex;
	    	}
			ControllerFactory.getInstance().getLetterController().receiveLetterList(cur_page,curMailIndex,page_size,onReceiveMail);
	    }

		/**
		 * 接收信件列表返回
		 */ 
		protected function onReceiveMail(event:LetterListResponse):void{
			this.dataArr = event.lettersArray;
			this.total_page = event.totalPage;
			this.cur_page = event.pageNo;
			
			if(callBackFun != null)callBackFun.call(this,event.mailType);
		}

		/**
		 * 每页的切换
		 */ 
		protected function turnPage(p:int):void{
			isSelectAll=false;
			var n:int = cur_page;
			cur_page += p;
			if (cur_page >=1 && cur_page <= total_page) {
				getMailFromServer();
			} else {
				cur_page = n;
			}
		}
		
		protected function gotoTargetPage(page:int):void{
			if(page<=0){
				page=1;
			}
			if(page>this.total_page){
				page=total_page;
			}
			if (page>0 && page<=this.total_page) {
				this.cur_page = page;
				this.getMailFromServer();
			}
		}
		
		/**
		 * 调出信件详细信息
		 */ 
		public function onSeeAbout(bean:LetterBean):void{
			this.curLetterBean = bean;
			this.viewSelectedIndex = 1;
			ControllerFactory.getInstance().getLetterController().readLetter(bean.mailId,false,onReadMail);
		}

		/**
		 * 读信件返回
		 */ 
		protected function onReadMail(event:LetterResponse):void{
			this.curLetterBean.content = event.mailBean.content;
		}
	}
}