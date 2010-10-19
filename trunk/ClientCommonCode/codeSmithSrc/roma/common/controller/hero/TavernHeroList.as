/**
* 生成时间 1 
*/
package roma.common.controller.hero
{
	import framework.game.BaseResponse;
	import roma.common.valueObject.*;
	import mx.collections.ArrayCollection;
	import framework.util.CopyAryUtil;
	import flash.utils.ByteArray;
	
	public class TavernHeroList extends BaseResponse
	{
		public function TavernHeroList(type:String, data:Object,bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.setResponseData(data);
				if (data.remainTime!=null) {
					this.remainTime = data.remainTime;
				}
				if (data.success!=null) {
					this.success = data.success;
				}
			
				var n:int;
				if (data.tavernHeros) {
					for (n=0; n<data.tavernHeros.length; n++) {
						var _tavernHeros:HeroInfoBean = new HeroInfoBean(data.tavernHeros[n]);
						this.tavernHerosArray.addItem(_tavernHeros);
					}
				}
			
		}

		public var remainTime:Number;
		public var success:Boolean;

		public var tavernHerosArray:ArrayCollection = new ArrayCollection();
			
		public function getTavernHeros(index:int):HeroInfoBean {
			var res:HeroInfoBean = HeroInfoBean(this.tavernHerosArray[index]);
			return res; 
		}
		public function setTavernHeros(bean:HeroInfoBean, index:int):void {
			this.tavernHerosArray[index] = bean;
		}

		public function copyToBe(target:TavernHeroList):void {
			target.remainTime = this.remainTime 
			target.success = this.success 
		}
		
		public function toBeObject():Object {
			var obj:Object = new Object();
			obj.remainTime = this.remainTime;
			obj.success = this.success;
			return obj;
		}

		public override function toBeString(pre:String=""):String {
			var str:String = "---- TavernHeroList ----\n"  + this.toBeErrorString();
			str += pre + "remainTime = " + this.remainTime + "\n" ;
			str += pre + "success = " + this.success + "\n" ;

			var i:int;
			for (i=0; i<this.tavernHerosArray.length; i++) {
				str += this.getTavernHeros(i).toBeString(pre + "tavernHeros[" + i + "].") ;
			}
			

			return str;  
		}
	}
}