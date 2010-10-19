package roma.war.data.actions
{
	import roma.common.constants.BattleConstants;
	
	public class ActionATK extends ActionItem
	{
		public function ActionATK(round:Number)
		{
			super(round);
		}
		
		public function get isArrowATK():Boolean{
			return k1 == BattleConstants.KEY_ARROW_TOWER;
		}
		public function get isRockATK():Boolean{
			return k1 == BattleConstants.KEY_ROCK_FALL;
		}
		public function get isTrapATK():Boolean{
			return k1 == BattleConstants.KEY_TRAP;
		}
		
		public function get isATKArrow():Boolean{
			return k2 == BattleConstants.KEY_ARROW_TOWER;
		}
		public function get isATKRock():Boolean{
			return k2 == BattleConstants.KEY_ROCK_FALL;
		}
		public function get isATKTrap():Boolean{
			return k2 == BattleConstants.KEY_TRAP;
		}
		
		public function get isATKWall():Boolean{
			return k2 == BattleConstants.KEY_WALL;
		}
		
		public function get k1():Number{
			return contents[1]
		}
		public function get p1():Number{
			return contents[2]			
		}
		public function get k2():Number{
			return contents[3]			
		}
		public function get p2():Number{
			return contents[4]			
		}
		public function get mode():Number{
			return contents[5]
		}
		public function get dmg():Number{
			return contents[6]			
		}
		
	}
}