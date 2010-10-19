package animation
{
	import mx.core.UIComponent;
	
	public class RoleWorkAniLayer extends UIComponent
	{ 
		private var rolePlayerAry:Array = new Array(); 
		private var foodWorkerPlayer:AniPlayer = new AniPlayer(AnimationManager.roleAni.foodWorkerAni);
		private var woodWorkerPlayer:AniPlayer = new AniPlayer(AnimationManager.roleAni.woodWorkerAni);
		private var stoneWorkerPlayer:AniPlayer = new AniPlayer(AnimationManager.roleAni.stoneWorkerAni);
		private var ironWorkerPlayer:AniPlayer = new AniPlayer(AnimationManager.roleAni.ironWorkerAni);
		
		public function RoleWorkAniLayer()
		{
			super();
			this.initRoleAniPlayer();
		}
		
		private function initRoleAniPlayer():void{
			var aniAry:Array = [[this.foodWorkerPlayer,[16,301]],[this.woodWorkerPlayer,[907,194]],[this.stoneWorkerPlayer,[593,8]],[this.ironWorkerPlayer,[854,70]]];
			for(var i:int = 0;i<aniAry.length;i++){
				var container:RoleContainer = new RoleContainer(aniAry[i][0]);
				container.x = aniAry[i][1][0];
				container.y = aniAry[i][1][1];
				this.rolePlayerAry.push(container);
				this.addChild(container);
			}
		}
		
		public function roleAniPlay():void{
			for(var i:int=0;i<this.rolePlayerAry.length;i++){
				RoleContainer(this.rolePlayerAry[i]).drawToRoleAniData();
			}
		}
	}
}