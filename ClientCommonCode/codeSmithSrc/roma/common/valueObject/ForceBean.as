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
	public class ForceBean
	{
		public function ForceBean(data:Object=null)
		{
			if (data!=null){
				if (data.castleFieldId!=null) {
					this.castleFieldId = data.castleFieldId;
				}
				if (data.castleName!=null) {
					this.castleName = data.castleName;
				}
				if (data.heroManLevel!=null) {
					this.heroManLevel = data.heroManLevel;
				}
				if (data.king!=null) {
					this.king = data.king;
				}
			
				var n:int;
				if (data.techs) {
					for (n=0; n<data.techs.length; n++) {
						var _techs:PairValueBean = new PairValueBean(data.techs[n]);
						this.techsArray.addItem(_techs);
					}
				}
			
				if (data.troops) {
					for (n=0; n<data.troops.length; n++) {
						var _troops:HeroTroopBean = new HeroTroopBean(data.troops[n]);
						this.troopsArray.addItem(_troops);
					}
				}
			
			}
		}
		

		public var castleFieldId:int;
		public var castleName:String;
		public var heroManLevel:int;
		public var king:String;

		public var techsArray:ArrayCollection = new ArrayCollection();
		public var troopsArray:ArrayCollection = new ArrayCollection();
			
		public function getTechs(index:int):PairValueBean {
			var res:PairValueBean = PairValueBean(this.techsArray[index]);
			return res; 
		}
		public function setTechs(bean:PairValueBean, index:int):void {
			this.techsArray[index] = bean;
		}
		public function getTroops(index:int):HeroTroopBean {
			var res:HeroTroopBean = HeroTroopBean(this.troopsArray[index]);
			return res; 
		}
		public function setTroops(bean:HeroTroopBean, index:int):void {
			this.troopsArray[index] = bean;
		}

		public function copyToBe(target:ForceBean):void {
			target.castleFieldId = this.castleFieldId 
			target.castleName = this.castleName 
			target.heroManLevel = this.heroManLevel 
			target.king = this.king 
		}
		
		public function toBeObject():Object {
			var obj:Object = new Object();
			obj.castleFieldId = this.castleFieldId;
			obj.castleName = this.castleName;
			obj.heroManLevel = this.heroManLevel;
			obj.king = this.king;
			return obj;
		}

		public function toBeString(pre:String=""):String {
			var str:String = "";
			str += pre + "castleFieldId = " + this.castleFieldId + "\n" ;
			str += pre + "castleName = " + this.castleName + "\n" ;
			str += pre + "heroManLevel = " + this.heroManLevel + "\n" ;
			str += pre + "king = " + this.king + "\n" ;

			var i:int;
			for (i=0; i<this.techsArray.length; i++) {
				str += this.getTechs(i).toBeString(pre + "techs[" + i + "].") ;
			}
			
			for (i=0; i<this.troopsArray.length; i++) {
				str += this.getTroops(i).toBeString(pre + "troops[" + i + "].") ;
			}
			

			return str;  
		}
	}
}