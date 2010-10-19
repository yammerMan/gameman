package animation.aniSet
{
	import animation.AnimationManager;
	import animation.BaseAnimationData;
	import animation.IAniPlayer;
	
	import flash.utils.Dictionary;
	
	import roma.common.constants.FieldConstant;
	
	public class FieldAniSetManager
	{
		public static var instance:FieldAniSetManager = new FieldAniSetManager();
		
		private var castelAry:Array = new Array(4);
		private var campAry:Array = new Array(4);
		private var desertAry:Array = new Array(3);
		private var forestAry:Array = new Array(3);
		private var hillAry:Array = new Array(3);
		
		private var aniMap:Array = new Array();
		
		private var dict:Dictionary = new Dictionary();
		
		public function FieldAniSetManager() {
			this.castelAry[0] = AnimationManager.fieldAni.castle1;
			this.castelAry[1] = AnimationManager.fieldAni.castle2;
			this.castelAry[2] = AnimationManager.fieldAni.castle3;
			this.castelAry[3] = AnimationManager.fieldAni.castle4;
			
			this.desertAry[0] = AnimationManager.fieldAni.desert1;
			this.desertAry[1] = AnimationManager.fieldAni.desert2;
			this.desertAry[2] = AnimationManager.fieldAni.desert3;
			
			this.forestAry[0] = AnimationManager.fieldAni.forest1;
			this.forestAry[1] = AnimationManager.fieldAni.forest2;
			this.forestAry[2] = AnimationManager.fieldAni.forest3;
			
			this.hillAry[0] = AnimationManager.fieldAni.hill1;
			this.hillAry[1] = AnimationManager.fieldAni.hill2;
			this.hillAry[2] = AnimationManager.fieldAni.hill3;
			
			this.dict[FieldConstant.DESERT_TYPE] = this.desertAry;
			this.dict[FieldConstant.TYPE_TREES] = this.forestAry;
			this.dict[FieldConstant.HILL_TYPE] = this.hillAry;
			this.dict[FieldConstant.TYPE_CITY] = this.castelAry;

			this.aniMap[FieldConstant.DESERT_TYPE] = AnimationManager.fieldAni.desert1;
			this.aniMap[FieldConstant.DESERT_TYPE +1] = AnimationManager.fieldAni.desert2;
			this.aniMap[FieldConstant.DESERT_TYPE +2] = AnimationManager.fieldAni.desert3;
			
			this.aniMap[FieldConstant.HILL_TYPE] = AnimationManager.fieldAni.hill1;
			this.aniMap[FieldConstant.HILL_TYPE +1] = AnimationManager.fieldAni.hill2;
			this.aniMap[FieldConstant.HILL_TYPE +2] = AnimationManager.fieldAni.hill3;
			
			this.aniMap[FieldConstant.TYPE_TREES] = AnimationManager.fieldAni.forest1;
			this.aniMap[FieldConstant.TYPE_TREES +1] = AnimationManager.fieldAni.forest2;
			this.aniMap[FieldConstant.TYPE_TREES +2] = AnimationManager.fieldAni.forest3;
		}

		public function getCastleAniByLevel(level:int):BaseAniSetPlayer {
//  		var i:int = 0;
//			if (level>FieldConstant.LEVEL2) {
//				i = 2;
//			} else if (level > FieldConstant.LEVEL1) {
//				i = 1;
//			}
//			
//			if (level == FieldConstant.MAX_LEVEL) {
//				i = 3;
//			}

			var res:BaseAniSetPlayer = new BaseAniSetPlayer();
			res.addAni(BaseAnimationData(this.castelAry[level]));
			
  			if(level==0){
				res.addAni(AnimationManager.fieldAni.battleFumeAni,59,8);
				res.addAni(AnimationManager.fieldAni.battleFumeAni,31,5);
			}else if(level ==1){
				res.addAni(AnimationManager.fieldAni.battleFumeAni,45,8);
				res.addAni(AnimationManager.fieldAni.battleFumeAni,10,-8);
				res.addAni(AnimationManager.fieldAni.battleFumeAni,69,-5);
			}else if(level==2){
				res.addAni(AnimationManager.fieldAni.battleFumeAni,50,3);
				res.addAni(AnimationManager.fieldAni.battleFumeAni,14,-13);
				res.addAni(AnimationManager.fieldAni.battleFumeAni,79,-13);
			}else{
				res.addAni(AnimationManager.fieldAni.battleFumeAni,50,6);
				res.addAni(AnimationManager.fieldAni.battleFumeAni,4,-20);
				res.addAni(AnimationManager.fieldAni.battleFumeAni,68,-20);
				res.addAni(AnimationManager.fieldAni.battleFumeAni,89,-16);
			}
			
			return res;
		}
		
		public function getTrainingRoomAni():BaseAniSetPlayer{
			var res:BaseAniSetPlayer = new BaseAniSetPlayer();
			res.addAni(AnimationManager.fieldAni.trainingRoom);
			res.addAni(AnimationManager.fieldAni.battleFumeAni,55,-2);
			res.addAni(AnimationManager.fieldAni.battleFumeAni,20,-18);
			res.addAni(AnimationManager.fieldAni.battleFumeAni,79,-15);
			return res;
		}
		
		public function getKingsCastleAni():BaseAniSetPlayer{
			var res:BaseAniSetPlayer = new BaseAniSetPlayer();
			res.addAni(AnimationManager.fieldAni.kingsCastle);
			res.addAni(AnimationManager.fieldAni.battleFumeAni,55,-2);
			res.addAni(AnimationManager.fieldAni.battleFumeAni,20,-18);
			res.addAni(AnimationManager.fieldAni.battleFumeAni,79,-15);
			return res;
		}
		
		public function getRatterNpcAni():BaseAniSetPlayer{
			var res:BaseAniSetPlayer = new BaseAniSetPlayer();
			res.addAni(AnimationManager.fieldAni.ratterNpc);
			res.addAni(AnimationManager.fieldAni.battleFumeAni,50,6);
			res.addAni(AnimationManager.fieldAni.battleFumeAni,4,-20);
			res.addAni(AnimationManager.fieldAni.battleFumeAni,68,-20);
			res.addAni(AnimationManager.fieldAni.battleFumeAni,89,-16);
			return res;
		}
		
		public function getFootballFieldAni(type:int):BaseAniSetPlayer{
			var res:BaseAniSetPlayer = new BaseAniSetPlayer();
			res.addAni(AnimationManager.fieldAni.getFootballField(type));
			res.addAni(AnimationManager.fieldAni.battleFumeAni,55,-2);
			res.addAni(AnimationManager.fieldAni.battleFumeAni,20,-18);
			res.addAni(AnimationManager.fieldAni.battleFumeAni,79,-15);
			return res;
		}
		
		public function getFieldAniPlayerByComplexType(fieldType:int,fieldLevel:int):BaseAniSetPlayer {
			if (fieldLevel>0) {
				var obj:Object = this.aniMap[fieldLevel];
				if (obj!=null) {
					var res:BaseAniSetPlayer = new BaseAniSetPlayer();
					res.addAni(BaseAnimationData(obj));
 					if(fieldType == FieldConstant.TYPE_TREES){
						if(fieldLevel == 1){
							res.addAni(AnimationManager.fieldAni.battleFumeAni,53,-5);
						}else if(fieldLevel ==2){
							res.addAni(AnimationManager.fieldAni.battleFumeAni,38,0);
							res.addAni(AnimationManager.fieldAni.battleFumeAni,64,6);
						}else {
							res.addAni(AnimationManager.fieldAni.battleFumeAni,77,0);
							res.addAni(AnimationManager.fieldAni.battleFumeAni,26,0);
							res.addAni(AnimationManager.fieldAni.battleFumeAni,50,-17);
						}
					}else if(fieldType == FieldConstant.DESERT_TYPE){
						if(fieldLevel == 4){
							res.addAni(AnimationManager.fieldAni.battleFumeAni,45,5);
						}else if(fieldLevel ==5){
							res.addAni(AnimationManager.fieldAni.battleFumeAni,45,15);
							res.addAni(AnimationManager.fieldAni.battleFumeAni,75,3);
						}else {
							res.addAni(AnimationManager.fieldAni.battleFumeAni,71,10);
							res.addAni(AnimationManager.fieldAni.battleFumeAni,38,20);
						}
					
					}else if(fieldType == FieldConstant.HILL_TYPE){
						if(fieldLevel == 7){
							res.addAni(AnimationManager.fieldAni.battleFumeAni,60,0);
						}else if(fieldLevel ==8){
							res.addAni(AnimationManager.fieldAni.battleFumeAni,75,5);
							res.addAni(AnimationManager.fieldAni.battleFumeAni,47,-7);
						}else {
							res.addAni(AnimationManager.fieldAni.battleFumeAni,75,5);
							res.addAni(AnimationManager.fieldAni.battleFumeAni,29,13);
							res.addAni(AnimationManager.fieldAni.battleFumeAni,54,-29);
						}
					}
					return res;
				}
			}
			return null;
		}
		
		public function getAniPlayer(fieldType:int , level:int):IAniPlayer {
			var ary:Array = this.dict[fieldType] as Array;
			var i:int = 0;
			if (level>FieldConstant.LEVEL2) {
				i = 2;
			} else if (level > FieldConstant.LEVEL1) {
				i = 1;
			}
			
			if (level == FieldConstant.HIGHEST_LEVEL && fieldType == FieldConstant.TYPE_CITY ) {
				i = 3;
			}
			
			if (ary!=null) {
				var res:BaseAniSetPlayer = new BaseAniSetPlayer();
				res.addAni(BaseAnimationData(ary[i]));				
				return res;
			} else {
				return null;
			}						
		}
	}
}