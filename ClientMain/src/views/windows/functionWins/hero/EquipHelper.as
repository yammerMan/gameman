package views.windows.functionWins.hero
{
	import flash.events.Event;
	import flash.utils.Dictionary;
	
	import mx.collections.ArrayCollection;
	
	import roma.common.action.ControllerFactory;
	import roma.common.constants.HeroManConstants;
	import roma.common.controller.equip.PlayerEquipResponse;
	import roma.common.valueObject.EquipBean;
	import roma.common.valueObject.EquipValueBean;
	import roma.logic.object.hero.HeroObj;
	import roma.message.EvtDispacther;
	import roma.util.MultiLang;
	
	import views.spreadUI.MyAlert;
	
	public class EquipHelper
	{
		public static const ITEM_TYPE_EQUIPS:int = 7;
		public static var instance:EquipHelper=new EquipHelper();
		public var curSelectEquip:EquipBean;
		private var equipsArray:ArrayCollection=new ArrayCollection();
		private var playerEquipsArray:ArrayCollection=new ArrayCollection();
		public var needCallBack:Function=null;
		public var openEquipDictionary:Dictionary=new Dictionary();
		public function EquipHelper()
		{
			openEquipDictionary[HeroHelper.OUTFIT_TYPE_HEAD]=false;
			openEquipDictionary[HeroHelper.OUTFIT_TYPE_NECKLACE]=false;
			openEquipDictionary[HeroHelper.OUTFIT_TYPE_CLOSE]=false;
			openEquipDictionary[HeroHelper.OUTFIT_TYPE_SHOES]=false;
			openEquipDictionary[HeroHelper.OUTFIT_TYPE_LEFTHAND]=false;
			openEquipDictionary[HeroHelper.OUTFIT_TYPE_RIGHTHAND]=false;
			openEquipDictionary[HeroHelper.OUTFIT_TYPE_MOUNTS]=false;
			openEquipDictionary[HeroHelper.OUTFIT_TYPE_RING]=false;
			openEquipDictionary[HeroHelper.OUTFIT_TYPE_CAESTUS]=false;
			openEquipDictionary[HeroHelper.OUTFIT_TYPE_ACCESSORIES]=false;
		}
		public function setHeroEuips(arr:ArrayCollection):void{
			//this.equipsArray=arr;
			this.equipsArray.removeAll();
			for each(var equip:EquipBean in arr){
				equip.name=MultiLang.getEquipString(equip.type+".name");
				equip.funcDesc=MultiLang.getEquipString(equip.type+".funcDesc");
				equip.itemDesc=MultiLang.getEquipString(equip.type+".itemDesc");
				this.equipsArray.addItem(equip);
				
			}
			for each (var bean:EquipBean in this.equipsArray ) {
				openEquipDictionary[bean.part]=true;
			}
			
		}
		
		public function getHeroEuips():ArrayCollection{
			if(equipsArray.length>0){
				sortArray(equipsArray);
			}
			return equipsArray;
		}
		
		public function getEquipsInShop():ArrayCollection{
			var arr:ArrayCollection=getHeroEuips();
			var shopArr:ArrayCollection=new ArrayCollection();
			if(arr.length>0){
				for each(var p:EquipBean in arr){
					if(p.canBuy){
						shopArr.addItem(p);
					}
				}
			}
			return shopArr;
		}
		
		public function getPlayerEquipsArray():ArrayCollection{
			return this.playerEquipsArray;
		}
		
		private function sortArray(arr:ArrayCollection):void{
			if(arr.length<=1){
				return;
			}
			for(var i:int=0;i<arr.length;i++){
				for(var j:int=0;j<arr.length-1-i;j++){
					if(EquipBean(arr.getItemAt(j)).sort>EquipBean(arr.getItemAt(j+1)).sort){
						var tempBean:EquipBean = EquipBean(arr.getItemAt(j));
						arr.setItemAt(arr.getItemAt(j+1),j);
						arr.setItemAt(tempBean,j+1);
					}
					else{
						continue;
					}
				}
			}
		}
		
		public function getPlayerEquipBeanById(id:String):EquipValueBean {
			for each (var bean:EquipValueBean in this.playerEquipsArray ) {
				if (bean.typeId == id) {
					return bean;
				}
			}
			return null;
		}
		public function getPlayerEquip():void{
			ControllerFactory.getInstance().getEquipController().getPlayerEquips(getPlayerEquipCallBack,false);
		}
		
		private function getPlayerEquipCallBack(event:PlayerEquipResponse):void{
			if(event.isSuccess()){
				this.playerEquipsArray=event.equipsArray;
				EvtDispacther.instance.dispatchEvent(new Event(EvtDispacther.HERO_EQUIP_CHANGE));	
			}else{
				MyAlert.showError(event);
			}
		}
		
		public function getEquipsBeanById(id:String):EquipBean{
			for each(var bean:EquipBean in equipsArray){
				if(bean.type==id){
					return bean;
				}
			}
			return null;
		}
		
		public function getAllEquipsBeanToTarget(arr:ArrayCollection):void{
			arr.removeAll();
			if(playerEquipsArray.length>0&&equipsArray.length>0){
				for each(var p:EquipValueBean in playerEquipsArray){
					if(p.value>0){
						for(var i:int=0;i<p.value;i++){
							if(EquipHelper.instance.getEquipsBeanById(p.typeId)!=null){
								arr.addItem(EquipHelper.instance.getEquipsBeanById(p.typeId));
							}
						}
					}
				}
			}
		}
		
		
		public function canHandleEquip(hero:HeroObj):Boolean{
			var can:Boolean=false;
			if(hero.isInCastle || hero.heroInfo.status == HeroManConstants.STATUS_GROWTH){
				can=true;
			}else{
				MyAlert.show(MultiLang.msg('hero.notInCastle.tips'));
			}
			return can;
		}

	}
}