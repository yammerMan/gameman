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
	public class PlayerDataBean
	{
		public function PlayerDataBean(data:Object=null)
		{
			if (data!=null){
				if (data.castleMapByteArray!=null) {
					this.castleMapByteArray = data.castleMapByteArray;
				}
				if (data.counter!=null) {
					this.counter = new CounterBean(data.counter);
				}
				if (data.playerInfo!=null) {
					this.playerInfo = new PlayerInfoDataBean(data.playerInfo);
				}
			
				var n:int;
				if (data.blocks) {
					for (n=0; n<data.blocks.length; n++) {
						var _blocks:FriendRelationBean = new FriendRelationBean(data.blocks[n]);
						this.blocksArray.addItem(_blocks);
					}
				}
			
				if (data.buffers) {
					for (n=0; n<data.buffers.length; n++) {
						var _buffers:BufferBean = new BufferBean(data.buffers[n]);
						this.buffersArray.addItem(_buffers);
					}
				}
			
				if (data.citys) {
					for (n=0; n<data.citys.length; n++) {
						var _citys:CityBean = new CityBean(data.citys[n]);
						this.citysArray.addItem(_citys);
					}
				}
			
				if (data.fieldCollectBeans) {
					for (n=0; n<data.fieldCollectBeans.length; n++) {
						var _fieldCollectBeans:FieldCollectBean = new FieldCollectBean(data.fieldCollectBeans[n]);
						this.fieldCollectBeansArray.addItem(_fieldCollectBeans);
					}
				}
			
				if (data.friends) {
					for (n=0; n<data.friends.length; n++) {
						var _friends:FriendRelationBean = new FriendRelationBean(data.friends[n]);
						this.friendsArray.addItem(_friends);
					}
				}
			
				if (data.items) {
					for (n=0; n<data.items.length; n++) {
						var _items:MaterialBean = new MaterialBean(data.items[n]);
						this.itemsArray.addItem(_items);
					}
				}
			
				if (data.otherArmys) {
					for (n=0; n<data.otherArmys.length; n++) {
						var _otherArmys:OtherArmyBean = new OtherArmyBean(data.otherArmys[n]);
						this.otherArmysArray.addItem(_otherArmys);
					}
				}
			
				if (data.postTransports) {
					for (n=0; n<data.postTransports.length; n++) {
						var _postTransports:PostTransportBean = new PostTransportBean(data.postTransports[n]);
						this.postTransportsArray.addItem(_postTransports);
					}
				}
			
				if (data.scoutPlayers) {
					for (n=0; n<data.scoutPlayers.length; n++) {
						var _scoutPlayers:ScoutPlayerBean = new ScoutPlayerBean(data.scoutPlayers[n]);
						this.scoutPlayersArray.addItem(_scoutPlayers);
					}
				}
			
				if (data.techs) {
					for (n=0; n<data.techs.length; n++) {
						var _techs:TechBean = new TechBean(data.techs[n]);
						this.techsArray.addItem(_techs);
					}
				}
			
			}
		}
		

		public var castleMapByteArray:ByteArray;
		public var counter:CounterBean;
		public var playerInfo:PlayerInfoDataBean;

		public var blocksArray:ArrayCollection = new ArrayCollection();
		public var buffersArray:ArrayCollection = new ArrayCollection();
		public var citysArray:ArrayCollection = new ArrayCollection();
		public var fieldCollectBeansArray:ArrayCollection = new ArrayCollection();
		public var friendsArray:ArrayCollection = new ArrayCollection();
		public var itemsArray:ArrayCollection = new ArrayCollection();
		public var otherArmysArray:ArrayCollection = new ArrayCollection();
		public var postTransportsArray:ArrayCollection = new ArrayCollection();
		public var scoutPlayersArray:ArrayCollection = new ArrayCollection();
		public var techsArray:ArrayCollection = new ArrayCollection();
			
		public function getBlocks(index:int):FriendRelationBean {
			var res:FriendRelationBean = FriendRelationBean(this.blocksArray[index]);
			return res; 
		}
		public function setBlocks(bean:FriendRelationBean, index:int):void {
			this.blocksArray[index] = bean;
		}
		public function getBuffers(index:int):BufferBean {
			var res:BufferBean = BufferBean(this.buffersArray[index]);
			return res; 
		}
		public function setBuffers(bean:BufferBean, index:int):void {
			this.buffersArray[index] = bean;
		}
		public function getCitys(index:int):CityBean {
			var res:CityBean = CityBean(this.citysArray[index]);
			return res; 
		}
		public function setCitys(bean:CityBean, index:int):void {
			this.citysArray[index] = bean;
		}
		public function getFieldCollectBeans(index:int):FieldCollectBean {
			var res:FieldCollectBean = FieldCollectBean(this.fieldCollectBeansArray[index]);
			return res; 
		}
		public function setFieldCollectBeans(bean:FieldCollectBean, index:int):void {
			this.fieldCollectBeansArray[index] = bean;
		}
		public function getFriends(index:int):FriendRelationBean {
			var res:FriendRelationBean = FriendRelationBean(this.friendsArray[index]);
			return res; 
		}
		public function setFriends(bean:FriendRelationBean, index:int):void {
			this.friendsArray[index] = bean;
		}
		public function getItems(index:int):MaterialBean {
			var res:MaterialBean = MaterialBean(this.itemsArray[index]);
			return res; 
		}
		public function setItems(bean:MaterialBean, index:int):void {
			this.itemsArray[index] = bean;
		}
		public function getOtherArmys(index:int):OtherArmyBean {
			var res:OtherArmyBean = OtherArmyBean(this.otherArmysArray[index]);
			return res; 
		}
		public function setOtherArmys(bean:OtherArmyBean, index:int):void {
			this.otherArmysArray[index] = bean;
		}
		public function getPostTransports(index:int):PostTransportBean {
			var res:PostTransportBean = PostTransportBean(this.postTransportsArray[index]);
			return res; 
		}
		public function setPostTransports(bean:PostTransportBean, index:int):void {
			this.postTransportsArray[index] = bean;
		}
		public function getScoutPlayers(index:int):ScoutPlayerBean {
			var res:ScoutPlayerBean = ScoutPlayerBean(this.scoutPlayersArray[index]);
			return res; 
		}
		public function setScoutPlayers(bean:ScoutPlayerBean, index:int):void {
			this.scoutPlayersArray[index] = bean;
		}
		public function getTechs(index:int):TechBean {
			var res:TechBean = TechBean(this.techsArray[index]);
			return res; 
		}
		public function setTechs(bean:TechBean, index:int):void {
			this.techsArray[index] = bean;
		}

		public function copyToBe(target:PlayerDataBean):void {
			target.castleMapByteArray = this.castleMapByteArray 
			if (counter!=null) {
				this.counter.copyToBe(target.counter)
			} else {
				target.counter = null;
			}
			if (playerInfo!=null) {
				this.playerInfo.copyToBe(target.playerInfo)
			} else {
				target.playerInfo = null;
			}
		}
		
		public function toBeObject():Object {
			var obj:Object = new Object();
			obj.castleMapByteArray = this.castleMapByteArray;
			obj.counter = this.counter.toBeObject();
			obj.playerInfo = this.playerInfo.toBeObject();
			return obj;
		}

		public function toBeString(pre:String=""):String {
			var str:String = "";
			if (counter!=null) {
				str += this.counter.toBeString(pre + "counter.") ;
			} else {
				str += pre + "counter = null\n" ;
			}
			if (playerInfo!=null) {
				str += this.playerInfo.toBeString(pre + "playerInfo.") ;
			} else {
				str += pre + "playerInfo = null\n" ;
			}

			var i:int;
			for (i=0; i<this.blocksArray.length; i++) {
				str += this.getBlocks(i).toBeString(pre + "blocks[" + i + "].") ;
			}
			
			for (i=0; i<this.buffersArray.length; i++) {
				str += this.getBuffers(i).toBeString(pre + "buffers[" + i + "].") ;
			}
			
			for (i=0; i<this.citysArray.length; i++) {
				str += this.getCitys(i).toBeString(pre + "citys[" + i + "].") ;
			}
			
			for (i=0; i<this.fieldCollectBeansArray.length; i++) {
				str += this.getFieldCollectBeans(i).toBeString(pre + "fieldCollectBeans[" + i + "].") ;
			}
			
			for (i=0; i<this.friendsArray.length; i++) {
				str += this.getFriends(i).toBeString(pre + "friends[" + i + "].") ;
			}
			
			for (i=0; i<this.itemsArray.length; i++) {
				str += this.getItems(i).toBeString(pre + "items[" + i + "].") ;
			}
			
			for (i=0; i<this.otherArmysArray.length; i++) {
				str += this.getOtherArmys(i).toBeString(pre + "otherArmys[" + i + "].") ;
			}
			
			for (i=0; i<this.postTransportsArray.length; i++) {
				str += this.getPostTransports(i).toBeString(pre + "postTransports[" + i + "].") ;
			}
			
			for (i=0; i<this.scoutPlayersArray.length; i++) {
				str += this.getScoutPlayers(i).toBeString(pre + "scoutPlayers[" + i + "].") ;
			}
			
			for (i=0; i<this.techsArray.length; i++) {
				str += this.getTechs(i).toBeString(pre + "techs[" + i + "].") ;
			}
			

			return str;  
		}
	}
}