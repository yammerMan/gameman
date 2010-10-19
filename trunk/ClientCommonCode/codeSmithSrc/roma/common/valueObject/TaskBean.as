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
	public class TaskBean
	{
		public function TaskBean(data:Object=null)
		{
			if (data!=null){
				if (data.id!=null) {
					this.id = data.id;
				}
				if (data.finish!=null) {
					this.finish = data.finish;
				}
			
				var n:int;
				if (data.answers) {
					for (n=0; n<data.answers.length; n++) {
						var _answers:QuestAnswerTargetBean = new QuestAnswerTargetBean(data.answers[n]);
						this.answersArray.addItem(_answers);
					}
				}
			
				if (data.targets) {
					for (n=0; n<data.targets.length; n++) {
						var _targets:TaskTargetBean = new TaskTargetBean(data.targets[n]);
						this.targetsArray.addItem(_targets);
					}
				}
			
			}
		}
		

		public var id:int;
		public var finish:Boolean;

		public var answersArray:ArrayCollection = new ArrayCollection();
		public var targetsArray:ArrayCollection = new ArrayCollection();
			
		public function getAnswers(index:int):QuestAnswerTargetBean {
			var res:QuestAnswerTargetBean = QuestAnswerTargetBean(this.answersArray[index]);
			return res; 
		}
		public function setAnswers(bean:QuestAnswerTargetBean, index:int):void {
			this.answersArray[index] = bean;
		}
		public function getTargets(index:int):TaskTargetBean {
			var res:TaskTargetBean = TaskTargetBean(this.targetsArray[index]);
			return res; 
		}
		public function setTargets(bean:TaskTargetBean, index:int):void {
			this.targetsArray[index] = bean;
		}

		public function copyToBe(target:TaskBean):void {
			target.id = this.id 
			target.finish = this.finish 
		}
		
		public function toBeObject():Object {
			var obj:Object = new Object();
			obj.id = this.id;
			obj.finish = this.finish;
			return obj;
		}

		public function toBeString(pre:String=""):String {
			var str:String = "";
			str += pre + "id = " + this.id + "\n" ;
			str += pre + "finish = " + this.finish + "\n" ;

			var i:int;
			for (i=0; i<this.answersArray.length; i++) {
				str += this.getAnswers(i).toBeString(pre + "answers[" + i + "].") ;
			}
			
			for (i=0; i<this.targetsArray.length; i++) {
				str += this.getTargets(i).toBeString(pre + "targets[" + i + "].") ;
			}
			

			return str;  
		}
	}
}