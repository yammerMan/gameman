package roma.logic.object.buff
{
	import roma.common.valueObject.BufferBean;
	import roma.logic.GameContext;
	import roma.resource.ImgManager;
	import roma.util.MultiLang;
	
	[Bindable]
	public class BaseBuffObj
	{
		public var buffBean:BufferBean;
		
		public var desc:String;
		public var iconClass:Class;
		
		public function BaseBuffObj() {
			this.desc = MultiLang.msg("buff." + this.getClassName() + ".desc");
			if (this.isShow()) {
				this.iconClass = ImgManager.clazz("buff." + this.getClassName() + ".icon");
			}
		}
		
		/**
		 * 需要覆盖的方法，返回类名，多语言
		 */
		protected function getClassName():String {
			return "";
		}
		
		public function getPercent():int {
			if (this.buffBean.totalTime>0) {
				var per:Number = 100 - this.getRemainTimeSec() *100 / this.buffBean.totalTime;
				return int(per);
			} else {
				return 100;
			}
		}
		
		public function getRemainTimeSec():int {
			var rt:int = Number(this.buffBean.endTime - new Date().valueOf() + GameContext.instance.timeDis)/1000;
			if (rt<0) {
				rt = 0;
			}
			return rt;
		}
		
		/**
		 * 是否显示在城堡界面的左上方
		 */
		public function isShow():Boolean {
			return false;
		} 
		
		public function setBean(bean:BufferBean):void {
			if (this.buffBean ==null) {
				this.buffBean = bean;
			} else {
				bean.copyToBe(this.buffBean);
			}
		}
	}
}