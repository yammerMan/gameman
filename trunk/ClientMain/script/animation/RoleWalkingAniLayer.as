package animation
{
	import flash.display.Sprite;
	import flash.utils.Dictionary;
	
	import mx.core.UIComponent;

	public class RoleWalkingAniLayer extends UIComponent
	{	
		private var workerWalkingPlayer:AniPlayer = new AniPlayer(AnimationManager.roleAni.workerWalking);
		private var workerWalkingPlayer1:AniPlayer = new AniPlayer(AnimationManager.roleAni.workerWalking1);
		private var workerWalkingPlayer11:AniPlayer = new AniPlayer(AnimationManager.roleAni.workerWalking1);

		private var workerWalkingPlayer2:AniPlayer = new AniPlayer(AnimationManager.roleAni.workerWalking2);
		private var workerWalkingPlayer3:AniPlayer = new AniPlayer(AnimationManager.roleAni.workerWalking3);
		private var workerWalkingPlayer33:AniPlayer = new AniPlayer(AnimationManager.roleAni.workerWalking3);
		
		private var foodWorkerWalking:AniPlayer = new AniPlayer(AnimationManager.roleAni.foodWorkerWalking);
		private var foodWorkerWalking1:AniPlayer = new AniPlayer(AnimationManager.roleAni.foodWorkerWalking1);
		
		private var woodWorkerWalking:AniPlayer = new AniPlayer(AnimationManager.roleAni.woodWorkerWalking);
		private var woodWorkerWalking1:AniPlayer = new AniPlayer(AnimationManager.roleAni.woodWorkerWalking1);

		private var stoneWorkerWalking:AniPlayer = new AniPlayer(AnimationManager.roleAni.stoneWorkerWalking);
		private var stoneWorkerWalking1:AniPlayer = new AniPlayer(AnimationManager.roleAni.stoneWorkerWalking1);

		private var ironWorkerWalking:AniPlayer = new AniPlayer(AnimationManager.roleAni.ironWorkerWalking);
		private var ironWorkerWalking1:AniPlayer = new AniPlayer(AnimationManager.roleAni.ironWorkerWalking1);
		
		private var womanWalking:AniPlayer = new AniPlayer(AnimationManager.roleAni.womanWalking);
		
		private var pointMap:Dictionary = new Dictionary();

		private var foodWorkerContainer:RoleContainer;
		private var woodWorkerContainer:RoleContainer;
		private var stoneWorkerContainer:RoleContainer;
		private var ironWorkerContainer:RoleContainer;
		
		private var womanWalkContainer:RoleContainer;
		
		private var isFoodhit:Boolean;
		private var isFoodhit1:Boolean;
		
		private var isIronhit:Boolean;
		private var isIronhit1:Boolean;
		
		private var pointAry:Array =[[[44,324],0x00ffff],[[102,381],0x00ffff],[[508,168],0x00ffff],
									[[668,10],0x0000ff],[[580,80],0x0000ff],
									[[860,235],0xff00ff],[[626,108],0xff00ff],
									[[820,50],0xff0000],[[750,10],0xff0000],[[610,110],0xff0000]];
						
		public static var instance:RoleWalkingAniLayer;
									
		public function RoleWalkingAniLayer()
		{
			super();
			inithitTestPoint();
			initWalkingRolePlayer();
			instance = this;
		}
		
		public static function getInstance():RoleWalkingAniLayer{
			if(instance==null){
				instance = new RoleWalkingAniLayer();
			}
			
			return instance;
		}
		
		private function initWalkingRolePlayer():void{
			this.foodWorkerContainer = new RoleContainer(this.foodWorkerWalking,0.5,1);
			this.foodWorkerContainer.x =44;
			this.foodWorkerContainer.y =324;
			this.addChild(this.foodWorkerContainer);
			
			this.stoneWorkerContainer = new RoleContainer(this.stoneWorkerWalking,-1,0.5);
			this.stoneWorkerContainer.x = 668;
			this.stoneWorkerContainer.y = 10;
			this.addChild(this.stoneWorkerContainer);
			
			this.woodWorkerContainer = new RoleContainer(this.woodWorkerWalking1,-1,-0.5);
			this.woodWorkerContainer.x = 840;
			this.woodWorkerContainer.y = 195;
			this.addChild(this.woodWorkerContainer);
			
			this.ironWorkerContainer = new RoleContainer(this.ironWorkerWalking1,-1,-0.5);
			this.ironWorkerContainer.x =800;
			this.ironWorkerContainer.y = 25;
			this.addChild(this.ironWorkerContainer);
			
			this.womanWalkContainer = new RoleContainer(this.womanWalking);
			this.womanWalkContainer.x =380;
			this.womanWalkContainer.y= 220;
			//this.addChild(this.womanWalkContainer);	
		}
		
		public function resetWalkingRoleCoor():void{
			this.foodWorkerContainer.x =44;
			this.foodWorkerContainer.y =324;
			this.foodWorkerContainer.changeRoleAni(foodWorkerWalking,0.5,1);

			this.stoneWorkerContainer.x = 668;
			this.stoneWorkerContainer.y = 10;
			this.stoneWorkerContainer.changeRoleAni(stoneWorkerWalking,-1,0.5);

			this.woodWorkerContainer.x = 840;
			this.woodWorkerContainer.y = 195;
			this.woodWorkerContainer.changeRoleAni(woodWorkerWalking1,-1,-0.5);

			this.ironWorkerContainer.x =800;
			this.ironWorkerContainer.y = 25;
			this.ironWorkerContainer.changeRoleAni(ironWorkerWalking1,-1,-0.5);
		}
		
		private function inithitTestPoint():void{
			for(var i:int =0;i<this.pointAry.length;i++){
				this.drawhitTestPoint(this.pointAry[i][0][0],this.pointAry[i][0][1],this.pointAry[i][1],i);	
			}
		}
		
		public function roleWalkingPlay():void{
			this.foodWorkerWalkPlayer();
			this.woodWorkerWalkPlayer();
			this.stoneWorkerWalkPlayer();
			this.ironWorkerWalkPlayer();
			
			//this.womanWalkContainer.drawToRoleAniData();
		}
		
		/**
		 *粮食工人走动 
		 */		
		private function foodWorkerWalkPlayer():void{
			if(this.foodWorkerContainer.hitTestObject(this.pointMap["sprite0"])){
				if(this.foodWorkerContainer.getRoleAni() != this.foodWorkerWalking){
					this.foodWorkerContainer.changeRoleAni(this.foodWorkerWalking,0.5,1);
				}
				this.isFoodhit = false;
				this.isFoodhit1 = false;
			}
			
			if(this.foodWorkerContainer.hitTestObject(this.pointMap["sprite1"])){
				this.foodWorkerContainer.changeRoleAni(this.foodWorkerWalking1,1,-0.5);
				this.isFoodhit = true;
				
				if(this.isFoodhit && this.isFoodhit1){
					this.foodWorkerContainer.changeRoleAni(this.workerWalkingPlayer2,-1,-0.5);
				}
			}
			
			if(this.foodWorkerContainer.hitTestObject(this.pointMap["sprite2"])){
				this.foodWorkerContainer.changeRoleAni(this.workerWalkingPlayer,-1,0.5);
				this.isFoodhit1 = true; 
			}			

			this.foodWorkerContainer.drawToRoleAniData();
		}
		
		/**
		 *伐木工人走动 
		 */		
		private function woodWorkerWalkPlayer():void{
			if(this.woodWorkerContainer.hitTestObject(this.pointMap["sprite5"])){
				if(this.woodWorkerContainer.getRoleAni() != this.woodWorkerWalking1){
					this.woodWorkerContainer.changeRoleAni(this.woodWorkerWalking1,-1,-0.5);
				}
			}

			if(this.woodWorkerContainer.hitTestObject(this.pointMap["sprite6"])){
				this.woodWorkerContainer.changeRoleAni(this.workerWalkingPlayer3,1,0.5);				
			}

			this.woodWorkerContainer.drawToRoleAniData();
		}		
		
		/**
		 *石头工人走动 
		 */		
		private function stoneWorkerWalkPlayer():void{
			if(this.stoneWorkerContainer.hitTestObject(this.pointMap["sprite3"])){
				if(this.stoneWorkerContainer.getRoleAni() != this.stoneWorkerWalking){
					this.stoneWorkerContainer.changeRoleAni(this.stoneWorkerWalking,-1,0.5);
				}
			}
			
			if(this.stoneWorkerContainer.hitTestObject(this.pointMap["sprite4"])){
				this.stoneWorkerContainer.changeRoleAni(this.workerWalkingPlayer1,1,-0.5);			
			}

			this.stoneWorkerContainer.drawToRoleAniData();
		}

		/**
		 *铁矿工人走动 
		 */		
		private function ironWorkerWalkPlayer():void{
			if(this.ironWorkerContainer.hitTestObject(this.pointMap["sprite7"])){
				if(this.ironWorkerContainer.getRoleAni() != this.ironWorkerWalking){
					this.ironWorkerContainer.changeRoleAni(this.ironWorkerWalking1,-1,-0.5);
				}
				this.isIronhit = false;
				this.isIronhit1 = false;
			}
			
			if(this.ironWorkerContainer.hitTestObject(this.pointMap["sprite8"])){
				this.ironWorkerContainer.changeRoleAni(this.ironWorkerWalking,-1,0.5);
				this.isIronhit = true;
				
				if(this.isIronhit && this.isIronhit1){
					this.ironWorkerContainer.changeRoleAni(this.workerWalkingPlayer33,1,0.5);
				}
			}
			
			if(this.ironWorkerContainer.hitTestObject(this.pointMap["sprite9"])){
				this.ironWorkerContainer.changeRoleAni(this.workerWalkingPlayer11,1,-0.5);
				this.isIronhit1 = true;
			}
			
			this.ironWorkerContainer.drawToRoleAniData();
		}
		
		private function drawhitTestPoint(xPoint:int,yPoint:int,color:uint,i:int):void{
			var sprite:Sprite = new Sprite();
			sprite.graphics.beginFill(color);
			sprite.graphics.drawRect(0,0,10,10);
			sprite.graphics.endFill();
			sprite.x = xPoint;
			sprite.y = yPoint;
			sprite.alpha = 0;
			sprite.name = "sprite"+i;
			this.pointMap[sprite.name] = sprite;
			this.addChild(sprite);
		}
		
		public function getFoodWkCt():RoleContainer{
			return this.foodWorkerContainer;
		}
		
		public function getWoodsWkCt():RoleContainer{
			return this.woodWorkerContainer;
		}

		public function getIronsWkCt():RoleContainer{
			return this.ironWorkerContainer;
		}
		
		public function getStonesWkCt():RoleContainer{
			return this.stoneWorkerContainer;
		}
	}
}