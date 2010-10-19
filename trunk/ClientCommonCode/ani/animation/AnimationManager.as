package animation
{
	import animation.aniSet.building.BuildingsAniSet;
	import animation.animationData.BuildingLevelBgAni;
	import animation.animationData.BuildingLevelDigitalAni;
	import animation.animationData.BuildingLevelDigitalAni1;
	import animation.animationData.BuildingSpaceAni;
	import animation.animationData.FieldAni;
	import animation.animationData.FlagAni;
	import animation.animationData.building.BuildingsAni;
	import animation.animationData.role.RoleAni;
	import animation.animationData.worldMap.CurCastleAni;
	
	
	public class AnimationManager
	{
		public static const buildings:BuildingsAni = new BuildingsAni();
		
		public static const buildingsSet:BuildingsAniSet = new BuildingsAniSet();
		
		public static const buildingLevelDigital:BaseAnimationData = new BuildingLevelDigitalAni();
		
		public static const buildingLevelDigital1:BaseAnimationData = new BuildingLevelDigitalAni1();
							
		public static const buildingLevelBg:BaseAnimationData = new BuildingLevelBgAni();
		
		public static const freeBuildingSpace:BaseAnimationData = new BuildingSpaceAni();
		
		public static const fieldAni:FieldAni = new FieldAni();
		
		public static const flagAni:FlagAni = new FlagAni();
		
		public static const curCastleAni:CurCastleAni = new CurCastleAni();

		public static const roleAni:RoleAni = new RoleAni();
	}
}
