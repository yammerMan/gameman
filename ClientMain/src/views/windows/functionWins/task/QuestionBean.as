package views.windows.functionWins.task
{
	import flash.xml.XMLNode;
	
	import mx.collections.ArrayCollection;
	import mx.logging.ILogger;
	import mx.logging.Log;
	import mx.resources.IResourceManager;
	import mx.resources.ResourceManager;
	
	public class QuestionBean
	{
		private var log:ILogger = Log.getLogger("views.windows.functionWins.task.QuestionBean");
		public var subject:String = "";
		public var isMul:Boolean = false;
		public var answersArray:ArrayCollection = new ArrayCollection();
		public var correctAnswers:String = "";
		
		private var rm:IResourceManager = ResourceManager.getInstance();
		private var taskId:int = 0;
		private var questionId:int = 0;
		
		public function QuestionBean(x:XMLNode,id:int,qid:int)
		{
			taskId = id;
			questionId = qid;
//			log.debug(x+" \n taskId "+id+" questionId "+qid);
			subject = rm.getString("questQuestions",id+"."+qid+".question");
//			log.debug("subject = "+subject);
			for each(var a:XMLNode in x.childNodes){
				if(a.nodeName == "answers"){
					isMul = checkIsMul(a);
					setAnswers(a);
				}
			}
		}
		
		/**
		 * 是否为多问题
		 */ 
		private function checkIsMul(x:XMLNode):Boolean{
			var rightCount:int = 0;
			var isTrue:Boolean = false;
			for each(var a:XMLNode in x.childNodes){
				if(a.nodeName != null){
					if(a.attributes.isCorrect == "true"){
						rightCount ++;
					}
				}
			}
			if(rightCount >1){
				isTrue = true;
			}else{
				isTrue = false;
			}
			return isTrue;
		}
		
		
		private function setAnswers(x:XMLNode):void{
			var count:int = 0;
			for each(var x1:XMLNode in x.childNodes){
				if(x1.nodeName != null && x1.nodeName == "answer"){
					count ++;
					answersArray.addItem(rm.getString("questQuestions",taskId+"."+questionId+".answer."+count));
					if(x1.attributes.isCorrect == "true")
					correctAnswers += String(count);
				}
			}
		}
		
	}
}